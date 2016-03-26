@ECHO OFF
COLOR 02

IF EXIST .\tmp\io_tmp (
	echo "Deleting temporary JAVA IO files..."
	DEL /S /Q .\tmp\io_tmp
)

SET DEBUG_OPTS=-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=30303
SET JAVA_OPTS=-Djava.io.tmpdir=./tmp/io_tmp

SET PATH=%JAVA_HOME%\bin;%PATH%

java.exe %DEBUG_OPTS% %JAVA_OPTS% -jar bin/felix.jar
