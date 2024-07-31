# Use the official image as a parent image
FROM mirror.pvcb.vn/library/openjdk:17

# Set the working directory in the container
WORKDIR /app

# Copy the application JAR file to the container
COPY target/demo-mdc-logger-0.0.1-SNAPSHOT.jar /app/demo.jar
COPY hypertrace-agent-1.3.13-all.jar /opt/hypertrace-agent/hypertrace-agent.jar
# Make port 8080 available to the world outside this container
EXPOSE 8080

## Add required libararies
ADD https://github.com/grafana/pyroscope-java/releases/download/v0.12.2/pyroscope.jar ./pyroscope.jar
#ADD https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases/download/v1.17.0/opentelemetry-javaagent.jar opentelemetry-javaagent.jar
ADD https://repo1.maven.org/maven2/io/pyroscope/otel/0.10.1.11/otel-0.10.1.11.jar pyroscope-otel.jar

ENV PYROSCOPE_APPLICATION_NAME=my-spring-boot-app
ENV PYROSCOPE_FORMAT=jfr
ENV PYROSCOPE_PROFILING_INTERVAL=10ms
ENV PYROSCOPE_PROFILER_EVENT=itimer
ENV PYROSCOPE_PROFILER_LOCK=10ms
ENV PYROSCOPE_PROFILER_ALLOC=512k
ENV PYROSCOPE_UPLOAD_INTERVAL=15s
ENV OTEL_JAVAAGENT_EXTENSIONS=./pyroscope-otel.jar
ENV OTEL_PYROSCOPE_ADD_PROFILE_URL=false
ENV OTEL_PYROSCOPE_ADD_PROFILE_BASELINE_URL=false
ENV OTEL_PYROSCOPE_START_PROFILING=true
## Useful for debugging
# ENV PYROSCOPE_LOG_LEVEL=debug

## Those environment variables need to be overwritten at runtime, if you are using Grafana Cloud
ENV PYROSCOPE_SERVER_ADDRESS=http://pyroscope:4040
# ENV PYROSCOPE_BASIC_AUTH_USER=123     ## Grafana Cloud Username
# ENV PYROSCOPE_BASIC_AUTH_PASSWORD=glc_secret ## Grafana Cloud Password / API Token

# Run the JAR file with the Hypertrace agent
ENTRYPOINT ["java", "-javaagent:/opt/hypertrace-agent/hypertrace-agent.jar","-javaagent:pyroscope.jar", "-jar", "/app/demo.jar"]

#ENTRYPOINT ["java", "-jar", "/app/demo.jar"]
