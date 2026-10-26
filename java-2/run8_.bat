@echo off
setlocal EnableExtensions DisableDelayedExpansion
title JSP to Servlet - Automatic Runner
color 0A
chcp 65001 >nul

rem ================================================================
rem JSP-to-Servlet demo runner for Windows
rem Automatically detects a full JDK. User manually enters Tomcat root.
rem Creates index.jsp and HelloServlet.java in Tomcat webapps.
rem Supports Tomcat 9 (javax.servlet) and Tomcat 10+ (jakarta.servlet).
rem ================================================================

set "JAVA_HOME_FOUND="
set "TOMCAT_HOME="
set "APP_NAME=JSPServletDemo"
set "PS=%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe"

echo.
echo ============================================================
echo          JSP TO SERVLET - AUTOMATIC RUNNER
echo ============================================================
echo [1/6] Detecting Java JDK...
call :FIND_JDK
if not defined JAVA_HOME_FOUND (
  echo [ERROR] A full JDK was not found.
  echo Required: java.exe and javac.exe.
  echo Checked JAVA_HOME, JDK_HOME, PATH, registry and common install folders.
  goto :FAIL
)
set "JAVA=%JAVA_HOME_FOUND%\bin\java.exe"
set "JAVAC=%JAVA_HOME_FOUND%\bin\javac.exe"
set "JAR=%JAVA_HOME_FOUND%\bin\jar.exe"
echo [OK] JDK found: "%JAVA_HOME_FOUND%"
"%JAVA%" -version
"%JAVAC%" -version
if errorlevel 1 goto :FAIL

echo.
echo [2/6] Enter Tomcat installation ROOT folder.
echo Example: C:\apache-tomcat
echo It must contain bin\startup.bat, conf, lib and webapps.
set /p "TOMCAT_HOME=Tomcat root path: "
if not defined TOMCAT_HOME goto :BAD_TOMCAT
set "TOMCAT_HOME=%TOMCAT_HOME:"=%"
for %%I in ("%TOMCAT_HOME%") do set "TOMCAT_HOME=%%~fI"
if not exist "%TOMCAT_HOME%\bin\startup.bat" goto :BAD_TOMCAT
if not exist "%TOMCAT_HOME%\bin\catalina.bat" goto :BAD_TOMCAT
if not exist "%TOMCAT_HOME%\lib\servlet-api.jar" goto :BAD_TOMCAT
if not exist "%TOMCAT_HOME%\webapps" goto :BAD_TOMCAT
if not exist "%JAR%" (
  echo [ERROR] jar.exe missing from detected JDK.
  goto :FAIL
)

echo.
echo [3/6] Detecting Tomcat HTTP port...
set "HTTP_PORT=8080"
"%PS%" -NoProfile -ExecutionPolicy Bypass -Command "$f='%TOMCAT_HOME%\conf\server.xml'; try { [xml]$x=Get-Content -LiteralPath $f; $c=$x.SelectNodes('//Connector') | Where-Object { $_.port -and $_.protocol -notmatch 'AJP' } | Select-Object -First 1; if($c){ [Console]::WriteLine([string]$c.port) } } catch {}" > "%TEMP%\jspservlet_port.txt" 2>nul
if exist "%TEMP%\jspservlet_port.txt" (
  set /p "PORT_VALUE="<"%TEMP%\jspservlet_port.txt"
  if defined PORT_VALUE (echo(%PORT_VALUE%| findstr /r "^[0-9][0-9]*$" >nul && set "HTTP_PORT=%PORT_VALUE%")
  del "%TEMP%\jspservlet_port.txt" >nul 2>&1
)
echo [OK] Port candidate: %HTTP_PORT%

echo.
echo [4/6] Creating project files and folders...
set "APP_ROOT=%TOMCAT_HOME%\webapps\%APP_NAME%"
if not exist "%APP_ROOT%" md "%APP_ROOT%" >nul 2>&1
if not exist "%APP_ROOT%" (
  echo [ERROR] Cannot create "%APP_ROOT%". Check permissions.
  goto :FAIL
)

rem Inspect servlet-api.jar to choose javax or jakarta namespace.
"%JAR%" tf "%TOMCAT_HOME%\lib\servlet-api.jar" 2>nul | findstr /c:"jakarta/servlet/http/HttpServlet.class" >nul
if errorlevel 1 (
  set "JAVA_SOURCE_B64=aW1wb3J0IGphdmEuaW8uKjsKaW1wb3J0IGphdmF4LnNlcnZsZXQuaHR0cC4qOwppbXBvcnQgamF2YXguc2VydmxldC5hbm5vdGF0aW9uLldlYlNlcnZsZXQ7CgpAV2ViU2VydmxldCgiL2hlbGxvIikKcHVibGljIGNsYXNzIEhlbGxvU2VydmxldCBleHRlbmRzIEh0dHBTZXJ2bGV0IHsKICAgIHB1YmxpYyB2b2lkIGRvUG9zdChIdHRwU2VydmxldFJlcXVlc3QgcmVxdWVzdCwgSHR0cFNlcnZsZXRSZXNwb25zZSByZXNwb25zZSkKICAgICAgICAgICAgdGhyb3dzIElPRXhjZXB0aW9uIHsKICAgICAgICByZXNwb25zZS5zZXRDb250ZW50VHlwZSgidGV4dC9odG1sIik7CiAgICAgICAgUHJpbnRXcml0ZXIgb3V0ID0gcmVzcG9uc2UuZ2V0V3JpdGVyKCk7CgogICAgICAgIFN0cmluZyBuYW1lID0gcmVxdWVzdC5nZXRQYXJhbWV0ZXIoInVzZXJuYW1lIik7CiAgICAgICAgaWYgKG5hbWUgPT0gbnVsbCB8fCBuYW1lLmlzRW1wdHkoKSkKICAgICAgICAgICAgbmFtZSA9ICJHdWVzdCI7CgogICAgICAgIG91dC5wcmludGxuKCI8aDI+SGVsbG8sICIgKyBuYW1lICsgIiEgV2VsY29tZSB0byBTZXJ2bGV0LjwvaDI+Iik7CiAgICB9Cn0K"
) else (
  set "JAVA_SOURCE_B64=aW1wb3J0IGphdmEuaW8uKjsKaW1wb3J0IGpha2FydGEuc2VydmxldC5odHRwLio7CmltcG9ydCBqYWthcnRhLnNlcnZsZXQuYW5ub3RhdGlvbi5XZWJTZXJ2bGV0OwoKQFdlYlNlcnZsZXQoIi9oZWxsbyIpCnB1YmxpYyBjbGFzcyBIZWxsb1NlcnZsZXQgZXh0ZW5kcyBIdHRwU2VydmxldCB7CiAgICBwdWJsaWMgdm9pZCBkb1Bvc3QoSHR0cFNlcnZsZXRSZXF1ZXN0IHJlcXVlc3QsIEh0dHBTZXJ2bGV0UmVzcG9uc2UgcmVzcG9uc2UpCiAgICAgICAgICAgIHRocm93cyBJT0V4Y2VwdGlvbiB7CiAgICAgICAgcmVzcG9uc2Uuc2V0Q29udGVudFR5cGUoInRleHQvaHRtbCIpOwogICAgICAgIFByaW50V3JpdGVyIG91dCA9IHJlc3BvbnNlLmdldFdyaXRlcigpOwoKICAgICAgICBTdHJpbmcgbmFtZSA9IHJlcXVlc3QuZ2V0UGFyYW1ldGVyKCJ1c2VybmFtZSIpOwogICAgICAgIGlmIChuYW1lID09IG51bGwgfHwgbmFtZS5pc0VtcHR5KCkpCiAgICAgICAgICAgIG5hbWUgPSAiR3Vlc3QiOwoKICAgICAgICBvdXQucHJpbnRsbigiPGgyPkhlbGxvLCAiICsgbmFtZSArICIhIFdlbGNvbWUgdG8gU2VydmxldC48L2gyPiIpOwogICAgfQp9Cg=="
)
set "HELPER=%TEMP%\jspservlet_make_%RANDOM%.ps1"
>"%HELPER%" echo cGFyYW0oW3N0cmluZ10kUm9vdCxbc3RyaW5nXSRKc3BCNjQsW3N0cmluZ10kSmF2YUI2NCkKJEVycm9yQWN0aW9uUHJlZmVyZW5jZSA9ICdTdG9wJwokdXRmOCA9IE5ldy1PYmplY3QgU3lzdGVtLlRleHQuVVRGOEVuY29kaW5nKCRmYWxzZSkKTmV3LUl0ZW0gLUl0ZW1UeXBlIERpcmVjdG9yeSAtRm9yY2UgLVBhdGggKEpvaW4tUGF0aCAkUm9vdCAnV0VCLUlORlxjbGFzc2VzJykgfCBPdXQtTnVsbAokanNwUGF0aCA9IEpvaW4tUGF0aCAkUm9vdCAnaW5kZXguanNwJwokamF2YVBhdGggPSBKb2luLVBhdGggJFJvb3QgJ0hlbGxvU2VydmxldC5qYXZhJwojIFRoaXMgaXMgYSBkZWRpY2F0ZWQgZ2VuZXJhdGVkIGRlbW8gYXBwOiBhbHdheXMgcmVmcmVzaCBpdHMgc2FtcGxlIHNvdXJjZXMuCltJTy5GaWxlXTo6V3JpdGVBbGxUZXh0KCRqc3BQYXRoLFtUZXh0LkVuY29kaW5nXTo6VVRGOC5HZXRTdHJpbmcoW0NvbnZlcnRdOjpGcm9tQmFzZTY0U3RyaW5nKCRKc3BCNjQpKSwkdXRmOCkKW0lPLkZpbGVdOjpXcml0ZUFsbFRleHQoJGphdmFQYXRoLFtUZXh0LkVuY29kaW5nXTo6VVRGOC5HZXRTdHJpbmcoW0NvbnZlcnRdOjpGcm9tQmFzZTY0U3RyaW5nKCRKYXZhQjY0KSksJHV0ZjgpCiMgUmVtb3ZlIHN0YWxlIGRlc2NyaXB0b3IgbWFwcGluZ3Mgc3VjaCBhcyBkZW1vLkhlbGxvU2VydmxldDsgYW5ub3RhdGlvbiBpcyB0aGUgc29sZSBtYXBwaW5nLgokd2ViWG1sID0gSm9pbi1QYXRoICRSb290ICdXRUItSU5GXHdlYi54bWwnCmlmIChUZXN0LVBhdGggLUxpdGVyYWxQYXRoICR3ZWJYbWwpIHsgUmVtb3ZlLUl0ZW0gLUxpdGVyYWxQYXRoICR3ZWJYbWwgLUZvcmNlIH0KV3JpdGUtT3V0cHV0ICdTYW1wbGUgc291cmNlcyByZWZyZXNoZWQ7IHN0YWxlIHdlYi54bWwgcmVtb3ZlZC4nCg==
"%PS%" -NoProfile -ExecutionPolicy Bypass -Command "$b=[IO.File]::ReadAllText('%HELPER%').Trim();$s=[Text.Encoding]::UTF8.GetString([Convert]::FromBase64String($b));$p='%TEMP%\jspservlet_make_runtime.ps1';[IO.File]::WriteAllText($p,$s,(New-Object System.Text.UTF8Encoding($false)));& $p -Root '%APP_ROOT%' -JspB64 'PCFET0NUWVBFIGh0bWw+CjxodG1sPgo8Ym9keT4KICAgIDxmb3JtIGFjdGlvbj0iaGVsbG8iIG1ldGhvZD0icG9zdCI+CiAgICAgICAgTmFtZToKICAgICAgICA8aW5wdXQgdHlwZT0idGV4dCIgbmFtZT0idXNlcm5hbWUiPgogICAgICAgIDxpbnB1dCB0eXBlPSJzdWJtaXQiIHZhbHVlPSJTdWJtaXQiPgogICAgPC9mb3JtPgo8L2JvZHk+CjwvaHRtbD4K' -JavaB64 '%JAVA_SOURCE_B64%';$rc=$LASTEXITCODE;Remove-Item -LiteralPath '%HELPER%' -Force -ErrorAction SilentlyContinue;exit $rc"
if errorlevel 1 (
  echo [ERROR] Failed to create JSP and Java source files.
  goto :FAIL
)
echo [OK] index.jsp
echo [OK] HelloServlet.java
echo [OK] WEB-INF\classes

echo.
rem Clean generated classes completely so stale servlet classes cannot register /hello twice.
rem The helper also removes stale WEB-INF\web.xml mappings and refreshes the demo source files.
if exist "%APP_ROOT%\WEB-INF\classes" rmdir /s /q "%APP_ROOT%\WEB-INF\classes"
md "%APP_ROOT%\WEB-INF\classes" >nul 2>&1
if not exist "%APP_ROOT%\WEB-INF\classes" (echo [ERROR] Cannot recreate WEB-INF\classes.& goto :FAIL)
echo [5/6] Compiling servlet...
"%JAVAC%" -encoding UTF-8 -cp "%TOMCAT_HOME%\lib\servlet-api.jar" -d "%APP_ROOT%\WEB-INF\classes" "%APP_ROOT%\HelloServlet.java"
if errorlevel 1 (
  echo [ERROR] Compilation failed. Review the imports and Tomcat version.
  goto :FAIL
)
echo [OK] HelloServlet.class compiled.

echo.
echo [6/6] Starting Tomcat and waiting for the app...
rem Always pass the dynamically detected JDK to the Tomcat process.
"%PS%" -NoProfile -ExecutionPolicy Bypass -Command "try { $r=Invoke-WebRequest -UseBasicParsing -TimeoutSec 2 -Uri 'http://127.0.0.1:%HTTP_PORT%/'; exit 0 } catch { if($_.Exception.Response){exit 0}; exit 1 }" >nul 2>&1
if errorlevel 1 (set "JAVA_HOME=%JAVA_HOME_FOUND%" & set "JRE_HOME=" & start "Tomcat - JSPServletDemo" /D "%TOMCAT_HOME%\bin" "%TOMCAT_HOME%\bin\catalina.bat" run)
set /a WAIT_COUNT=0
:WAIT_LOOP
"%PS%" -NoProfile -ExecutionPolicy Bypass -Command "try { $r=Invoke-WebRequest -UseBasicParsing -TimeoutSec 2 -Uri 'http://127.0.0.1:%HTTP_PORT%/%APP_NAME%/'; if($r.StatusCode -lt 500){exit 0};exit 1 } catch { if($_.Exception.Response){exit 0};exit 1 }" >nul 2>&1
if not errorlevel 1 goto :SUCCESS
set /a WAIT_COUNT+=1
if %WAIT_COUNT% GEQ 30 goto :START_FAIL
timeout /t 2 /nobreak >nul
goto :WAIT_LOOP

:SUCCESS
echo.
echo ============================================================
echo [SUCCESS] JSP and Servlet demo is running.
echo JSP     : http://localhost:%HTTP_PORT%/%APP_NAME%/
echo Servlet : http://localhost:%HTTP_PORT%/%APP_NAME%/hello
echo Project : "%APP_ROOT%"
echo ============================================================
start "" "http://localhost:%HTTP_PORT%/%APP_NAME%/"
pause
exit /b 0

:FIND_JDK
if defined JAVA_HOME (set "JAVA_HOME_FOUND=%JAVA_HOME%"& call :VALIDATE_JDK)
if defined JAVA_HOME_FOUND exit /b 0
if defined JDK_HOME (set "JAVA_HOME_FOUND=%JDK_HOME%"& call :VALIDATE_JDK)
if defined JAVA_HOME_FOUND exit /b 0
for /f "delims=" %%J in ('where javac.exe 2^>nul') do if not defined JAVA_HOME_FOUND for %%D in ("%%~dpJ..") do set "JAVA_HOME_FOUND=%%~fD"
if defined JAVA_HOME_FOUND call :VALIDATE_JDK
if defined JAVA_HOME_FOUND exit /b 0
for %%K in ("HKLM\SOFTWARE\JavaSoft\JDK" "HKLM\SOFTWARE\JavaSoft\Java Development Kit" "HKLM\SOFTWARE\WOW6432Node\JavaSoft\JDK" "HKLM\SOFTWARE\WOW6432Node\JavaSoft\Java Development Kit" "HKLM\SOFTWARE\Eclipse Adoptium\JDK" "HKLM\SOFTWARE\Amazon Corretto") do call :REGISTRY_JDK "%%~K"
if defined JAVA_HOME_FOUND exit /b 0
for %%D in ("%ProgramFiles%\Java\jdk*" "%ProgramFiles%\Eclipse Adoptium\jdk*" "%ProgramFiles%\Microsoft\jdk-*" "%ProgramFiles%\Amazon Corretto\jdk*" "%ProgramFiles%\BellSoft\LibericaJDK*" "%ProgramFiles%\Zulu\zulu*" "%LOCALAPPDATA%\Programs\Eclipse Adoptium\jdk*" "%LOCALAPPDATA%\Programs\Microsoft\jdk-*") do if not defined JAVA_HOME_FOUND if exist "%%~D\bin\java.exe" if exist "%%~D\bin\javac.exe" set "JAVA_HOME_FOUND=%%~D"
if defined JAVA_HOME_FOUND call :VALIDATE_JDK
exit /b 0

:VALIDATE_JDK
if not defined JAVA_HOME_FOUND exit /b 1
set "JAVA_HOME_FOUND=%JAVA_HOME_FOUND:"=%"
for %%I in ("%JAVA_HOME_FOUND%") do set "JAVA_HOME_FOUND=%%~fI"
if not exist "%JAVA_HOME_FOUND%\bin\java.exe" set "JAVA_HOME_FOUND="
if defined JAVA_HOME_FOUND if not exist "%JAVA_HOME_FOUND%\bin\javac.exe" set "JAVA_HOME_FOUND="
exit /b 0

:REGISTRY_JDK
if defined JAVA_HOME_FOUND exit /b 0
set "REG_KEY=%~1"
set "REG_VER="
for /f "tokens=2,*" %%A in ('reg query "%REG_KEY%" /v CurrentVersion 2^>nul ^| findstr /i "CurrentVersion"') do set "REG_VER=%%B"
if defined REG_VER for /f "tokens=2,*" %%A in ('reg query "%REG_KEY%\%REG_VER%" /v JavaHome 2^>nul ^| findstr /i "JavaHome"') do set "JAVA_HOME_FOUND=%%B"
if defined JAVA_HOME_FOUND call :VALIDATE_JDK
exit /b 0

:BAD_TOMCAT
echo [ERROR] Invalid Tomcat root. It must contain bin\startup.bat, lib\servlet-api.jar and webapps.
goto :FAIL
:START_FAIL
echo [ERROR] Tomcat did not respond within 60 seconds.
echo Check Tomcat console, logs, port conflicts and Java/Tomcat compatibility.
goto :FAIL
:FAIL
echo.
echo Runner stopped. Fix the error above and try again.
pause
exit /b 1
