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

USER jenkins

COPY settings.xml.tmpl /home/jenkins/settings.xml.tmpl

ENV GIT_USER_EMAIL "sergief@users.noreply.github.com"
ENV GIT_USER_NAME "Jenkins"

ENV NEXUS_USERNAME "\${env.M2_CREDENTIALS_USR}"
ENV NEXUS_PASSWORD "\${env.M2_CREDENTIALS_PSW}"
ENV NEXUS_MAVEN_PUBLIC_URL "\${env.M2_MIRROR_CENTRAL}"

RUN git config --global user.email "${GIT_USER_EMAIL}" && \
  git config --global user.name "${GIT_USER_NAME}" && \
  mkdir -p /home/jenkins/.m2 && \
  envsubst < /home/jenkins/settings.xml.tmpl > /home/jenkins/.m2/settings.xml && \
  rm /home/jenkins/settings.xml.tmpl
