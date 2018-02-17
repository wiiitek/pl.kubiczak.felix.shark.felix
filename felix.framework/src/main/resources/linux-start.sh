#!/bin/bash

# settings

GMAIL_USERNAME=${SHARK_GMAIL_USERNAME}
GMAIL_PASSWORD=${SHARK_GMAIL_PASSWORD}
SHARK_DIR=${SHARK_HOME}/felix-framework
TMP_DIR=${SHARK_DIR}/felix-cache
LOG_DIR=${SHARK_DIR}/logs
LOG_CONF_FILE=${SHARK_DIR}/conf/logback-dev.xml
IP=0.0.0.0
PORT=8080
WEBCONSOLE_USERNAME=admin
WEBCONSOLE_PASSWORD=admin
DEBUG_OPTS=-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=30303

# end of settings

TODAY=$(date +"%Y-%m-%d")
LOG_FILE=${LOG_DIR}/framework_${TODAY}.log

rm -fr ${TMP_DIR}/io_tmp
echo "JAVA io tmp folder deleted"
rm -fr ${TMP_DIR}/bundles
echo "Felix bundles cache deleted"
rm -fr ${LOG_DIR}/default_dev.log
echo "Default dev log file deleted"

JAVA_OPTS="${DEBUG_OPTS} -Djava.io.tmpdir=${TMP_DIR}/io_tmp -Dfile.encoding=UTF-8"
echo "java options: '${JAVA_OPTS}'"
LOGGING_OPTS="-Dlogback.configurationFile=${LOG_CONF_FILE}"
echo "logging options: '${LOGGING_OPTS}'"
FELIX_OPTS="-Dgosh.args=--nointeractive -Dorg.osgi.framework.storage=${TMP_DIR}/bundles"
# host
FELIX_OPTS="${FELIX_OPTS} -Dorg.apache.felix.http.host=${IP}"
# port
FELIX_OPTS="${FELIX_OPTS} -Dorg.osgi.service.http.port=${PORT}"
# start level
FELIX_OPTS="${FELIX_OPTS} -Dorg.osgi.framework.startlevel.beginning=30"
# cache
FELIX_OPTS="${FELIX_OPTS} -Dorg.osgi.framework.storage=%TMP_DIR%/bundles"
# do not save configuration in files
FELIX_OPTS="${FELIX_OPTS} -Dfelix.fileinstall.enableConfigSave=false"
# webconsole username and password
FELIX_OPTS="${FELIX_OPTS} -Dfelix.webconsole.username=${WEBCONSOLE_USERNAME} -Dfelix.webconsole.password=${WEBCONSOLE_PASSWORD}"
echo "felix options: '${FELIX_OPTS}'"
AUTH_OPTS="-Dshark.gmail.username=${GMAIL_USERNAME} -Dshark.gmail.password=${GMAIL_PASSWORD}"

cd ${SHARK_DIR}
echo "folder changed to: '$(pwd)'"

COMMAND="java ${JAVA_OPTS} ${LOGGING_OPTS} ${FELIX_OPTS} -jar bin/felix.jar"
echo "running '${COMMAND}'"
# overwritten, but we don't echo authentication parameters
COMMAND="java ${JAVA_OPTS} ${LOGGING_OPTS} ${FELIX_OPTS} ${AUTH_OPTS} -jar bin/felix.jar"
# running with nohup
# see
# https://www.cyberciti.biz/tips/nohup-execute-commands-after-you-exit-from-a-shell-prompt.html
nohup ${COMMAND} >> ${LOG_FILE} 2>&1&
