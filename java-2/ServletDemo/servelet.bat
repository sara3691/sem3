
@echo off
setlocal
title JSP and Servlet - One Click Runner

echo ==========================================
echo       JSP AND SERVLET RUNNER
echo ==========================================

REM 1. Find Java
where javac >nul 2>&1
if errorlevel 1 (
    echo ERROR: Install JDK and add it to PATH.
    pause
    exit /b 1
)

REM Detect JAVA_HOME if missing
if not defined JAVA_HOME (
    for /f "delims=" %%J in ('where javac') do (
        set "JAVAC_PATH=%%J"
        goto findjava
    )
)
goto java_ready

:findjava
for %%I in ("%JAVAC_PATH%") do set "JAVA_BIN=%%~dpI"
for %%I in ("%JAVA_BIN%..") do set "JAVA_HOME=%%~fI"

:java_ready
if not exist "%JAVA_HOME%\bin\javac.exe" (
    echo ERROR: Cannot find JDK.
    echo Set JAVA_HOME to your JDK folder.
    pause
    exit /b 1
)

REM 2. Find Tomcat
if defined CATALINA_HOME (
    set "TOMCAT=%CATALINA_HOME%"
) else if defined TOMCAT_HOME (
    set "TOMCAT=%TOMCAT_HOME%"
) else (
    set /p "TOMCAT=Enter Tomcat root folder path: "
)

if not exist "%TOMCAT%\lib\servlet-api.jar" (
    echo ERROR: Invalid Tomcat folder.
    pause
    exit /b 1
)

REM 3. Project and deployment folders
set "PROJECT=%~dp0ServletDemo"
set "APP=%TOMCAT%\webapps\ServletDemo"
set "CLASSES=%APP%\WEB-INF\classes"

mkdir "%PROJECT%" 2>nul
mkdir "%APP%\WEB-INF\classes" 2>nul

REM 4. Automatically create Java Servlet file
(
echo import java.io.*;
echo import javax.servlet.*;
echo import javax.servlet.http.*;
echo import javax.servlet.annotation.WebServlet;
echo.
echo @WebServlet^("/hello"^)
echo public class HelloServlet extends HttpServlet {
echo     public void doGet^(HttpServletRequest req, HttpServletResponse res^) throws IOException {
echo         res.setContentType^("text/html"^);
echo         PrintWriter out = res.getWriter^(^);
echo         out.println^("<h2>Hello from Servlet!</h2>"^);
echo     }
echo }
) > "%PROJECT%\HelloServlet.java"

REM 5. Automatically create JSP file
(
echo ^<html^>
echo ^<body^>
echo ^<h2^>Invoke Servlet from JSP^</h2^>
echo ^<form action="hello" method="get"^>
echo ^<button type="submit"^>Call Servlet^</button^>
echo ^</form^>
echo ^</body^>
echo ^</html^>
) > "%PROJECT%\index.jsp"

REM 6. Copy JSP to Tomcat
copy /Y "%PROJECT%\index.jsp" "%APP%\index.jsp" >nul

REM 7. Compile Java Servlet
echo.
echo Compiling Servlet...
"%JAVA_HOME%\bin\javac.exe" -cp "%TOMCAT%\lib\servlet-api.jar" -d "%CLASSES%" "%PROJECT%\HelloServlet.java"

if errorlevel 1 (
    echo Compilation failed. Check Tomcat version and Java setup.
    pause
    exit /b 1
)

REM 8. Start Tomcat
echo.
echo Starting Tomcat...
call "%TOMCAT%\bin\startup.bat"

timeout /t 5 >nul

REM 9. Open browser
start "" "http://localhost:8080/ServletDemo/index.jsp"

echo.
echo Project files created and deployed.
echo ServletDemo folder: "%PROJECT%"
pause
