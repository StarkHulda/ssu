@echo off &title %~n0 &color 0a
set "pth=%~dp0"
pushd %pth%
mode con: cols=70 lines=25

:: ���尲װ·��
set install_path=C:\software

del /f %SystemRoot%\test.txt >nul 2>&1
echo. >%SystemRoot%\test.txt >nul 2>&1
if exist "%SystemRoot%\test.txt" (
	del /f %SystemRoot%\test.txt >nul 2>&1
	echo.&echo ���л�����ͨ�û������������� &pause &exit
) else (goto :Begin)




:Begin
echo.
echo   Qv2ray��װ����  
echo  __________________________________________________________________
echo. 
echo   1��Qv2ray����װ��%install_path%Ŀ¼�£�
echo. 
echo   2����װǰ�뽫�����ļ����Ƶ����ļ����£����ܰ�װ�ɹ���
echo.
echo      ��Qv2ray���7zѹ������
echo. 
echo      ��v2ray�ں�zipѹ������
echo. 
echo      ��trojan-go�ں�zipѹ������
echo. 
echo      ��Qv2ray����ļ�(�����)��
echo  __________________________________________________________________
echo. &echo ���������ʼ��װ��
pause >nul
cls
::��ⰲװ��
if not exist "%pth%*Qv2ray*Windows*.7z" echo. &echo û�м�⵽ԭʼ��Qv2ray����7zѹ������&pause &exit
if not exist "%pth%*v2ray*windows*.zip" echo. &echo û�м�⵽ԭʼ��v2ray�ں˳���zipѹ������&pause &exit
if not exist "%pth%Qv2ray���" echo. &echo û�м�⵽Qv2ray����ļ��У�&pause &exit
if not exist "%pth%Qv2ray���\*.dll" echo. &echo û�м�⵽Qv2ray�����&pause &exit
echo. &echo ��Ⲣ����ɰ�Qv2ray�����������ж��...
tasklist | findstr "qv2ray.exe" >nul 2>nul && taskkill /F /IM qv2ray.exe /T >nul 2>nul
for /d %%i in (%install_path%\*) do (
	echo %%~ni | findstr "Qv2ray"  >nul 2>nul && rmdir /s /q "%%~fi"
)
if exist "%userprofile%\Desktop\*qv2ray*.lnk" del /f "%userprofile%\Desktop\*qv2ray*.lnk" 2>nul

::��ⰲװĿ¼��7z�Ƿ�װ
if not exist "%install_path%" mkdir "%install_path%" 2>nul
if not exist "C:\Program Files\7-Zip\7z.exe" echo δ��װ7z��ѹ��������Ȱ�װ��&pause &exit
echo. &echo ���ڽ�ѹ��װQv2ray����
"C:\Program Files\7-Zip\7z.exe" x -y "%pth%*Qv2ray*Windows*.7z" -O"%install_path%"

cd /d %install_path%

if exist "deployment" rename "%deployment" Qv2ray 2>nul
echo. &echo ����������Qv2ray���ɳ�ʼ�����ļ���Ȼ���Զ��رգ�
ping -n 2 127.0.0.1 >nul
if exist "Qv2ray\qv2ray.exe" start "" C:\software\Qv2ray\qv2ray.exe
ping -n 3 127.0.0.1 >nul
tasklist | findstr "qv2ray.exe" && taskkill /F /IM Qv2ray.exe /T >nul 2>nul

echo. &echo ���ڽ�ѹ��װv2ray�ں�...
if not exist "Qv2ray\config\vcore" mkdir "Qv2ray\config\vcore" 2>nul && "C:\Program Files\7-Zip\7z.exe" x -y "%pth%*v2ray*windows*.zip" -o"Qv2ray\config\vcore"

echo. &echo ���ڰ�װQv2ray���...
if not exist "Qv2ray\config\plugins" mkdir "Qv2ray\config\plugins" 2>nul && copy /Y "%pth%Qv2ray���\*.dll" "Qv2ray\config\plugins"

:: �������������ļ�
set "new_install_path=%install_path:\=/%"

(
echo.{
echo.    "advancedConfig": {
echo.    },
echo.    "autoStartBehavior": 0,
echo.    "autoStartId": {
echo.        "groupId": "000000000000"
echo.    },
echo.    "config_version": 14,
echo.    "defaultRouteConfig": {
echo.        "connectionConfig": {
echo.            "bypassCN": false,
echo.            "bypassLAN": false
echo.        },
echo.        "dnsConfig": {
echo.            "servers": [
echo.                {
echo.                    "address": "1.1.1.1"
echo.                },
echo.                {
echo.                    "address": "8.8.8.8"
echo.                },
echo.                {
echo.                    "address": "8.8.4.4"
echo.                }
echo.            ]
echo.        },
echo.        "routeConfig": {
echo.            "domainMatcher": "mph",
echo.            "domainStrategy": "AsIs",
echo.            "domains": {
echo.            },
echo.            "ips": {
echo.            }
echo.        }
echo.    },
echo.    "inboundConfig": {
echo.        "httpSettings": {
echo.            "port": 1081
echo.        },
echo.        "socksSettings": {
echo.            "enableUDP": false,
echo.            "port": 1080
echo.        },
echo.        "systemProxySettings": {
echo.            "setSystemProxy": false
echo.        }
echo.    },
echo.    "kernelConfig": {
echo.        "v2AssetsPath_win": "%new_install_path%/Qv2ray/config/vcore/",
echo.        "v2CorePath_win": "%new_install_path%/Qv2ray/config/vcore/v2ray.exe"
echo.    },
echo.    "lastConnectedId": {
echo.    },
echo.    "logLevel": 3,
echo.    "networkConfig": {
echo.        "port": 1081,
echo.        "proxyType": 2
echo.    },
echo.    "outboundConfig": {
echo.    },
echo.    "pluginConfig": {
echo.        "pluginStates": {
echo.            "builtin_subscription_support": true,
echo.            "qvplugin_builtin_protocol": true
echo.        }
echo.    },
echo.    "uiConfig": {
echo.        "graphConfig": {
echo.            "colorConfig": {
echo.                "$0": {
echo.                    "value1": {
echo.                        "B": 63,
echo.                        "G": 196,
echo.                        "R": 134
echo.                    },
echo.                    "value2": {
echo.                        "B": 255,
echo.                        "G": 153,
echo.                        "R": 50
echo.                    }
echo.                },
echo.                "$1": {
echo.                    "value1": {
echo.                        "B": 63,
echo.                        "G": 196,
echo.                        "R": 134
echo.                    },
echo.                    "value2": {
echo.                        "B": 255,
echo.                        "G": 153,
echo.                        "R": 50
echo.                    }
echo.                },
echo.                "$2": {
echo.                    "value1": {
echo.                        "B": 240,
echo.                        "G": 210,
echo.                        "R": 0,
echo.                        "style": 3
echo.                    },
echo.                    "value2": {
echo.                        "B": 42,
echo.                        "G": 220,
echo.                        "R": 235,
echo.                        "style": 3
echo.                    }
echo.                }
echo.            }
echo.        },
echo.        "language": "zh_CN"
echo.    },
echo.    "updateConfig": {
echo.    }
echo.}
echo.
)>"%install_path%\Qv2ray\config\Qv2ray.conf"

:: ��������ͼ��
(
echo Set WshShell=CreateObject("WScript.Shell"^)
echo strDesKtop=WshShell.SpecialFolders("DesKtop"^)
echo Set oShellLink=WshShell.CreateShortcut(strDesKtop^&"\qv2ray.lnk"^)
echo oShellLink.TargetPath="%install_path%\Qv2ray\qv2ray.exe"
echo oShellLink.WorkingDirectory="%install_path%\Qv2ray"
echo oShellLink.WindowStyle=1
echo oShellLink.IconLocation="%install_path%\Qv2ray\qv2ray.exe,0"
echo oShellLink.Description="qv2ray shortcut"
echo oShellLink.Save
)>makelnk.vbs
makelnk.vbs
del /f /q makelnk.vbs >nul

:: ��ⰲװtrojan-go��û�оͲ���װ
if exist "%pth%*trojan-go*windows*.zip" (
	echo. 
	echo ���ڰ�װtrojan-go�ں�...
	if not exist "Qv2ray\config\trojan-go" mkdir "Qv2ray\config\trojan-go" 2>nul && "C:\Program Files\7-Zip\7z.exe" x -y "%pth%*trojan-go*windows*.zip" -O"Qv2ray\config\trojan-go"
	if exist "Qv2ray\config\trojan-go\example" rmdir /s /q "Qv2ray\config\trojan-go\example" 2>nul
	if not exist "Qv2ray\config\plugin_settings" mkdir "Qv2ray\config\plugin_settings" 2>nul
	call :trojan-go_plugin_conf %new_install_path%
)

:: ��ӷ���ǽ����
cls
echo.
echo δ���г����Թ���Ա�����ӵ�����ǽ��վ���򡭡�
ping -n 3 127.0.0.1 >nul
(
echo.@echo off
echo.
echo.:: ���尲װ·��
echo.set install_path=C:\software
echo.:: ��ӷ���ǽ����
echo.for %%%%i in ^(Qv2ray\qv2ray.exe Qv2ray\config\vcore\v2ray.exe Qv2ray\config\vcore\wv2ray.exe Qv2ray\config\trojan-go\trojan-go.exe^) do ^(
echo.	call :AllowOutbound %%%%i
echo.^)
echo.exit
echo.
echo.
echo.:: ����#��ӷ���ǽ����
echo.:AllowOutbound
echo.:: ��鵱ǰ�Ƿ���г���
echo.netsh advfirewall firewall show rule name="%%install_path%%\%%1" ^>nul 2^>nul ^|^| ^(
echo.	reg query "HKU\S-1-5-19\Environment" ^>nul 2^>nul ^|^| ^(
echo.		Mshta VBScript:CreateObject^^^("Shell.Application"^^^).Shellexecute^^^("%%~f0","goto :AllowOutbound","","runas",1^^^)^^^(Window.Close^^^) ^& exit
echo.	^)
echo.	netsh advfirewall firewall add rule name="%%install_path%%\%%1" program="%%install_path%%\%%1" profile=public dir=out action=allow enable=yes ^>nul
echo.^)
echo.goto :eof
)>"%install_path%\Qv2ray\outbound.bat"
start "��ӷ��г���" /min "%install_path%\Qv2ray\outbound.bat"
ping -n 3 127.0.0.1 >nul
REM del /f "%install_path%\Qv2ray\outbound.bat" 2>nul
echo ����ǽ������ɣ�
ping -n 3 127.0.0.1 >nul
::��������ļ�
::�������ѹ����
::del /S /Q *.7z >nul 2>nul
::del /S /Q *.zip >nul 2>nul
cls
echo. &echo Qv2ray��װ��ɣ�5����˳���&ping -n 5 127.0.0.1 >nul
exit


:: ����#trojan-go�������
:trojan-go_plugin_conf
(
echo.{
echo.    "kernelPath": "%1/Qv2ray/config/trojan-go/trojan-go.exe"
echo.}
)>"Qv2ray\config\plugin_settings\qvtrojango_plugin.conf"
goto :eof

:: ����#��ӷ���ǽ����
:AllowOutbound
:: ��鵱ǰ�Ƿ����Wget
netsh advfirewall firewall show rule name="%install_path%\%1" >nul 2>nul || (
	reg query "HKU\S-1-5-19\Environment" >nul 2>nul || (
		Mshta VBScript:CreateObject^("Shell.Application"^).Shellexecute^("%~f0","goto :AllowOutbound","","runas",1^)^(Window.Close^) & exit
	)
	netsh advfirewall firewall add rule name="%install_path%\%1" program="%install_path%\%1" profile=public dir=out action=allow enable=yes >nul
	exit
)
goto :eof


:eof
