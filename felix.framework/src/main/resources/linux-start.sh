#!/bin/bash

SHARK_DIR=${SHARK_HOME}/felix-framework
TMP_DIR=${SHARK_DIR}/felix-cache
TODAY=$(date +"%Y-%m-%d")
LOG_FILE=${SHARK_DIR}/logs/framework_${TODAY}.log

rm -fr ${TMP_DIR}/io_tmp
echo "JAVA io tmp folder deleted"
rm -fr ${TMP_DIR}/bundles
echo "Felix bundles cache deleted"

DEBUG_OPTS="-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=30303"
echo "debug options: '${DEBUG_OPTS}'"
JAVA_OPTS="-Djava.io.tmpdir=${TMP_DIR}/io_tmp -Dfile.encoding=UTF-8"
echo "java options: '${JAVA_OPTS}'"
LOGGING_OPTS="-Dlogback.configurationFile=${SHARK_DIR}/conf/logback-dev.xml"
echo "logging options: '${LOGGING_OPTS}'"
FELIX_OPTS="-Dgosh.args=--nointeractive -Dorg.osgi.framework.storage=${TMP_DIR}/bundles"
# host
FELIX_OPTS="${FELIX_OPTS} -Dorg.apache.felix.http.host=0.0.0.0"
# port
FELIX_OPTS="${FELIX_OPTS} -Dorg.osgi.service.http.port=8080"
# webconsole username and password
FELIX_OPTS="${FELIX_OPTS} -Dfelix.webconsole.username=admin -Dfelix.webconsole.password=admin"
echo "felix options: '${FELIX_OPTS}'"

cd ${SHARK_DIR}
echo "folder changed to: '$(pwd)'"

COMMAND="java ${DEBUG_OPTS} ${JAVA_OPTS} ${LOGGING_OPTS} ${FELIX_OPTS} -jar bin/felix.jar"
echo "running '${COMMAND}'"

# running with nohup
# see
# https://www.cyberciti.biz/tips/nohup-execute-commands-after-you-exit-from-a-shell-prompt.html
nohup ${COMMAND} >> ${LOG_FILE} 2>&1&
