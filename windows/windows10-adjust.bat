@echo off
:: �ر������ļ��Ϳ����������°�windows�����ߴ���ػ�ʵ�ֿ����������������ȡ����������ԣ��ָ������Ĺػ���
echo "�ر������ļ��Ϳ�������"
powercfg /h off
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power" /v HibernateEnabled /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v HiberbootEnabled /t REG_DWORD /d 0 /f



:: ʼ������������ʾ����ͼ���֪ͨ
echo "ʼ������������ʾ����ͼ���֪ͨ"
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v EnableAutoTray /t REG_DWORD /d 0 /f


:: ���ء�������ͼ����ť
echo "���ء�������ͼ����ť"
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowTaskViewButton /t REG_DWORD /d 0 /f


:: ����������������ʾͼ��
echo "����������������ʾͼ��"
REG ADD "HKEY_USERS\.DEFAULT\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v SearchboxTaskbarMode /t REG_DWORD /d 1 /f


:: �����������ϵ�����
echo "�����������ϵ�����"
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" /v PeopleBand /t REG_DWORD /d 0 /f
REG ADD "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Explorer" /v HidePeopleBar /t REG_DWORD /d 1 /f


:: ������ʱ����ʾ��
echo "������ʱ����ʾ��"
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowSecondsInSystemClock /t REG_DWORD /d 1 /f

:: ���û��˺ſ��Ƴ���UAC������Ϊ:�Ӳ�֪ͨ
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v PromptOnSecureDesktop /t REG_DWORD /d 0 /f
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorAdmin /t REG_DWORD /d 0 /f
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v PromptOnSecureDesktop /t REG_DWORD /d 0 /f

:: ȡ�� ���ù���Ա�ʻ��Ĺ���Ա��׼ģʽ����ǰ�û�����Ҫȷ�ϼ�����Ȩ
echo "ȡ�� ���ù���Ա�ʻ��Ĺ���Ա��׼ģʽ"
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v FilterAdministratorToken /f


:: �ر�SmartscreenӦ��ɸѡ��
echo "�ر�SmartscreenӦ��ɸѡ��"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v EnableSmartScreen /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v SmartScreenEnabled /t REG_SZ /d "off" /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter" /v EnabledV9 /t REG_DWORD /d 0 /f


:: �رմ򿪳���ġ���ȫ���桱
echo "�رմ򿪳���ġ���ȫ����"
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Associations" /v ModRiskFileTypes /t REG_SZ /d ".bat;.exe;.reg;.vbs;.chm;.msi;.js;.cmd" /f


:: ����Windows Defender
echo "����Windows Defender"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableRealtimeMonitoring /t REG_DWORD /d 1 /f


:: ��ʼ�˵�����ʾ����
echo "��ʼ�˵�����ʾ����"
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338388Enabled /t REG_DWORD /d 0 /f
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338389Enabled /t REG_DWORD /d 1 /f


:: ����Ӧ���̵��в��ҹ���Ӧ��
echo "����Ӧ���̵��в��ҹ���Ӧ��"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v NoUseStoreOpenWith /t REG_DWORD /d 1 /f

:: �ر��̵�App�ƹ�
echo "�ر��̵�App�ƹ�"
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v PreInstalledAppsEnabled /t REG_DWORD /d 0 /f

:: �ر�����ʱ�� Windows �۽��ƹ�
echo "�ر�����ʱ�� Windows �۽��ƹ�"
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v RotatingLockScreenEnable /t REG_DWORD /d 0 /f


:: �رա�ʹ��Windowsʱ��ȡ���ɺͽ��顱
echo "�ر�ʹ��Windowsʱ��ȡ���ɺͽ���"
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SoftLandingEnabled /t REG_DWORD /d 0 /f


:: ��ֹ�Զ���װ�Ƽ���Ӧ�ó���
echo "��ֹ�Զ���װ�Ƽ���Ӧ�ó���"
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SilentInstalledAppsEnabled /t REG_DWORD /d 0 /f



:: �ر���Ϸ¼�ƹ���
echo "�ر���Ϸ¼�ƹ���"
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f
REG ADD "HKEY_CURRENT_USER\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f

:: ��¼����Ĭ�ϴ�С����
echo "��¼����Ĭ�ϴ�С����"
REG ADD "HKEY_USERS\.DEFAULT\Control Panel\Keyboard" /v InitialKeyboardIndicators /t REG_SZ /d "2" /f



:: �رն��졢���õ�С��
echo "�رն��졢���õ�С��"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /t REG_DWORD /d 0 /f


:: ����Դ������ʱ��ʾΪ�˵���
echo "����Դ������ʱ��ʾΪ�˵���"
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v LaunchTo /t REG_DWORD /d 1 /f

:: ��ʾ�����ļ���չ��
echo "��ʾ�����ļ���չ��"
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 0 /f


:: ��ʾ�����ļ�
echo "��ʾ�����ļ�"
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Hidden /t REG_DWORD /d 1 /f


:: ������ݷ�ʽʱ����[��ݷ�ʽ]����
echo "������ݷ�ʽʱ����[��ݷ�ʽ]����"
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v Link /t REG_BINARY /d 00000000 /f



:: ��ֹ�Զ�����
echo "��ֹ�Զ�����"
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers" /v DisableAutoplay /t REG_DWORD /d 1 /f


:: �ڵ����Ľ����д��ļ��д���
echo "�ڵ����Ľ����д��ļ��д���"
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v SeparateProcess /t REG_DWORD /d 1 /f

:: ��Դ������������С��ʱ��ʾ����·��
echo "��Դ������������С��ʱ��ʾ����·��"
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" /v FullPath /t REG_DWORD /d 1 /f


:: ���ٷ��ʲ���ʾ�����ļ��С�����ļ�
echo "���ٷ��ʲ���ʾ�����ļ��С�����ļ�"
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v ShowFrequent /t REG_DWORD /d 0 /f
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v ShowRecent /t REG_DWORD /d 0 /f


:: ΢��ƴ�����뷨Ĭ��Ϊ:Ӣ��״̬
echo "΢��ƴ�����뷨Ĭ��Ϊ:Ӣ��״̬"
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\InputMethod\Settings\CHS" /v "Default Mode" /t REG_DWORD /d 1 /f

:: windows ���²�������������
echo "windows ���²�������������"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v ExcludeWUDriversInQualityUpdate /t REG_DWORD /d 1 /f

:: Windows ���²������������ɾ������
echo "Windows ���²������������ɾ������"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MRT" /v DontOfferThroughWUAU /t REG_DWORD /d 1 /f

:: Windows ���¸���Ϊ:�ֶ�����
echo "Windows ���¸���Ϊ:�ֶ�����"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /t REG_DWORD /d 1 /f

:: widows �����й��ܸ����ӳ�30��
echo "widows �����й��ܸ����ӳ�30��"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DeferFeatureUpdates /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DeferFeatureUpdatesPeriodInDays /t REG_DWORD /d 30 /f

:: widows ���������������ӳ�30��
echo "widows ���������������ӳ�30��"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DeferQualityUpdates /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DeferQualityUpdatesPeriodInDays /t REG_DWORD /d 30 /f

:: �ر� windows ����ǽ
echo "�ر� windows ����ǽ"
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\StandardProfile" /v EnableFirewall /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\PublicProfile" /v EnableFirewall /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\DomainProfile" /v EnableFirewall /t REG_DWORD /d 0 /f


:: �ر�Զ��Э��
echo "�ر�Զ��Э��"
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v fAllowToGetHelp /t REG_DWORD /d 0 /f

:: �ر�ϵͳ��ԭ���ܣ�ûʲô�ã�
echo "�ر�ϵͳ��ԭ����"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v DisableSR /t REG_DWORD /d 1 /f

:: ���ÿͻ�������Ƽƻ����û���Ϣ�ռ���
echo "���ÿͻ�������Ƽƻ�"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v CEIPEnable /t REG_DWORD /d 0 /f

:: ����΢��ң�⣨�û���Ϣ�ռ���
echo "����΢��ң�⣨�û���Ϣ�ռ���"
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f

:: ��ֹ�Զ�ά���ƻ�(ϵͳԤ��)
echo "��ֹ�Զ�ά���ƻ�(ϵͳԤ��)"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\ScheduledDiagnostics" /v EnabledExecution /t REG_DWORD /d 0 /f


:: ��ֹ�ں˱���ʱд�������Ϣ
echo "��ֹ�ں˱���ʱд�������Ϣ"
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl" /v CrashDumpEnabled /t REG_DWORD /d 0 /f

:: ���������ջ��Component Based Servicing���ļ�����
echo "���������ջ��Component Based Servicing���ļ�����"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\SideBySide\Configuration" /v DisableComponentBackups /t REG_DWORD /d 1 /f

:: ���������ջ��Component Based Servicing����־
echo "���������ջ��Component Based Servicing����־"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing" /v EnableLog /t REG_DWORD /d 0 /f

:: ���ø��½�ѹģ�飨Delta Package Expander����־
echo "���ø��½�ѹģ�飨Delta Package Expander����־"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing" /v EnableDpxLog /t REG_DWORD /d 0 /f

:: ����ϵͳ������־
echo "����ϵͳ������־"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v Disabled /t REG_DWORD /d 1 /f
REG ADD "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Windows Error Reporting" /v LoggingDisabled /t REG_DWORD /d 1 /f

:: ����WfpDiag.ETL��־
echo "����WfpDiag.ETL��־"
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\BFE\Parameters\Policy\Options" /v CollectNetEvents /t REG_DWORD /d 0 /f

:: �����˺ŵ�¼��־����
echo "�����˺ŵ�¼��־����"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v ReportBootOk /t REG_SZ /d "0" /f


:: ������������ַ����Ϊ�ֶ�����
echo "������������ַ����Ϊ�ֶ�����"
sc stop "PcaSvc"
sc config "PcaSvc" start= demand

:: ����Զ���޸�ע������
echo "����Զ���޸�ע������"
sc stop "RemoteRegistry"
sc config "RemoteRegistry" start= disabled

:: ������Ϸ���
echo "������Ϸ���"
sc stop "DPS"
sc config "DPS" start= disabled

:: ���ô��󱨸����
echo "���ô��󱨸����"
sc stop "WerSvc"
sc config "WerSvc" start= disabled

pause
