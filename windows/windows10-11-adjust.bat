:: ����ʹ�� UTF-8 ����
chcp 65001

@echo off

echo "�˽ű�������ɺ���Ҫ���������"
echo "���ű������ƻ��κμ��������������޸�ϵͳ���õ�ע���"
echo "REG ADD����������ע�������ע����Ѿ����ڣ����൱��UPDATE"

echo ""
:: �ر������ļ��Ϳ����������°�windows�����ߴ���ػ�ʵ�ֿ����������������ȡ����������ԣ��ָ������Ĺػ����𱻿��������ĸ��ֻ�ס�ˣ��ܶ�ʱ���ڴ��������Ī��ռ�úܸ�ȴ�Ҳ���˭ռ���ˣ�������Ϊ�������
echo "disbale hibernate, fast startup"
powercfg /h off
powercfg -change -monitor-timeout-ac 0
powercfg -change -monitor-timeout-dc 0
powercfg -change -standby-timeout-dc 0
powercfg -change -standby-timeout-ac 0
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power" /v HibernateEnabled /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v HiberbootEnabled /t REG_DWORD /d 0 /f



echo ""
:: ʼ������������ʾ����ͼ���֪ͨ
echo "show all icons and notifications on taskbar"
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v EnableAutoTray /t REG_DWORD /d 0 /f


echo ""
:: ���������ء�������ͼ����ť
echo "hidden task view on taskbar"
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowTaskViewButton /t REG_DWORD /d 0 /f


echo ""
:: ����������������ʾͼ��
echo "show search icon on taskbar"
REG ADD "HKEY_USERS\.DEFAULT\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v SearchboxTaskbarMode /t REG_DWORD /d 1 /f


echo ""
:: �����������ϵ�����
echo "hidden people on taskbar"
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" /v PeopleBand /t REG_DWORD /d 0 /f
REG ADD "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Explorer" /v HidePeopleBar /t REG_DWORD /d 1 /f


echo ""
:: ������ʱ����ʾ��
echo "show seconds in system clock"
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowSecondsInSystemClock /t REG_DWORD /d 1 /f

:: ע�⣺�����û��˺ſ��Ƴ���UAC������Ϊ:�Ӳ�֪ͨ��  ��  ��ȡ�� ����׼ģʽ�������й���Ա�� ֻ�ܶ�ѡһ
:: �������������һ������һ���ͻ�ʧЧ��
:: UAC���򵥵㽲��������򿪴���С���Ƶ�exe���ᵯ��ѯ�����Ƿ������Թ���ԱȨ�����У�exe��Ҫ����ԱȨ�޲������У�������������UAC���ơ�
:: UAC ������ ��������׼ģʽ�������й���Ա �󣬲Ż���Ч��
:: ��ȡ�� ����׼ģʽ�������й���Ա�� �󣬻��Զ����õ�UAC���ƣ�������ѡʲôUAC��û���ˣ�������ڡ�ȡ����׼ģʽ�����ֵ�����UAC����ôUAC�ͻ���Ч����׼ģʽ�ͻ��Զ�������
:: ���飺ʹ�á�ȡ�� ����׼ģʽ�������й���Ա������ΪӦ�ó��򵯴���Ȩ��������Ҳû�оܾ���ʱ�򣬾ܾ��ˣ�Ӧ�ó���;ܾ�������

::echo ""
:: ���û��˺ſ��Ƴ���UAC������Ϊ:�Ӳ�֪ͨ
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 1 /f
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorAdmin /t REG_DWORD /d 0 /f
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v PromptOnSecureDesktop /t REG_DWORD /d 0 /f

echo ""
:: ȡ�� ����׼ģʽ�������й���Ա����ǰ�û�����Ҫȷ�ϼ�����Ȩ
echo "disable [admin approve mode]"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorAdmin /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v PromptOnSecureDesktop /t REG_DWORD /d 0 /f
:: ˳�� ���� �����ù���Ա�ʻ�ʹ�ù�������ģʽ����˼�� Administrator �˺�Ҳ����ҪUAC�ˣ�����Ҫȷ�ϼ�����Ȩ��
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v FilterAdministratorToken /t REG_DWORD /d 0 /f


:: �ر�win11����Ӧ�ÿ���
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SilentInstalledAppsEnabled /t REG_DWORD /d 0 /f

:: �ر�win11�ں˸���
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard" /v EnableVirtualizationBasedSecurity /t REG_DWORD /d 0 /f

:: �ر�win11�ڴ����
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v Enabled /t REG_DWORD /d 0 /f


echo ""
:: �رմ򿪳���ġ���ȫ���桱��Զ���exeʱ�ľ��档
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

:: �ر�SmartscreenӦ��ɸѡ������������ܣ��ᵼ���������ص�exe�򿪺�����Ӧ�����exe��ȫ��������һ��
echo "disable Smartscreen"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v EnableSmartScreen /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v SmartScreenEnabled /t REG_SZ /d "off" /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter" /v EnabledV9 /t REG_DWORD /d 0 /f

echo ""
:: ����Windows Defender��Զ�뿨�١�
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
:: ��ʼ�˵�����ʾ���顣��Ϲ���顣
echo "��ʼ�˵�����ʾ����"
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338388Enabled /t REG_DWORD /d 0 /f
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338389Enabled /t REG_DWORD /d 1 /f


echo "set windows search"
:: windows ����
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\SearchSettings" /v IsAADCloudSearchEnabled /t REG_DWORD /d 0 /f
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\SearchSettings" /v IsDeviceSearchHistoryEnabled /t REG_DWORD /d 0 /f
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\SearchSettings" /v IsDynamicSearchBoxEnabled /t REG_DWORD /d 0 /f
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\SearchSettings" /v IsMSACloudSearchEnabled /t REG_DWORD /d 0 /f
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\SearchSettings" /v SafeSearchMode /t REG_DWORD /d 0 /f

echo "set Start"
:: windows ��ʼ�˵�
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Start" /v ShowFrequentList /t REG_DWORD /d 0 /f
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Start" /v ShowRecentList /t REG_DWORD /d 0 /f

echo ""
:: ����Ӧ���̵��в��ҹ���Ӧ�á�windows�㲻Ҫ������store�������������򿪷�ʽ
echo "����Ӧ���̵��в��ҹ���Ӧ��"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v NoUseStoreOpenWith /t REG_DWORD /d 1 /f


echo ""
:: �ر��̵�App�ƹ㡣��Ϲ�ƹ㣬����Ԥװһ������Զ���������Ϸ����Զ�����õ�app
echo "�ر��̵�App�ƹ�"
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v PreInstalledAppsEnabled /t REG_DWORD /d 0 /f

echo ""
:: ��ֹ�Զ���װ�Ƽ���Ӧ�ó��򡣱�Ϲ�ƹ㣬����Ԥװһ������Զ���������Ϸ����Զ�����õ�app
echo "��ֹ�Զ���װ�Ƽ���Ӧ�ó���"
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SilentInstalledAppsEnabled /t REG_DWORD /d 0 /f


echo ""
:: �ر�����ʱ�� Windows �۽��ƹ㡣������������������ƹ��
echo "�ر�����ʱ�� Windows �۽��ƹ�"
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v RotatingLockScreenEnable /t REG_DWORD /d 0 /f


echo ""
:: �رա�ʹ��Windowsʱ��ȡ���ɺͽ��顱����Ϲ���飬��������ʱ��windows�Ľ���Ҳû����
echo "�ر�ʹ��Windowsʱ��ȡ���ɺͽ���"
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SoftLandingEnabled /t REG_DWORD /d 0 /f


echo ""
:: �ر���Ϸ¼�ƹ��ߡ��Ҿ�û�����ĸ���Ϸ������windows�Դ������¼�ƹ�����¼��Ϸ�زĵģ�����OBS����������¼�ƹ���
echo "�ر���Ϸ¼�ƹ���"
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f
REG ADD "HKEY_CURRENT_USER\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f

echo ""
:: ��¼����Ĭ�ϴ�С���̡���С���̴ӿ�����Ϳ�����ʡ�ĵ�ͷ��������ȴ����С����û��
echo "��¼����Ĭ�ϴ�С����"
REG ADD "HKEY_USERS\.DEFAULT\Control Panel\Keyboard" /v InitialKeyboardIndicators /t REG_SZ /d "2" /f

echo ""
:: �رն��졢���õ�С�ȡ�˭������С�ȣ�
echo "�رն��졢���õ�С��"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /t REG_DWORD /d 0 /f
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Cortana" /v IsAvailable /t REG_DWORD /d 0 /f


echo ""
:: ����Դ������ʱ��ʾΪ�˵��ԣ�������ʾC�̡�D��....������������Ļ���Ĭ�ϴ򿪵��ǡ����ٷ��ʡ�
echo "����Դ������ʱ��ʾΪ�˵���"
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v LaunchTo /t REG_DWORD /d 1 /f


echo ""
:: ��ʾ�ļ���չ��
echo "��ʾ�ļ���չ��"
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 0 /f


echo ""
:: ��ʾ�����ļ�
echo "��ʾ�����ļ�"
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Hidden /t REG_DWORD /d 1 /f


echo ""
:: ������ݷ�ʽʱ������[��ݷ�ʽ]����
echo "������ݷ�ʽʱ����[��ݷ�ʽ]����"
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v Link /t REG_BINARY /d 00000000 /f



echo ""
:: ��ֹ�Զ����š���һU��exe�ļ��ж������Զ����пɻ��У�
echo "��ֹ�Զ�����"
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers" /v DisableAutoplay /t REG_DWORD /d 1 /f


echo ""
:: �ڵ����Ľ����д��ļ��д��ڡ�����Դ����������������һ��explorer���̣���ֹ�����Լ�ͻȻ����Ӧ
echo "�ڵ����Ľ����д��ļ��д���"
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v SeparateProcess /t REG_DWORD /d 1 /f

echo ""
:: ��Դ������������С��ʱ��ʾ����·�����ļ��д�����С������ʾΪ����Ŀ¼������ C:/XXXX
echo "��Դ������������С��ʱ��ʾ����·��"
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" /v FullPath /t REG_DWORD /d 1 /f


echo ""
:: ���ٷ��ʲ���ʾ�����ļ��С�����ļ���
echo "���ٷ��ʲ���ʾ�����ļ��С�����ļ�"
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v ShowFrequent /t REG_DWORD /d 0 /f
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v ShowRecent /t REG_DWORD /d 0 /f


echo ""
:: ΢��ƴ�����뷨Ĭ��Ϊ:Ӣ��״̬����������ģ�Ϊ1
echo "΢��ƴ�����뷨Ĭ��Ϊ:Ӣ��״̬"
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\InputMethod\Settings\CHS" /v "Default Mode" /t REG_DWORD /d 0 /f

echo ""
:: windows ���²��������������õĺúõģ��ͱ��Ҹ�����������װ�����ϵͳ��װ����������Ҳ��ϣ��windows�Լ����Ҿ��İ�װ���������Ҹ�����
echo "windows ���²�������������"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v ExcludeWUDriversInQualityUpdate /t REG_DWORD /d 1 /f

echo ""
:: Windows ���²������������ɾ�����ߡ�����ÿ���˶�װ�˸���ϵͳά�����ߣ�����������ɾ�����ߣ�����û�����ɹ������ʲô�����������������������������ߵĹ���Χ��΢��care��
echo "Windows ���²������������ɾ������"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MRT" /v DontOfferThroughWUAU /t REG_DWORD /d 1 /f

echo ""
:: Windows ���¸���Ϊ:�ֶ����¡�����ʲôʱ����£��Ҿ�ʲôʱ����£�������û��update����������
echo "Windows ���¸���Ϊ:�ֶ�����"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v AUOptions /t REG_DWORD /d 1 /f

echo ""
:: widows �����й��ܸ����ӳ�30�졣���ܸ���ָ������windows���ܡ����ܵ������update��ʵ�ڲ��ҹ�ά΢��Ĵ����������¹�����Ҳ��ϡ����1����֮���ٸ���
echo "widows �����й��ܸ����ӳ�30��"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DeferFeatureUpdates /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DeferFeatureUpdatesPeriodInDays /t REG_DWORD /d 30 /f

echo ""
:: widows ���������������ӳ�30�졣��������ָ��©���޸���bug�޸����update��ʵ�ڲ��ҹ�ά΢��Ĵ����������������·�����1����֮���ٸ������update�����ʱ���ձ�����Ѿ������ˣ�������Ļ�΢��᳷��update���ҿ϶����ӹ�һ���ˣ�
echo "widows ���������������ӳ�30��"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DeferQualityUpdates /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DeferQualityUpdatesPeriodInDays /t REG_DWORD /d 30 /f


echo ""
:: �ر� windows ����ǽ����Ĭ�Ͼ��Ƿ���ǽ�رգ���Ϊ���Բ����ڹ���IP�ϣ����Ǽ�ͥ���߹�˾�������������̨windows�Ƿ��������Թ����ṩ�����á�����㿪������ǽ��������Զ�����桢�����ļ���ʱ�򻹻�����
echo "�ر� windows ����ǽ"
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\StandardProfile" /v EnableFirewall /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\PublicProfile" /v EnableFirewall /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\DomainProfile" /v EnableFirewall /t REG_DWORD /d 0 /f


echo ""
:: �ر�Զ��Э�����⹦��ûʲô�ã����Զ�̣��϶���QQԶ��Э�������� TeamViewer�����տ���todesk ֮���
echo "�ر�Զ��Э��"
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v fAllowToGetHelp /t REG_DWORD /d 0 /f



:: ����֡�ʣ�����Ҫ��
:: ����� > ��������� -> ����ģ�� -> Windows ��� -> Զ��������� -> Զ������Ự���� -> Զ�̻Ự���� ��
:: ����Ӳ��ͼ��������Ӧ��������Զ���������Ự���͡�����Զ���������ӵ� H.264/AVC Ӳ�����롿��Ϊ�����á�

echo ""
:: �ر�ϵͳ��ԭ���ܡ��⹦��ûʲô��
echo "�ر�ϵͳ��ԭ����"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v DisableSR /t REG_DWORD /d 1 /f
echo "����Windows ���ݷ���Diagnostic Policy Service��"
sc stop "SDRSVC"
sc config "SDRSVC" start= disabled

echo ""
:: ���ÿͻ�������Ƽƻ����ž�΢���û���Ϣ�ռ���Ҳ������ʾ����windows�ĸо����֮��ģ���ֻ�밲�����õ���
echo "���ÿͻ�������Ƽƻ�"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v CEIPEnable /t REG_DWORD /d 0 /f

echo ""
:: ����΢��ң�⡣ң�����˼���ռ����õ��Ե������������װ��ʲôapp��ʲôʱ�����е�ʲôapp��windows�汾֮�����Ҫ�ύ��΢���ž�΢���û���Ϣ�ռ�
echo "����΢��ң�⣨�û���Ϣ�ռ���"
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f

echo ""
:: ��ֹ�Զ�ά���ƻ�(ϵͳԤ��)��˵ʵ�ڵģ������⣬ûʲô�ã�������ò�����Ӱ����Ӧ�ó�����ص�RAM�У�������Ӱ�����ϵͳ�����ٶȡ�app���ٶȣ�Ӱ��ϵͳ�����ٶȺ�app�򿪺������ٶȵģ�ȡ����CPUƵ�ʡ�����������̬Ӳ��4K��д�ٶȡ�RAM����
echo "��ֹ�Զ�ά���ƻ�(ϵͳԤ��)"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\ScheduledDiagnostics" /v EnabledExecution /t REG_DWORD /d 0 /f


echo ""
:: ��ֹ�ں˱���ʱд�������Ϣ�����˾�����������д�ں˵������ݣ����ֲ���΢��Ա��������windowsϵͳ�ں˿�����Ա���ں˱��˾�����������
echo "��ֹ�ں˱���ʱд�������Ϣ"
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl" /v CrashDumpEnabled /t REG_DWORD /d 0 /f

echo ""
:: ���������ջ��Component Based Servicing���ļ����ݡ�ϵͳ�����⣬��dism++���޸�ϵͳ�ļ�����������ջ���ݹ����ò��ϣ��������ϵͳ���⣬�͵���װ�����
echo "���������ջ��Component Based Servicing���ļ�����"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\SideBySide\Configuration" /v DisableComponentBackups /t REG_DWORD /d 1 /f

echo ""
:: ���������ջ��Component Based Servicing����־��Ƶ��дC�̣�����
echo "���������ջ��Component Based Servicing����־"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing" /v EnableLog /t REG_DWORD /d 0 /f

echo ""
:: ���ø��½�ѹģ�飨Delta Package Expander����־��Ƶ��дC�̣�����
echo "���ø��½�ѹģ�飨Delta Package Expander����־"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing" /v EnableDpxLog /t REG_DWORD /d 0 /f

echo ""
:: ����ϵͳ������־����ע���·������Windows Error Reporting........�� Reporting��΢���ˣ����ˣ�ϵͳ������������
echo "����ϵͳ������־"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v Disabled /t REG_DWORD /d 1 /f
REG ADD "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Windows Error Reporting" /v LoggingDisabled /t REG_DWORD /d 1 /f

echo ""
:: ����WfpDiag.ETL��־��Ƶ��дC�̣�����
echo "����WfpDiag.ETL��־"
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\BFE\Parameters\Policy\Options" /v CollectNetEvents /t REG_DWORD /d 0 /f

echo ""
:: �����˺ŵ�¼��־���档Ƶ��дC�̣�����
echo "�����˺ŵ�¼��־����"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v ReportBootOk /t REG_SZ /d "0" /f


echo ""
:: ������������ַ����Ϊ�ֶ�������Program Compatibility Assistant Service������û������˭�ü������ְ��������˵�
echo "������������ַ����Ϊ�ֶ�������Program Compatibility Assistant Service��"
sc stop "PcaSvc"
sc config "PcaSvc" start= demand

echo ""
:: ����Զ���޸�ע������Remote Registry������������������ڵ����ϲ���֮�⣬�������κ��˶�ע���
echo "����Զ���޸�ע������Remote Registry��"
sc stop "RemoteRegistry"
sc config "RemoteRegistry" start= disabled

echo ""
:: ������Ϸ���Diagnostic Policy Service��������ˣ�������ܽ���ˣ����ˣ�exe���в��ˣ���googleһ�½������Ϸ��������ˣ����ǵ��ֶ�google
echo "������Ϸ���Diagnostic Policy Service��"
sc stop "DPS"
sc config "DPS" start= disabled

echo ""
:: ���ô��󱨸����Windows Error Reporting Service����ûʲô�ã�����ֻ��Reporting
echo "���ô��󱨸����Windows Error Reporting Service��"
sc stop "WerSvc"
sc config "WerSvc" start= disabled

:: ����DNS���������н���
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" /v "EnableMulticast" /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" /v "DisableSmartNameResolution" /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" /v "DisableSmartProtocolReordering" /t REG_DWORD /d 1 /f

:: win11ʹ�þ�����Ҽ��˵�
REG ADD "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve
:: �ָ��°�˵� REG DELETE "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f

echo ""
echo ""
echo ""
echo "***********************************"
echo "RESTART REQUIRED"
echo "***********************************"


pause
