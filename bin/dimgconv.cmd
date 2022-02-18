@echo off

REM ============================[ VARIABLES ]================================
SETLOCAL
SET JAVAEXE=
SET JAVAOPTS=-Xms64M -Xmx768M
SET MAINCLASS=net.mtrop.doom.tools.DoomImageConvertMain
SET DOOMTOOLS_PATH=%~dp0
SET DOOMTOOLS_JAR=

REM ===== Get latest JAR.
FOR /F %%F in ('dir "%DOOMTOOLS_PATH%\jar\*.jar" /a/b/n') DO ( SET DOOMTOOLS_JAR=jar\%%F )

REM =========================================================================

if not "%DOOMTOOLS_JAR%"=="" goto _findjava
echo FATAL ERROR: DoomTools application JAR NOT FOUND!
goto _end

:_findjava
REM ===== Java Scan

if exist "%DOOMTOOLS_PATH%\jre\bin\java.exe" SET JAVAEXE=%DOOMTOOLS_PATH%\jre\bin\java.exe
if not "%JAVAEXE%"=="" goto _calljava

where java > nul
if %ERRORLEVEL% == 0 SET JAVAEXE=java
if not "%JAVAEXE%"=="" goto _calljava

if not %JAVA_HOME%=="" SET JAVAEXE=%JAVA_HOME%\bin\java.exe
if not "%JAVAEXE%"=="" goto _calljava

if not %JDK_HOME%=="" SET JAVAEXE=%JDK_HOME%\bin\java.exe
if not "%JAVAEXE%"=="" goto _calljava

if not %JRE_HOME%=="" SET JAVAEXE=%JRE_HOME%\java.exe
if not "%JAVAEXE%"=="" goto _calljava

REM ===== No Java.

echo Java 8 or higher could not be detected. To use these tools, a JRE must be 
echo installed.
echo.
echo The environment variables JAVA_HOME, JRE_HOME, or JDK_HOME are not set to 
echo your JRE or JDK directories, nor were Java binaries detected on your PATH.
echo.
echo For help, visit https://www.java.com/.
echo.
echo Java can be downloaded from the following places:
echo.
echo Azul:      https://www.azul.com/downloads/
echo Microsoft: https://www.microsoft.com/openjdk
echo Oracle:    https://java.com/en/download/
echo.

goto _end

REM =========================

:_calljava
"%JAVAEXE%" -cp "%DOOMTOOLS_PATH%\%DOOMTOOLS_JAR%" %JAVAOPTS% %MAINCLASS% %*

:_end
ENDLOCAL
