## 使用 debian 手工搭建为透明代理的网关

### 配置 debian 系统设置
> 下面都是用 nano 作为文本编辑器来进行的，可以根据个人习惯，使用 `vi` 或 `vim` 进行。

#### 1.允许root远程登录
> 方便在其他设备上连接 SSH

```shell
nano /etc/ssh/sshd_config
# 写入以下配置
PermitRootLogin yes
PasswordAuthentication yes

# 应用
systemctl restart sshd
```
此时可以用别的终端登录debian了。

#### [可选] 配置命令缩写 ls
> 跳过也行，看个人习惯

```shell
nano ~/.bashrc
# 开启以下缩写
export LS_OPTIONS='--color=auto'
eval "$(dircolors)"
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -l'
alias l='ls $LS_OPTIONS -lA'

# 应用
source ~/.bashrc
```

#### 2.安装 iptables
> 必须安装iptables，后续会用 iptables 设定规则，外部传入的数据转发到 mihomo 上

`apt install -y iptables`

#### 3.[可选] 固定 IP、DNS、上游网关地址
> 本步骤可跳过，主要目的是配置静态IP，方便其他设备填写网关IP
> 
> 如果 debian 的 IP 已经是固定的，可以跳过此步骤。

```shell
# 配置 静态IP、上游网关地址
nano /etc/ssh/sshd_config
iface ens18 inet static
        address 192.168.2.230/24
        gateway 192.168.2.1

# 配置DNS
nano /etc/resolv.conf
nameserver 119.29.29.29
nameserver 223.5.5.5

# 重启网络
service networking restart
```

#### 4.开启转发，关闭IPv6
```shell
nano /etc/sysctl.conf
# 允许转发
net.ipv4.ip_forward=1
# 关闭ipv6
net.ipv6.conf.all.disable_ipv6=1

sysctl -p
```

### 配置mihomo
> 我们的配置目标是：
> mihomo 运行在 `/opt/mihomo` 目录下，配置文件、配置文件、启动脚本、重启脚本都在此目录下

#### 5.创建目录
```shell
mkdir /opt/mihomo
mkdir /opt/mihomo/ui

cd /opt/mihomo
```

注意，后续步骤，都是基于 `/opt/mihomo` 目录下操作的，下面操作之前，确保已经 `cd /opt/mihomo` 了。
#### 6.创建：重置数据包转发规则脚本 `net-reset`
> 主要目的： 重置 mihomo 作为透明代理时的 iptables 规则

```shell
#!/usr/bin/bash
# 删除旧的路由规则
ip rule del fwmark 666 table 666 || true
ip route del local 0.0.0.0/0 dev lo table 666 || true

# 清空和删除 NAT 表中的规则和用户定义的链
iptables -t nat -F
iptables -t nat -X

# 清空和删除 Mangle 表中的规则和特定链
iptables -t mangle -F
iptables -t mangle -X clash || true
iptables -t mangle -X clash_local || true
echo "iptables已重置!"
```

#### 7.创建：设置数据包转发规则脚本 `net-set`
> 主要目的： 配置 iptables 规则

> 此步骤要注意，`TPROXY_PORT=7895` 要和 yml 中的 `tproxy_port` 保持一致

```shell
#!/usr/bin/bash
TPROXY_PORT=7895 #【注意，要和下面的yml中的端口号保持一致】

echo "配置路由规则和iptables规则..."
# 创建路由规则，标记为 666 的流量使用 666 号路由表
ip rule add fwmark 666 lookup 666
# 在 666 号路由表中添加一条路由，将所有流量路由到本地回环接口
ip route add local 0.0.0.0/0 dev lo table 666

# 在 mangle 表中创建一个新的链 clash，用于处理流量标记和修改
iptables -t mangle -N clash

# 对于目标地址为局域网或保留地址的流量，直接返回，不做处理
iptables -t mangle -A clash -d 0.0.0.0/8 -j RETURN
iptables -t mangle -A clash -d 127.0.0.0/8 -j RETURN
iptables -t mangle -A clash -d 10.0.0.0/8 -j RETURN
iptables -t mangle -A clash -d 172.16.0.0/12 -j RETURN
iptables -t mangle -A clash -d 192.168.0.0/16 -j RETURN
iptables -t mangle -A clash -d 169.254.0.0/16 -j RETURN
iptables -t mangle -A clash -d 224.0.0.0/4 -j RETURN
iptables -t mangle -A clash -d 240.0.0.0/4 -j RETURN

# 将所有其他 TCP 和 UDP 流量重定向到 ${TPROXY_PORT} 端口，并打上标记 666
iptables -t mangle -A clash -p tcp -j TPROXY --on-port ${TPROXY_PORT} --tproxy-mark 666
iptables -t mangle -A clash -p udp -j TPROXY --on-port ${TPROXY_PORT} --tproxy-mark 666

# 将进入的所有流量通过 clash 链进行处理
iptables -t mangle -A PREROUTING -j clash

# 创建 clash_local 链，用于处理本机发出的流量
iptables -t mangle -N clash_local

# 对于本机发出的到内网或保留地址的流量，直接返回，不做处理
iptables -t mangle -A clash_local -d 0.0.0.0/8 -j RETURN
iptables -t mangle -A clash_local -d 127.0.0.0/8 -j RETURN
iptables -t mangle -A clash_local -d 10.0.0.0/8 -j RETURN
iptables -t mangle -A clash_local -d 172.16.0.0/12 -j RETURN
iptables -t mangle -A clash_local -d 192.168.0.0/16 -j RETURN
iptables -t mangle -A clash_local -d 169.254.0.0/16 -j RETURN
iptables -t mangle -A clash_local -d 224.0.0.0/4 -j RETURN
iptables -t mangle -A clash_local -d 240.0.0.0/4 -j RETURN

# 为本机发出的所有 TCP 和 UDP 流量打上标记 666
iptables -t mangle -A clash_local -p tcp -j MARK --set-mark 666
iptables -t mangle -A clash_local -p udp -j MARK --set-mark 666

# 为何注释掉：暂不需要这么做，我们用 root 身份启动 mihomo
# 对于由 clash 用户发出的流量，直接返回，以防止流量循环
# iptables -t mangle -A OUTPUT -p tcp -m owner --uid-owner clash -j RETURN
# iptables -t mangle -A OUTPUT -p udp -m owner --uid-owner clash -j RETURN

# 将本机发出的流量通过 clash_local 链进行处理
iptables -t mangle -A OUTPUT -j clash_local

# 为何注释掉：暂不需要这么做
# 允许本地网络路由( sysctl -w 临时修改 Linux 内核参数)
#sysctl -w net.ipv4.conf.all.route_localnet=1
# 将 ICMP（ping）请求的目标地址重定向到本地，以便返回结果
#iptables -t nat -A PREROUTING -p icmp -d 192.168.0.0/16 -j DNAT --to-destination 127.0.0.1

echo "路由规则、iptables规则已完成配置！"
```

#### 8.创建： 启动脚本 restart-mihomo
> 脚本目的：自动查找并关闭 mihomo 进程，清除所有 iptables 规则，重新设置 iptables 规则，并重新启动 mihomo

```shell
#!/usr/bin/bash
DIR="/opt/mihomo"
CORE="mihomo-linux-amd64"
RUNNER=${DIR}/${CORE}
LOG=${DIR}/log.log
YML=remix-all.yaml  #【注意】指定使用哪个 mihomo 配置

NET_RESET=${DIR}/net-reset
NET_SET=${DIR}/net-set

cd ${DIR}

echo "停止 ${RUNNER}"
PID=$(ps -ef | grep ${RUNNER} | grep -v 'grep' | awk 'NR==1 {print $2}')
if [ -n "$PID" ]; then
    kill -15 ${PID}
    echo "成功停止 ${PID}"
    cat /dev/null > ${LOG}
else
    echo "没有运行 mihomo"
fi

sleep 1
echo "重置 iptables 规则..."
${NET_RESET}

sleep 1
echo "配置 iptables 规则..."
${NET_SET}

sleep 1
echo "启动 mihomo... 配置为：${YML}"
nohup ${RUNNER} -d ${DIR} -f ${DIR}/${YML} >> ${LOG} 2>&1 &
echo "mihomo 启动完毕,日志 ${LOG}"
```

#### 9. mihomo 的配置文件 xxx.yml 中的核心部分

> 配置文档 https://wiki.metacubex.one/config/general/

```yml
port: 7890
socks-port: 7891
mixed-port: 7893
redir-port: 7892
tproxy-port: 7895 #【注意】配置tproxy端口，要和上面net-set中配置的 TPROXY_PORT=7895 保持同一个端口
interface-name: ens18 #配置出口网卡，可用 ip a 命令确定物理网卡名称
ipv6: false
bind-address: "*"
allow-lan: true
mode: rule
log-level: debug
external-controller: 0.0.0.0:9090
find-process-mode: 'off'
unified-delay: true
tcp-concurrent: true
dns:
    enable: true
    ipv6: false
    enhanced-mode: redir-host
    listen: 0.0.0.0:53
    # https://wiki.metacubex.one/config/dns/
    # 用来解析下面配置的 DNS 的 DNS，比如解析 doh.apad.pro
    default-nameserver:
    - 223.5.5.5
    - 119.29.29.29
    # 用来解析节点地址的DNS
    proxy-server-nameserver:
    - https://120.53.53.53/dns-query
    - https://223.5.5.5/dns-query
    # 用来解析网络请求的DNS，作为网关，下游设备的 DNS 请求将用 nameserver 配置的 DNS 来解析
    nameserver:
    - https://120.53.53.53/dns-query
    - https://223.5.5.5/dns-query
    - https://doh.apad.pro/dns-query
secret: ''
external-ui: "/opt/mihomo/ui"
keep-alive-interval: 1800
global-client-fingerprint: chrome
geodata-mode: true
geodata-loader: standard
geox-url:
    geoip: https://testingcf.jsdelivr.net/gh/MetaCubeX/meta-rules-dat@release/geoip.dat
    geosite: https://testingcf.jsdelivr.net/gh/MetaCubeX/meta-rules-dat@release/geosite.dat
    mmdb: https://testingcf.jsdelivr.net/gh/MetaCubeX/meta-rules-dat@release/country.mmdb
profile:
    store-selected: true
proxies:
    省略，基于自己的节点配置
proxy-groups:
    省略，基于自己的分流规则和节点绑定设置
rules:
    省略，基于自己的分流规则
```

#### 10.下载、启动mihomo
下载：
https://github.com/MetaCubeX/mihomo/releases/


为以上脚本增加执行权限：
`chmod +x mihomo-linux-amd64 restart-mihomo net-reset net-set`

万事大吉，启动 mihomo：
`./restart-mihomo`

#### 11.下载 metacubexd 面板
```shell
cd /opt/mihomo

# 下载 metacubexd
wget https://github.com/MetaCubeX/metacubexd/releases/latest/download/compressed-dist.tgz
# 解压到 /opt/mihomo/ui
tar -zxvf ./compressed-dist.tgz -C /opt/mihomo/ui
# 删除下载的压缩包
rm -f ./compressed-dist.tgz
```

然后打开 `http://debianIP:9090/ui` 就是控制台了，密码不填（yml文件中的`secret`）。

#### 12.将 `/opt/mihomo/restart-mihomo` 添加到开机启动
```shell
crontab -e

# 填入开机启动后执行的脚本
@reboot sleep 5 && /opt/mihomo/restart-mihomo

# 也可以用其他方式
#sudo cp restart-mihomo.sh /etc/rc.local
```

## 大功告成！
其他需要出国的设备，把 `网关地址`、`DNS` 填入 debian 的 IP，即可。