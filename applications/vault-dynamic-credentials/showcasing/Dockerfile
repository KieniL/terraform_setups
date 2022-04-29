FROM jenkins/jenkins:lts-jdk11

USER root
RUN apt-get update && apt-get install -y lsb-release software-properties-common jq && \
curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - && \
apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" && \
apt-get update && apt-get install -y vault && chown jenkins /usr/bin/vault 

USER jenkins