@echo off &title %~n0 &color 0a
set "pth=%~dp0"
pushd %pth%
mode con: cols=70 lines=25

:: 定义安装路径
set install_path=C:\software

del /f %SystemRoot%\test.txt >nul 2>&1
echo. >%SystemRoot%\test.txt >nul 2>&1
if exist "%SystemRoot%\test.txt" (
	del /f %SystemRoot%\test.txt >nul 2>&1
	echo.&echo 请切换到普通用户下运行批处理！ &pause &exit
) else (goto :Begin)




:Begin
echo.
echo   Qv2ray安装设置  
echo  __________________________________________________________________
echo. 
echo   1、Qv2ray将安装到%install_path%目录下；
echo. 
echo   2、安装前请将以下文件复制到此文件夹下，才能安装成功！
echo.
echo      【Qv2ray软件7z压缩包】
echo. 
echo      【v2ray内核zip压缩包】
echo. 
echo      【trojan-go内核zip压缩包】
echo. 
echo      【Qv2ray插件文件(含插件)】
echo  __________________________________________________________________
echo. &echo 按任意键开始安装！
pause >nul
cls
::检测安装包
if not exist "%pth%*Qv2ray*Windows*.7z" echo. &echo 没有检测到原始的Qv2ray程序7z压缩包！&pause &exit
if not exist "%pth%*v2ray*windows*.zip" echo. &echo 没有检测到原始的v2ray内核程序zip压缩包！&pause &exit
if not exist "%pth%Qv2ray插件" echo. &echo 没有检测到Qv2ray插件文件夹！&pause &exit
if not exist "%pth%Qv2ray插件\*.dll" echo. &echo 没有检测到Qv2ray插件！&pause &exit
echo. &echo 检测并清除旧版Qv2ray程序包，将会卸载...
tasklist | findstr "qv2ray.exe" >nul 2>nul && taskkill /F /IM qv2ray.exe /T >nul 2>nul
for /d %%i in (%install_path%\*) do (
	echo %%~ni | findstr "Qv2ray"  >nul 2>nul && rmdir /s /q "%%~fi"
)
if exist "%userprofile%\Desktop\*qv2ray*.lnk" del /f "%userprofile%\Desktop\*qv2ray*.lnk" 2>nul

::检测安装目录和7z是否安装
if not exist "%install_path%" mkdir "%install_path%" 2>nul
if not exist "C:\Program Files\7-Zip\7z.exe" echo 未安装7z解压软件，请先安装！&pause &exit
echo. &echo 正在解压安装Qv2ray……
"C:\Program Files\7-Zip\7z.exe" x -y "%pth%*Qv2ray*Windows*.7z" -O"%install_path%"

cd /d %install_path%

if exist "deployment" rename "%deployment" Qv2ray 2>nul
echo. &echo 接下来启动Qv2ray生成初始配置文件，然后自动关闭！
ping -n 2 127.0.0.1 >nul
if exist "Qv2ray\qv2ray.exe" start "" C:\software\Qv2ray\qv2ray.exe
ping -n 3 127.0.0.1 >nul
tasklist | findstr "qv2ray.exe" && taskkill /F /IM Qv2ray.exe /T >nul 2>nul

echo. &echo 正在解压安装v2ray内核...
if not exist "Qv2ray\config\vcore" mkdir "Qv2ray\config\vcore" 2>nul && "C:\Program Files\7-Zip\7z.exe" x -y "%pth%*v2ray*windows*.zip" -o"Qv2ray\config\vcore"

echo. &echo 正在安装Qv2ray插件...
if not exist "Qv2ray\config\plugins" mkdir "Qv2ray\config\plugins" 2>nul && copy /Y "%pth%Qv2ray插件\*.dll" "Qv2ray\config\plugins"

:: 创建设置配置文件
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

:: 创建桌面图标
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

:: 检测安装trojan-go，没有就不安装
if exist "%pth%*trojan-go*windows*.zip" (
	echo. 
	echo 正在安装trojan-go内核...
	if not exist "Qv2ray\config\trojan-go" mkdir "Qv2ray\config\trojan-go" 2>nul && "C:\Program Files\7-Zip\7z.exe" x -y "%pth%*trojan-go*windows*.zip" -O"Qv2ray\config\trojan-go"
	if exist "Qv2ray\config\trojan-go\example" rmdir /s /q "Qv2ray\config\trojan-go\example" 2>nul
	if not exist "Qv2ray\config\plugin_settings" mkdir "Qv2ray\config\plugin_settings" 2>nul
	call :trojan-go_plugin_conf %new_install_path%
)

:: 添加防火墙放行
cls
echo.
echo 未放行程序将以管理员身份添加到防火墙出站规则……
ping -n 3 127.0.0.1 >nul
(
echo.@echo off
echo.
echo.:: 定义安装路径
echo.set install_path=C:\software
echo.:: 添加防火墙放行
echo.for %%%%i in ^(Qv2ray\qv2ray.exe Qv2ray\config\vcore\v2ray.exe Qv2ray\config\vcore\wv2ray.exe Qv2ray\config\trojan-go\trojan-go.exe^) do ^(
echo.	call :AllowOutbound %%%%i
echo.^)
echo.exit
echo.
echo.
echo.:: 函数#添加防火墙放行
echo.:AllowOutbound
echo.:: 检查当前是否放行程序
echo.netsh advfirewall firewall show rule name="%%install_path%%\%%1" ^>nul 2^>nul ^|^| ^(
echo.	reg query "HKU\S-1-5-19\Environment" ^>nul 2^>nul ^|^| ^(
echo.		Mshta VBScript:CreateObject^^^("Shell.Application"^^^).Shellexecute^^^("%%~f0","goto :AllowOutbound","","runas",1^^^)^^^(Window.Close^^^) ^& exit
echo.	^)
echo.	netsh advfirewall firewall add rule name="%%install_path%%\%%1" program="%%install_path%%\%%1" profile=public dir=out action=allow enable=yes ^>nul
echo.^)
echo.goto :eof
)>"%install_path%\Qv2ray\outbound.bat"
start "添加放行程序" /min "%install_path%\Qv2ray\outbound.bat"
ping -n 3 127.0.0.1 >nul
REM del /f "%install_path%\Qv2ray\outbound.bat" 2>nul
echo 防火墙放行完成！
ping -n 3 127.0.0.1 >nul
::清理残留文件
::保留软件压缩包
::del /S /Q *.7z >nul 2>nul
::del /S /Q *.zip >nul 2>nul
cls
echo. &echo Qv2ray安装完成，5秒后退出！&ping -n 5 127.0.0.1 >nul
exit


:: 函数#trojan-go插件配置
:trojan-go_plugin_conf
(
echo.{
echo.    "kernelPath": "%1/Qv2ray/config/trojan-go/trojan-go.exe"
echo.}
)>"Qv2ray\config\plugin_settings\qvtrojango_plugin.conf"
goto :eof

:: 函数#添加防火墙放行
:AllowOutbound
:: 检查当前是否放行Wget
netsh advfirewall firewall show rule name="%install_path%\%1" >nul 2>nul || (
	reg query "HKU\S-1-5-19\Environment" >nul 2>nul || (
		Mshta VBScript:CreateObject^("Shell.Application"^).Shellexecute^("%~f0","goto :AllowOutbound","","runas",1^)^(Window.Close^) & exit
	)
	netsh advfirewall firewall add rule name="%install_path%\%1" program="%install_path%\%1" profile=public dir=out action=allow enable=yes >nul
	exit
)
goto :eof


:eof
