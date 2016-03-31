#!/bin/bash

JAVA_IO_TMPDIR=./tmp/io_tmp

rm -fr $JAVA_IO_TMPDIR

DEBUG_OPTS="-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=30303"
LOGGING_OPTS="-Dlogback.configurationFile=./conf/logback-dev.xml"
JAVA_OPTS="-Djava.io.tmpdir=$JAVA_IO_TMPDIR"

PATH=$JAVA_HOME/bin:$PATH

java $DEBUG_OPTS $LOGGING_OPTS $JAVA_OPTS -jar bin/felix.jar
