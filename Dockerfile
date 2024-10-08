#Start with a base image containing Java runtime
FROM openjdk:17-jdk-slim

# MAINTAINER instruction is deprecated in favor of using label
# MAINTAINER zoha.com
#Information around who maintains the image
LABEL "org.opencontainers.image.authors"="zoha.com"
WORKDIR /app

# Add the application's jar to the image
COPY target/configserver-0.0.1-SNAPSHOT.jar ./configserver-0.0.1-SNAPSHOT.jar


# execute the application
ENTRYPOINT ["java", "-jar", "configserver-0.0.1-SNAPSHOT.jar"]