FROM ubuntu:latest
RUN echo 'Acquire { http::User-Agent "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36"; };' >> /etc/apt/apt.conf
RUN apt update && apt install -y curl

RUN mkdir -p /opt/ibm
RUN curl -o /opt/ibm/12.0-ACE-LINUXX64-12.0.6.0.tar.gz https://mirror.pvcb.vn/repository/raw-ibm-hosted/app-connect-enterprise/12.0.6.0-ACE-LINUX64-DEVELOPER.tar.gz
RUN tar -xzvf /opt/ibm/12.0-ACE-LINUXX64-12.0.6.0.tar.gz -C /opt/ibm

RUN /opt/ibm/ace-12.0.6.0/ace make registry global accept license silently
COPY ./DemoLog4j /opt/DemoLog4j

SHELL ["/bin/bash", "-c"]
RUN LICENSE=accept source /opt/ibm/ace-12.0.6.0/server/bin/mqsiprofile \
    && ibmint package --input-path /opt/DemoLog4j --output-bar-file /opt/test.bar --compile-maps-and-schemas \
    && mqsicreateworkdir /opt/TEST_SERVER \
    && ibmint deploy --input-bar-file /opt/test.bar --output-work-directory /opt/TEST_SERVER
COPY ./server.conf.yaml /opt/TEST_SERVER/server.conf.yaml
EXPOSE 7800
CMD /bin/bash -c "LICENSE=accept source /opt/ibm/ace-12.0.6.0/server/bin/mqsiprofile && IntegrationServer --work-dir /opt/TEST_SERVER"
