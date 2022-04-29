FROM jenkins/jenkins:lts-jdk11

USER root
RUN apt-get update && apt-get install -y lsb-release software-properties-common jq && \
curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - && \
apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" && \
apt-get update && apt-get install -y vault terraform && chown jenkins /usr/bin/vault  && chown jenkins /usr/bin/terraform \
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip awscliv2.zip && \
./aws/install  && chown jenkins /usr/local/bin/aws

USER jenkins