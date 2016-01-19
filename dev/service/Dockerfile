FROM java:8
ENV PROJECT_NAME finch-nginx-dev-service
ENV PROJECT_VERSION 1.0-SNAPSHOT
ENV JAR_NAME ${PROJECT_NAME}-${PROJECT_VERSION}.jar

COPY ./target/${JAR_NAME} /root
WORKDIR /root
RUN bash -c "touch /root/${JAR_NAME}"
ENTRYPOINT exec java -Djava.security.egd=file:/dev/./urandom -jar ${JAR_NAME:-target/finch-nginx-dev-service-1.0-SNAPSHOT.jar} --spring.cloud.consul.discovery.hostname=$(awk 'NR==1 {print $1}' /etc/hosts) --spring.cloud.consul.host="${CONSUL_PORT_8500_TCP_ADDR:-192.168.99.100}" --spring.cloud.consul.port="${CONSUL_PORT_8500_TCP_PORT:-8500}"