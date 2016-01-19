FROM java:8
ENV PROJECT_NAME finch-nginx-dev-service
ENV PROJECT_VERSION 1.0-SNAPSHOT
ENV JAR_NAME ${PROJECT_NAME}-${PROJECT_VERSION}.jar

ADD ./target/${JAR_NAME} /root
WORKDIR /root
ENTRYPOINT java -jar ${JAR_NAME} --spring.cloud.consul.discovery.hostname=`awk 'NR==1 {print $1}' /etc/hosts` --spring.datasource.url=jdbc:postgresql://${POSTGRES_PORT_5432_TCP_ADDR}:${POSTGRES_PORT_5432_TCP_PORT}/userservice --spring.cloud.consul.host="${CONSUL_PORT_8500_TCP_ADDR}" --spring.cloud.consul.port="${CONSUL_PORT_8500_TCP_PORT}"