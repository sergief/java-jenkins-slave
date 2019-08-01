FROM jenkinsci/jnlp-slave:latest

LABEL description="Jenkins Slave image with JDK8, Maven and M2 Settings to connect to nexus" \
  maintainer="sergief@users.noreply.github.com"

USER root
RUN apt-get update && \
  apt-get install -y \
    openjdk-8-jdk \
    maven \
    git \
    gettext-base

COPY settings.xml.tmpl /home/jenkins/settings.xml.tmpl

ENV NEXUS_USERNAME "\${env.M2_CREDENTIALS_USR}"
ENV NEXUS_PASSWORD "\${env.M2_CREDENTIALS_PSW}"
ENV NEXUS_MAVEN_PUBLIC_URL "\${env.M2_MIRROR_CENTRAL}"

RUN envsubst < /home/jenkins/settings.xml.tmpl > /etc/maven/settings.xml && \
  rm /home/jenkins/settings.xml.tmpl

USER jenkins
