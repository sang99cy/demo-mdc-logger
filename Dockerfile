# Use the official image as a parent image
FROM mirror.pvcb.vn/library/openjdk:17

# Set the working directory in the container
WORKDIR /app

# Copy the application JAR file to the container
COPY target/demo-mdc-logger-0.0.1-SNAPSHOT.jar /app/demo.jar
COPY hypertrace-agent-1.3.13-all.jar /opt/hypertrace-agent/hypertrace-agent.jar
# Make port 8080 available to the world outside this container
EXPOSE 8080

# Run the JAR file with the Hypertrace agent
ENTRYPOINT ["java", "-javaagent:/opt/hypertrace-agent/hypertrace-agent.jar", "-jar", "/app/demo.jar"]

#ENTRYPOINT ["java", "-jar", "/app/demo.jar"]
