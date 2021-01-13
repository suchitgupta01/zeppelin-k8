#https://hub.docker.com/r/apache/zeppelin/dockerfile
ARG ZEPPELIN_IMAGE=apache/zeppelin:0.9.0
FROM ${ZEPPELIN_IMAGE}

WORKDIR ${Z_HOME}

USER root
ADD /shiro.ini ${Z_HOME}/conf/
#Required for local set up. Overriding so as to make imagePullPolicy as Never
ADD /100-interpreter-spec.yaml ${Z_HOME}/k8s/interpreter/

#Once ZEPPELIN-5192 is resolved, we can remove the below command.
ADD /credentials.json ${Z_HOME}/conf/

#Required for starting the Zeppelin server. Without this Shiro won't be able to set the env configuration.
ADD https://repo1.maven.org/maven2/org/postgresql/postgresql/42.2.5/postgresql-42.2.5.jar  ${Z_HOME}/lib
ENV CLASSPATH=${Z_HOME}/lib/postgresql-42.2.5.jar:${CLASSPATH}
RUN chmod 775 ${Z_HOME}/lib/postgresql-42.2.5.jar

USER 1000

ENTRYPOINT [ "/usr/bin/tini", "--" ]
WORKDIR ${Z_HOME}
CMD ["bin/zeppelin.sh"]
