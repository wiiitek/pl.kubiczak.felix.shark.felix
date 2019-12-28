@ECHO OFF

REM settings

SET GMAIL_USERNAME=%SHARK_GMAIL_USERNAME%
SET GMAIL_PASSWORD=%SHARK_GMAIL_PASSWORD%
SET SHARK_DIR=%SHARK_HOME%/felix-framework
SET TMP_DIR=%SHARK_DIR%/felix-cache
SET LOG_DIR=%SHARK_DIR%/logs
SET LOG_CONF_FILE=%SHARK_DIR%/conf/logback-dev.xml
SET IP=0.0.0.0
SET PORT=8080
SET WEBCONSOLE_USERNAME=admin
SET WEBCONSOLE_PASSWORD=admin
SET DEBUG_OPTS=-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=30303

REM end of settings

FOR /f "tokens=2 delims==" %%a IN ('wmic OS Get localdatetime /value') DO SET "dt=%%a"
SET YYYY=%dt:~0,4%
SET MM=%dt:~4,2%
SET DD=%dt:~6,2%
SET TODAY=%YYYY%-%MM%-%DD%
SET LOG_FILE=%LOG_DIR%/framework_%TODAY%.log

IF EXIST "%TMP_DIR%/io_tmp" ( RMDIR /S /Q "%TMP_DIR%/io_tmp"
	ECHO JAVA io tmp folder deleted )
IF EXIST "%TMP_DIR%/bundles" ( RMDIR /S /Q "%TMP_DIR%/bundles"
	ECHO Felix bundles cache deleted )
REM DEL command needs backslash here
IF EXIST "%LOG_DIR%/default_dev.log" ( DEL /F /Q "%LOG_DIR%\default_dev.log"
	ECHO Default dev log file deleted )

SET JAVA_OPTS=%DEBUG_OPTS% -Djava.io.tmpdir=%TMP_DIR%/io_tmp -Dfile.encoding=UTF-8
ECHO java options: '%JAVA_OPTS%'
SET LOGGING_OPTS=-Dlogback.configurationFile=%LOG_CONF_FILE%
ECHO logging options: '%LOGGING_OPTS%'
SET FELIX_OPTS=-Dgosh.args=--nointeractive -Dorg.osgi.framework.storage=%TMP_DIR%/bundles
REM host
SET FELIX_OPTS=%FELIX_OPTS% -Dorg.apache.felix.http.host=%IP%
REM port
SET FELIX_OPTS=%FELIX_OPTS% -Dorg.osgi.service.http.port=%PORT%
REM start level
SET FELIX_OPTS=%FELIX_OPTS% -Dorg.osgi.framework.startlevel.beginning=30
REM cache
SET FELIX_OPTS=%FELIX_OPTS% -Dorg.osgi.framework.storage=%TMP_DIR%/bundles
REM do not save configuration in files
SET FELIX_OPTS=%FELIX_OPTS% -Dfelix.fileinstall.enableConfigSave=false
REM webconsole username and password
SET FELIX_OPTS=%FELIX_OPTS% -Dfelix.webconsole.username=%WEBCONSOLE_USERNAME% -Dfelix.webconsole.password=%WEBCONSOLE_PASSWORD%
ECHO felix options: '%FELIX_OPTS%'
SET AUTH_OPTS=-Dshark.gmail.username=%GMAIL_USERNAME% -Dshark.gmail.password=%GMAIL_PASSWORD%

CD "%SHARK_DIR%"
FOR /f %%i IN ('CD') DO SET PWD=%%i
ECHO folder changed to: '%PWD%'

SET COMMAND=java %JAVA_OPTS% %LOGGING_OPTS% %FELIX_OPTS% -jar bin/felix.jar
ECHO running: '%COMMAND%'
REM overwritten, but we don't echo authentication parameters
SET COMMAND=java %JAVA_OPTS% %LOGGING_OPTS% %FELIX_OPTS% %AUTH_OPTS% -jar bin/felix.jar
REM for jline (to not have an exception if it's set to some unknown value)
SET TERM=ansi
%COMMAND%
