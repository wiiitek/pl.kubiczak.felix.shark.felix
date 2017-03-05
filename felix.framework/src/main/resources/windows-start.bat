@ECHO OFF
COLOR 08

SET SHARK_DIR=%SHARK_HOME%/felix-framework
SET TMP_DIR=%SHARK_DIR%/felix-cache

FOR /f "tokens=2 delims==" %%a IN ('wmic OS Get localdatetime /value') DO SET "dt=%%a"
SET YYYY=%dt:~0,4%
SET MM=%dt:~4,2%
SET DD=%dt:~6,2%
SET TODAY=%YYYY%-%MM%-%DD%

SET LOG_FILE=%SHARK_DIR%/logs/framework_%TODAY%.log

IF EXIST "%TMP_DIR%/io_tmp" (
	RMDIR /S /Q "%TMP_DIR%/io_tmp"
	ECHO JAVA io tmp folder deleted
)
IF EXIST "%TMP_DIR%/bundles" (
	RMDIR /S /Q "%TMP_DIR%/bundles"
	ECHO Felix bundles cache deleted
)

SET DEBUG_OPTS=-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=30303
ECHO debug options: '%DEBUG_OPTS%'
SET LOGGING_OPTS=-Dlogback.configurationFile=%SHARK_DIR%/conf/logback-dev.xml
ECHO logging options: '%LOGGING_OPTS%'
SET JAVA_OPTS=-Djava.io.tmpdir=%TMP_DIR%/io_tmp -Dfile.encoding=UTF-8
ECHO java options: '%JAVA_OPTS%'
SET FELIX_OPTS=-Dgosh.args=--nointeractive -Dorg.osgi.framework.storage=%TMP_DIR%/bundles
REM host
SET FELIX_OPTS=%FELIX_OPTS% -Dorg.apache.felix.http.host=0.0.0.0
REM port
SET FELIX_OPTS=%FELIX_OPTS% -Dorg.osgi.service.http.port=8080
REM webconsole username and password
SET FELIX_OPTS=%FELIX_OPTS% -Dfelix.webconsole.username=admin -Dfelix.webconsole.password=admin
ECHO felix options: '%FELIX_OPTS%'

CD "%SHARK_DIR%"
FOR /f %%i IN ('CD') DO SET PWD=%%i
ECHO folder changed to: '%PWD%'

SET COMMAND=java %DEBUG_OPTS% %FELIX_OPTS% %LOGGING_OPTS% %JAVA_OPTS% -jar bin/felix.jar
ECHO running: '%COMMAND%'

%COMMAND%
