@echo off
:: 关闭休眠文件和快速启动（新版windows用休眠代替关机实现快速启动，这里可以取消掉这个特性，恢复正常的关机）
echo "关闭休眠文件和快速启动"
powercfg /h off
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power" /v HibernateEnabled /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v HiberbootEnabled /t REG_DWORD /d 0 /f



:: 始终在任务栏显示所有图标和通知
echo "始终在任务栏显示所有图标和通知"
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v EnableAutoTray /t REG_DWORD /d 0 /f


:: 隐藏“任务视图”按钮
echo "隐藏“任务视图”按钮"
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowTaskViewButton /t REG_DWORD /d 0 /f


:: 任务栏搜索，仅显示图标
echo "任务栏搜索，仅显示图标"
REG ADD "HKEY_USERS\.DEFAULT\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v SearchboxTaskbarMode /t REG_DWORD /d 1 /f


:: 隐藏任务栏上的人脉
echo "隐藏任务栏上的人脉"
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" /v PeopleBand /t REG_DWORD /d 0 /f
REG ADD "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Explorer" /v HidePeopleBar /t REG_DWORD /d 1 /f


:: 任务栏时间显示秒
echo "任务栏时间显示秒"
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowSecondsInSystemClock /t REG_DWORD /d 1 /f

:: 将用户账号控制程序（UAC）调整为:从不通知
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v PromptOnSecureDesktop /t REG_DWORD /d 0 /f
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorAdmin /t REG_DWORD /d 0 /f
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v PromptOnSecureDesktop /t REG_DWORD /d 0 /f

:: 取消 内置管理员帐户的管理员批准模式，当前用户不需要确认即可提权
echo "取消 内置管理员帐户的管理员批准模式"
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v FilterAdministratorToken /f


:: 关闭Smartscreen应用筛选器
echo "关闭Smartscreen应用筛选器"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v EnableSmartScreen /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v SmartScreenEnabled /t REG_SZ /d "off" /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter" /v EnabledV9 /t REG_DWORD /d 0 /f


:: 关闭打开程序的“安全警告”
echo "关闭打开程序的“安全警告"
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Associations" /v ModRiskFileTypes /t REG_SZ /d ".bat;.exe;.reg;.vbs;.chm;.msi;.js;.cmd" /f


:: 禁用Windows Defender
echo "禁用Windows Defender"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableRealtimeMonitoring /t REG_DWORD /d 1 /f


:: 开始菜单不显示建议
echo "开始菜单不显示建议"
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338388Enabled /t REG_DWORD /d 0 /f
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338389Enabled /t REG_DWORD /d 1 /f


:: 不在应用商店中查找关联应用
echo "不在应用商店中查找关联应用"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v NoUseStoreOpenWith /t REG_DWORD /d 1 /f

:: 关闭商店App推广
echo "关闭商店App推广"
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v PreInstalledAppsEnabled /t REG_DWORD /d 0 /f

:: 关闭锁屏时的 Windows 聚焦推广
echo "关闭锁屏时的 Windows 聚焦推广"
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v RotatingLockScreenEnable /t REG_DWORD /d 0 /f


:: 关闭“使用Windows时获取技巧和建议”
echo "关闭使用Windows时获取技巧和建议"
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SoftLandingEnabled /t REG_DWORD /d 0 /f


:: 禁止自动安装推荐的应用程序
echo "禁止自动安装推荐的应用程序"
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SilentInstalledAppsEnabled /t REG_DWORD /d 0 /f



:: 关闭游戏录制工具
echo "关闭游戏录制工具"
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f
REG ADD "HKEY_CURRENT_USER\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f

:: 登录界面默认打开小键盘
echo "登录界面默认打开小键盘"
REG ADD "HKEY_USERS\.DEFAULT\Control Panel\Keyboard" /v InitialKeyboardIndicators /t REG_SZ /d "2" /f



:: 关闭多嘴、无用的小娜
echo "关闭多嘴、无用的小娜"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /t REG_DWORD /d 0 /f


:: 打开资源管理器时显示为此电脑
echo "打开资源管理器时显示为此电脑"
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v LaunchTo /t REG_DWORD /d 1 /f

:: 显示所有文件扩展名
echo "显示所有文件扩展名"
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 0 /f


:: 显示隐藏文件
echo "显示隐藏文件"
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Hidden /t REG_DWORD /d 1 /f


:: 创建快捷方式时不添[快捷方式]文字
echo "创建快捷方式时不添[快捷方式]文字"
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v Link /t REG_BINARY /d 00000000 /f



:: 禁止自动播放
echo "禁止自动播放"
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers" /v DisableAutoplay /t REG_DWORD /d 1 /f


:: 在单独的进程中打开文件夹窗口
echo "在单独的进程中打开文件夹窗口"
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v SeparateProcess /t REG_DWORD /d 1 /f

:: 资源管理器窗口最小化时显示完整路径
echo "资源管理器窗口最小化时显示完整路径"
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" /v FullPath /t REG_DWORD /d 1 /f


:: 快速访问不显示常用文件夹、最近文件
echo "快速访问不显示常用文件夹、最近文件"
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v ShowFrequent /t REG_DWORD /d 0 /f
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v ShowRecent /t REG_DWORD /d 0 /f


:: 微软拼音输入法默认为:英文状态
echo "微软拼音输入法默认为:英文状态"
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\InputMethod\Settings\CHS" /v "Default Mode" /t REG_DWORD /d 1 /f

:: windows 更新不包括驱动程序
echo "windows 更新不包括驱动程序"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v ExcludeWUDriversInQualityUpdate /t REG_DWORD /d 1 /f

:: Windows 更新不包括恶意软件删除工具
echo "Windows 更新不包括恶意软件删除工具"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MRT" /v DontOfferThroughWUAU /t REG_DWORD /d 1 /f

:: Windows 更新更改为:手动更新
echo "Windows 更新更改为:手动更新"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /t REG_DWORD /d 1 /f

:: widows 更新中功能更新延迟30天
echo "widows 更新中功能更新延迟30天"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DeferFeatureUpdates /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DeferFeatureUpdatesPeriodInDays /t REG_DWORD /d 30 /f

:: widows 更新中质量更新延迟30天
echo "widows 更新中质量更新延迟30天"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DeferQualityUpdates /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DeferQualityUpdatesPeriodInDays /t REG_DWORD /d 30 /f

:: 关闭 windows 防火墙
echo "关闭 windows 防火墙"
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\StandardProfile" /v EnableFirewall /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\PublicProfile" /v EnableFirewall /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\DomainProfile" /v EnableFirewall /t REG_DWORD /d 0 /f


:: 关闭远程协助
echo "关闭远程协助"
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v fAllowToGetHelp /t REG_DWORD /d 0 /f

:: 关闭系统还原功能（没什么用）
echo "关闭系统还原功能"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v DisableSR /t REG_DWORD /d 1 /f

:: 禁用客户体验改善计划（用户信息收集）
echo "禁用客户体验改善计划"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v CEIPEnable /t REG_DWORD /d 0 /f

:: 禁用微软遥测（用户信息收集）
echo "禁用微软遥测（用户信息收集）"
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f

:: 禁止自动维护计划(系统预读)
echo "禁止自动维护计划(系统预读)"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\ScheduledDiagnostics" /v EnabledExecution /t REG_DWORD /d 0 /f


:: 禁止内核崩溃时写入调试信息
echo "禁止内核崩溃时写入调试信息"
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl" /v CrashDumpEnabled /t REG_DWORD /d 0 /f

:: 禁用组件堆栈（Component Based Servicing）文件备份
echo "禁用组件堆栈（Component Based Servicing）文件备份"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\SideBySide\Configuration" /v DisableComponentBackups /t REG_DWORD /d 1 /f

:: 禁用组件堆栈（Component Based Servicing）日志
echo "禁用组件堆栈（Component Based Servicing）日志"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing" /v EnableLog /t REG_DWORD /d 0 /f

:: 禁用更新解压模块（Delta Package Expander）日志
echo "禁用更新解压模块（Delta Package Expander）日志"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing" /v EnableDpxLog /t REG_DWORD /d 0 /f

:: 禁用系统错误日志
echo "禁用系统错误日志"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v Disabled /t REG_DWORD /d 1 /f
REG ADD "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Windows Error Reporting" /v LoggingDisabled /t REG_DWORD /d 1 /f

:: 禁用WfpDiag.ETL日志
echo "禁用WfpDiag.ETL日志"
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\BFE\Parameters\Policy\Options" /v CollectNetEvents /t REG_DWORD /d 0 /f

:: 禁用账号登录日志报告
echo "禁用账号登录日志报告"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v ReportBootOk /t REG_SZ /d "0" /f


:: 程序兼容性助手服务改为手动启动
echo "程序兼容性助手服务改为手动启动"
sc stop "PcaSvc"
sc config "PcaSvc" start= demand

:: 禁用远程修改注册表服务
echo "禁用远程修改注册表服务"
sc stop "RemoteRegistry"
sc config "RemoteRegistry" start= disabled

:: 禁用诊断服务
echo "禁用诊断服务"
sc stop "DPS"
sc config "DPS" start= disabled

:: 禁用错误报告服务
echo "禁用错误报告服务"
sc stop "WerSvc"
sc config "WerSvc" start= disabled

pause
