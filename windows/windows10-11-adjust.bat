:: 声明使用 UTF-8 编码
chcp 65001

@echo off

echo "此脚本运行完成后，需要重启计算机"
echo "本脚本不会破坏任何计算机的组件，仅修改系统设置的注册表"
echo "REG ADD命令不仅是添加注册表项，如果注册表已经存在，就相当于UPDATE"

echo ""
:: 关闭休眠文件和快速启动。新版windows用休眠代替关机实现快速启动，这里可以取消掉这个特性，恢复正常的关机。别被快速启动四个字唬住了，很多时候内存溢出或者莫名占用很高却找不到谁占用了，就是因为这个特性
echo "disbale hibernate, fast startup"
powercfg /h off
powercfg -change -monitor-timeout-ac 0
powercfg -change -monitor-timeout-dc 0
powercfg -change -standby-timeout-dc 0
powercfg -change -standby-timeout-ac 0
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power" /v HibernateEnabled /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v HiberbootEnabled /t REG_DWORD /d 0 /f



echo ""
:: 始终在任务栏显示所有图标和通知
echo "show all icons and notifications on taskbar"
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v EnableAutoTray /t REG_DWORD /d 0 /f


echo ""
:: 任务栏隐藏“任务视图”按钮
echo "hidden task view on taskbar"
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowTaskViewButton /t REG_DWORD /d 0 /f


echo ""
:: 任务栏搜索，仅显示图标
echo "show search icon on taskbar"
REG ADD "HKEY_USERS\.DEFAULT\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v SearchboxTaskbarMode /t REG_DWORD /d 1 /f


echo ""
:: 隐藏任务栏上的人脉
echo "hidden people on taskbar"
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" /v PeopleBand /t REG_DWORD /d 0 /f
REG ADD "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Explorer" /v HidePeopleBar /t REG_DWORD /d 1 /f


echo ""
:: 任务栏时间显示秒
echo "show seconds in system clock"
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowSecondsInSystemClock /t REG_DWORD /d 1 /f

:: 注意：【将用户账号控制程序（UAC）调整为:从不通知】  和  【取消 以批准模式运行所有管理员】 只能二选一
:: 如果开启了其中一个，另一个就会失效。
:: UAC，简单点讲，就是你打开带有小盾牌的exe，会弹窗询问你是否允许以管理员权限运行（exe需要管理员权限才能运行），这个玩意就是UAC机制。
:: UAC 必须是 开启以批准模式运行所有管理员 后，才会生效。
:: 【取消 以批准模式运行所有管理员】 后，会自动禁用掉UAC机制，所以你选什么UAC就没用了，如果你在【取消批准模式】后，又调整了UAC，那么UAC就会生效，批准模式就会自动开启。
:: 建议：使用【取消 以批准模式运行所有管理员】。因为应用程序弹窗授权，估计你也没有拒绝的时候，拒绝了，应用程序就拒绝运行了

::echo ""
:: 将用户账号控制程序（UAC）调整为:从不通知
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 1 /f
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorAdmin /t REG_DWORD /d 0 /f
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v PromptOnSecureDesktop /t REG_DWORD /d 0 /f

echo ""
:: 取消 以批准模式运行所有管理员，当前用户不需要确认即可提权
echo "disable [admin approve mode]"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorAdmin /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v PromptOnSecureDesktop /t REG_DWORD /d 0 /f
:: 顺带 禁用 对内置管理员帐户使用管理审批模式。意思是 Administrator 账号也不需要UAC了，不需要确认即可提权。
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v FilterAdministratorToken /t REG_DWORD /d 0 /f


:: 关闭win11智能应用控制
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SilentInstalledAppsEnabled /t REG_DWORD /d 0 /f

:: 关闭win11内核隔离
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard" /v EnableVirtualizationBasedSecurity /t REG_DWORD /d 0 /f

:: 关闭win11内存隔离
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v Enabled /t REG_DWORD /d 0 /f


echo ""
:: 关闭打开程序的“安全警告”。远离打开exe时的警告。
echo "close [open program warning]"
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Associations" /v ModRiskFileTypes /t REG_SZ /d ".bat;.exe;.reg;.vbs;.chm;.msi;.js;.cmd" /f

echo "disable OneDrive"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v DisableFileSyncNGSC /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v DisableLibrariesDefaultSaveToOneDrive /t REG_DWORD /d 1 /f

echo "disable CloudContent"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsConsumerFeatures /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableSoftLanding /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableConsumerAccountStateContent /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableCloudOptimizedContent /t REG_DWORD /d 1 /f

:: 关闭Smartscreen应用筛选器。打开这个功能，会导致网上下载的exe打开后无响应（检查exe安全），卡顿一会
echo "disable Smartscreen"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v EnableSmartScreen /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v SmartScreenEnabled /t REG_SZ /d "off" /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter" /v EnabledV9 /t REG_DWORD /d 0 /f

echo ""
:: 禁用Windows Defender。远离卡顿。
echo "disable Windows Defender"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableLocalAdminMerge /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableRoutinelyTakingAction /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v PUAProtection /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v RandomizeScheduleTaskTimes /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v ServiceKeepAlive /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" /v DisableArchiveScanning /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" /v DisableScanningNetworkFiles /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableRealtimeMonitoring /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\SmartScreen" /v ConfigureAppInstallControlEnabled /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Microsoft Antimalware" /v DisableAntiSpyware /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Microsoft Antimalware" /v DisableAntiVirus /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Microsoft Antimalware" /v DisableRoutinelyTakingAction /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\App and Browser protection" /v DisallowExploitProtectionOverride /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Notifications" /v DisableEnhancedNotifications /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Notifications" /v DisableNotifications /t REG_DWORD /d 1 /f
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows Defender Security Center\Account protection" /v DisableWindowsHelloNotifications /t REG_DWORD /d 1 /f
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows Defender Security Center\Account protection" /v DisableNotifications /t REG_DWORD /d 1 /f

echo ""
:: 开始菜单不显示建议。别瞎建议。
echo "开始菜单不显示建议"
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338388Enabled /t REG_DWORD /d 0 /f
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338389Enabled /t REG_DWORD /d 1 /f


echo "set windows search"
:: windows 搜索
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\SearchSettings" /v IsAADCloudSearchEnabled /t REG_DWORD /d 0 /f
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\SearchSettings" /v IsDeviceSearchHistoryEnabled /t REG_DWORD /d 0 /f
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\SearchSettings" /v IsDynamicSearchBoxEnabled /t REG_DWORD /d 0 /f
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\SearchSettings" /v IsMSACloudSearchEnabled /t REG_DWORD /d 0 /f
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\SearchSettings" /v SafeSearchMode /t REG_DWORD /d 0 /f

echo "set Start"
:: windows 开始菜单
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Start" /v ShowFrequentList /t REG_DWORD /d 0 /f
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Start" /v ShowRecentList /t REG_DWORD /d 0 /f

echo ""
:: 不在应用商店中查找关联应用。windows你不要帮我在store里面帮我找软件打开方式
echo "不在应用商店中查找关联应用"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v NoUseStoreOpenWith /t REG_DWORD /d 1 /f


echo ""
:: 关闭商店App推广。别瞎推广，给我预装一堆我永远不会玩的游戏、永远不会用的app
echo "关闭商店App推广"
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v PreInstalledAppsEnabled /t REG_DWORD /d 0 /f

echo ""
:: 禁止自动安装推荐的应用程序。别瞎推广，给我预装一堆我永远不会玩的游戏、永远不会用的app
echo "禁止自动安装推荐的应用程序"
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SilentInstalledAppsEnabled /t REG_DWORD /d 0 /f


echo ""
:: 关闭锁屏时的 Windows 聚焦推广。锁屏就锁屏，别给我推广告
echo "关闭锁屏时的 Windows 聚焦推广"
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v RotatingLockScreenEnable /t REG_DWORD /d 0 /f


echo ""
:: 关闭“使用Windows时获取技巧和建议”。别瞎建议，遇到问题时，windows的建议也没卵用
echo "关闭使用Windows时获取技巧和建议"
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SoftLandingEnabled /t REG_DWORD /d 0 /f


echo ""
:: 关闭游戏录制工具。我就没见过哪个游戏主播用windows自带的这个录制工具来录游戏素材的，都用OBS或者其他的录制工具
echo "关闭游戏录制工具"
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f
REG ADD "HKEY_CURRENT_USER\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f

echo ""
:: 登录界面默认打开小键盘。让小键盘从开机后就开启，省的低头敲完密码却发现小键盘没开
echo "登录界面默认打开小键盘"
REG ADD "HKEY_USERS\.DEFAULT\Control Panel\Keyboard" /v InitialKeyboardIndicators /t REG_SZ /d "2" /f

echo ""
:: 关闭多嘴、无用的小娜。谁还在用小娜？
echo "关闭多嘴、无用的小娜"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /t REG_DWORD /d 0 /f
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Cortana" /v IsAvailable /t REG_DWORD /d 0 /f


echo ""
:: 打开资源管理器时显示为此电脑（就是显示C盘、D盘....）。不改这项的话，默认打开的是“快速访问”
echo "打开资源管理器时显示为此电脑"
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v LaunchTo /t REG_DWORD /d 1 /f


echo ""
:: 显示文件扩展名
echo "显示文件扩展名"
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 0 /f


echo ""
:: 显示隐藏文件
echo "显示隐藏文件"
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Hidden /t REG_DWORD /d 1 /f


echo ""
:: 创建快捷方式时，不添[快捷方式]文字
echo "创建快捷方式时不添[快捷方式]文字"
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v Link /t REG_BINARY /d 00000000 /f



echo ""
:: 禁止自动播放。万一U盘exe文件有毒，你自动运行可还行？
echo "禁止自动播放"
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers" /v DisableAutoplay /t REG_DWORD /d 1 /f


echo ""
:: 在单独的进程中打开文件夹窗口。打开资源管理器，就新启动一个explorer进程，防止卡顿以及突然无响应
echo "在单独的进程中打开文件夹窗口"
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v SeparateProcess /t REG_DWORD /d 1 /f

echo ""
:: 资源管理器窗口最小化时显示完整路径。文件夹窗口最小化后，显示为具体目录，比如 C:/XXXX
echo "资源管理器窗口最小化时显示完整路径"
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" /v FullPath /t REG_DWORD /d 1 /f


echo ""
:: 快速访问不显示常用文件夹、最近文件。
echo "快速访问不显示常用文件夹、最近文件"
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v ShowFrequent /t REG_DWORD /d 0 /f
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v ShowRecent /t REG_DWORD /d 0 /f


echo ""
:: 微软拼音输入法默认为:英文状态。如果是中文，为1
echo "微软拼音输入法默认为:英文状态"
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\InputMethod\Settings\CHS" /v "Default Mode" /t REG_DWORD /d 0 /f

echo ""
:: windows 更新不包括驱动程序。用的好好的，就别乱更新驱动。安装完操作系统，装完驱动后，我也不希望windows自己把我精心安装的驱动给我覆盖了
echo "windows 更新不包括驱动程序"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v ExcludeWUDriversInQualityUpdate /t REG_DWORD /d 1 /f

echo ""
:: Windows 更新不包括恶意软件删除工具。几乎每个人都装了各类系统维护工具，这个恶意软件删除工具，从来没有它成功清除了什么恶意软件（国产毒瘤不属于这个工具的管理范围，微软不care）
echo "Windows 更新不包括恶意软件删除工具"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MRT" /v DontOfferThroughWUAU /t REG_DWORD /d 1 /f

echo ""
:: Windows 更新更改为:手动更新。我想什么时候更新，我就什么时候更新，别闲着没事update给我重启了
echo "Windows 更新更改为:手动更新"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v AUOptions /t REG_DWORD /d 1 /f

echo ""
:: widows 更新中功能更新延迟30天。功能更新指：新增windows功能、功能调整类的update。实在不敢恭维微软的代码质量，新功能我也不稀罕，1个月之后再更新
echo "widows 更新中功能更新延迟30天"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DeferFeatureUpdates /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DeferFeatureUpdatesPeriodInDays /t REG_DWORD /d 30 /f

echo ""
:: widows 更新中质量更新延迟30天。质量更新指：漏洞修复、bug修复类的update。实在不敢恭维微软的代码质量，质量更新发布后1个月之后再更新这个update（这个时候普遍大众已经更新了，有问题的话微软会撤回update，我肯定就逃过一劫了）
echo "widows 更新中质量更新延迟30天"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DeferQualityUpdates /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DeferQualityUpdatesPeriodInDays /t REG_DWORD /d 30 /f


echo ""
:: 关闭 windows 防火墙。我默认就是防火墙关闭，因为电脑不是在公网IP上，都是家庭或者公司内网里，除非你这台windows是服务器，对公网提供服务用。如果你开启防火墙，被连接远程桌面、共享文件夹时候还会受阻
echo "关闭 windows 防火墙"
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\StandardProfile" /v EnableFirewall /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\PublicProfile" /v EnableFirewall /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\DomainProfile" /v EnableFirewall /t REG_DWORD /d 0 /f


echo ""
:: 关闭远程协助。这功能没什么用，如果远程，肯定用QQ远程协助，或者 TeamViewer、向日葵、todesk 之类的
echo "关闭远程协助"
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v fAllowToGetHelp /t REG_DWORD /d 0 /f



:: 提升帧率，还需要：
:: 组策略 > 计算机配置 -> 管理模板 -> Windows 组件 -> 远程桌面服务 -> 远程桌面会话主机 -> 远程会话环境 。
:: 【将硬件图形适配器应用于所有远程桌面服务会话】和【配置远程桌面连接的 H.264/AVC 硬件编码】设为【启用】

echo ""
:: 关闭系统还原功能。这功能没什么用
echo "关闭系统还原功能"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v DisableSR /t REG_DWORD /d 1 /f
echo "禁用Windows 备份服务（Diagnostic Policy Service）"
sc stop "SDRSVC"
sc config "SDRSVC" start= disabled

echo ""
:: 禁用客户体验改善计划。杜绝微软用户信息收集，也别总提示我用windows的感觉如何之类的，我只想安静的用电脑
echo "禁用客户体验改善计划"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v CEIPEnable /t REG_DWORD /d 0 /f

echo ""
:: 禁用微软遥测。遥测的意思是收集你用电脑的情况，电脑上装了什么app、什么时候运行的什么app、windows版本之类的需要提交到微软，杜绝微软用户信息收集
echo "禁用微软遥测（用户信息收集）"
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f

echo ""
:: 禁止自动维护计划(系统预读)。说实在的，这玩意，没什么用，这个设置并不会影响你应用程序加载到RAM中，并不会影响你的系统启动速度、app打开速度，影响系统启动速度和app打开和运行速度的，取决于CPU频率、核心数、固态硬盘4K读写速度、RAM容量
echo "禁止自动维护计划(系统预读)"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\ScheduledDiagnostics" /v EnabledExecution /t REG_DWORD /d 0 /f


echo ""
:: 禁止内核崩溃时写入调试信息。崩了就重启，不用写内核调试数据，我又不是微软员工，不是windows系统内核开发人员，内核崩了就重启完事了
echo "禁止内核崩溃时写入调试信息"
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl" /v CrashDumpEnabled /t REG_DWORD /d 0 /f

echo ""
:: 禁用组件堆栈（Component Based Servicing）文件备份。系统有问题，用dism++来修复系统文件，这个组件堆栈备份功能用不上，遇到大的系统问题，就得重装解决了
echo "禁用组件堆栈（Component Based Servicing）文件备份"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\SideBySide\Configuration" /v DisableComponentBackups /t REG_DWORD /d 1 /f

echo ""
:: 禁用组件堆栈（Component Based Servicing）日志。频繁写C盘，关了
echo "禁用组件堆栈（Component Based Servicing）日志"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing" /v EnableLog /t REG_DWORD /d 0 /f

echo ""
:: 禁用更新解压模块（Delta Package Expander）日志。频繁写C盘，关了
echo "禁用更新解压模块（Delta Package Expander）日志"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing" /v EnableDpxLog /t REG_DWORD /d 0 /f

echo ""
:: 禁用系统错误日志。看注册表路径名，Windows Error Reporting........别 Reporting到微软了，关了，系统错误就重启解决
echo "禁用系统错误日志"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v Disabled /t REG_DWORD /d 1 /f
REG ADD "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Windows Error Reporting" /v LoggingDisabled /t REG_DWORD /d 1 /f

echo ""
:: 禁用WfpDiag.ETL日志。频繁写C盘，关了
echo "禁用WfpDiag.ETL日志"
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\BFE\Parameters\Policy\Options" /v CollectNetEvents /t REG_DWORD /d 0 /f

echo ""
:: 禁用账号登录日志报告。频繁写C盘，关了
echo "禁用账号登录日志报告"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v ReportBootOk /t REG_SZ /d "0" /f


echo ""
:: 程序兼容性助手服务改为手动启动（Program Compatibility Assistant Service）。就没看见过谁用兼容助手把问题解决了的
echo "程序兼容性助手服务改为手动启动（Program Compatibility Assistant Service）"
sc stop "PcaSvc"
sc config "PcaSvc" start= demand

echo ""
:: 禁用远程修改注册表服务（Remote Registry）。必须禁，除了我在电脑上操作之外，不允许任何人动注册表
echo "禁用远程修改注册表服务（Remote Registry）"
sc stop "RemoteRegistry"
sc config "RemoteRegistry" start= disabled

echo ""
:: 禁用诊断服务（Diagnostic Policy Service）。诊断了，问题就能解决了？禁了！exe运行不了，就google一下解决，诊断服务解决不了，还是得手动google
echo "禁用诊断服务（Diagnostic Policy Service）"
sc stop "DPS"
sc config "DPS" start= disabled

echo ""
:: 禁用错误报告服务（Windows Error Reporting Service）。没什么用，依旧只是Reporting
echo "禁用错误报告服务（Windows Error Reporting Service）"
sc stop "WerSvc"
sc config "WerSvc" start= disabled

:: 禁用DNS多网卡并行解析
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" /v "EnableMulticast" /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" /v "DisableSmartNameResolution" /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" /v "DisableSmartProtocolReordering" /t REG_DWORD /d 1 /f

:: win11使用经典的右键菜单
REG ADD "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve
:: 恢复新版菜单 REG DELETE "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f

echo ""
echo ""
echo ""
echo "***********************************"
echo "RESTART REQUIRED"
echo "***********************************"


pause
