@ECHO OFF
COLOR 02

IF EXIST .\felix-cache\io_tmp (
	echo "Deleting temporary JAVA IO files..."
	RMDIR /S /Q .\felix-cache\io_tmp
)

SET DEBUG_OPTS=-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=30303
SET LOGGING_OPTS=-Dlogback.configurationFile=./conf/logback-dev.xml
SET JAVA_OPTS=-Djava.io.tmpdir=./felix-cache/io_tmp

SET PATH=%JAVA_HOME%\bin;%PATH%

java.exe %DEBUG_OPTS% %LOGGING_OPTS% %JAVA_OPTS% -jar bin/felix.jar
