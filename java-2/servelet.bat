
@echo off
setlocal
title Universal JSP and Servlet Runner

echo ========================================
echo     UNIVERSAL JSP + SERVLET RUNNER
echo ========================================
echo.

REM 1. Find JDK
if defined JAVA_HOME if exist "%JAVA_HOME%\bin\javac.exe" goto java_found

where javac >nul 2>&1
if not errorlevel 1 goto detect_java

echo JDK not found in PATH.
set /p "JAVA_HOME=Enter JDK folder path: "
if exist "%JAVA_HOME%\bin\javac.exe" goto java_found

echo ERROR: Invalid JDK folder.
echo Example: C:\Program Files\Java\jdk-21
pause
exit /b 1

:detect_java
for /f "delims=" %%J in ('where javac') do (
    set "JAVAC_PATH=%%J"
    goto derive_java
)

:derive_java
for %%I in ("%JAVAC_PATH%") do set "JAVA_BIN=%%~dpI"
for %%I in ("%JAVA_BIN%..") do set "JAVA_HOME=%%~fI"

if exist "%JAVA_HOME%\bin\javac.exe" goto java_found
echo ERROR: Could not detect JDK.
pause
exit /b 1

:java_found
echo JDK: %JAVA_HOME%

REM 2. Detect Tomcat
if defined CATALINA_HOME if exist "%CATALINA_HOME%\lib\servlet-api.jar" (
    set "TOMCAT=%CATALINA_HOME%"
    goto tomcat_found
)

if defined TOMCAT_HOME if exist "%TOMCAT_HOME%\lib\servlet-api.jar" (
    set "TOMCAT=%TOMCAT_HOME%"
    goto tomcat_found
)

echo.
set /p "TOMCAT=Enter Tomcat ROOT folder path: "

if exist "%TOMCAT%\lib\servlet-api.jar" goto tomcat_found

echo ERROR: Tomcat folder is invalid.
echo Choose the folder containing bin, lib and webapps.
pause
exit /b 1

:tomcat_found
echo Tomcat: %TOMCAT%

REM 3. Project files stay beside this BAT file
set "PROJECT=%~dp0"
set "APP=%TOMCAT%\webapps\ServletDemo"
set "CLASSES=%APP%\WEB-INF\classes"

REM 4. Create Java source automatically
(
echo import java.io.*;
echo import javax.servlet.http.*;
echo import javax.servlet.annotation.WebServlet;
echo.
echo @WebServlet^("/hello"^)
echo public class HelloServlet extends HttpServlet {
echo     public void doGet^(HttpServletRequest req, HttpServletResponse res^) throws IOException {
echo         res.setContentType^("text/html"^);
echo         res.getWriter^(^).println^("<h2>Hello from Servlet!</h2>"^);
echo     }
echo }
) > "%PROJECT%HelloServlet.java"

REM 5. Create JSP automatically
(
echo ^<html^>
echo ^<body^>
echo ^<h2^>Invoke Servlet from JSP^</h2^>
echo ^<form action="hello" method="get"^>
echo ^<button type="submit"^>Call Servlet^</button^>
echo ^</form^>
echo ^</body^>
echo ^</html^>
) > "%PROJECT%index.jsp"

REM 6. Create deployment folders
if not exist "%CLASSES%" mkdir "%CLASSES%"
if not exist "%CLASSES%" (
    echo ERROR: Cannot create deployment folder.
    echo Check permissions.
    pause
    exit /b 1
)

REM 7. Compile servlet
echo.
echo Compiling servlet...

"%JAVA_HOME%\bin\javac.exe" -cp "%TOMCAT%\lib\servlet-api.jar" -d "%CLASSES%" "%PROJECT%HelloServlet.java"

if errorlevel 1 (
    echo Compilation failed.
    echo This example requires Tomcat 9 javax.servlet API.
    pause
    exit /b 1
)

REM 8. Copy JSP
copy /Y "%PROJECT%index.jsp" "%APP%\index.jsp" >nul

REM 9. Start Tomcat
echo.
echo Starting Tomcat...
call "%TOMCAT%\bin\startup.bat"

timeout /t 5 >nul

REM 10. Open browser
start "" "http://localhost:8080/ServletDemo/index.jsp"

echo.
echo Check the browser for your JSP page.
pause
