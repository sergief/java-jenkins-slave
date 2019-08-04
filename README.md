# Docker Java Jenkins slave

This project contains a Jenkins Slave Docker image that has all the build tools needed for creating Java applications built using Maven and Git as source code repository. It also contains a settings.xml file prepared for deploying and retrieving artifacts to/from Nexus.

Tested using the [Jenkins Kubernetes Plugin](https://plugins.jenkins.io/kubernetes).

## How to use it
You can download the docker image from [Docker Hub](https://hub.docker.com/r/sergief/java-jenkins-slave) using the following command:
```bash
docker pull sergief/java-jenkins-slave:latest
```

The following environment variables need to be set in order to properly use Nexus:
* M2_MIRROR_CENTRAL: The URL for the mirrored maven central repository, like `http://nexus.test:8081/repository/maven-public`
* M2_CREDENTIALS_USR: The username used for authenticating to Nexus.
* M2_CREDENTIALS_PSW: The password used for authenticating to Nexus.

### Build your custom image

You can build your custom image and override the following `ENV` variables from the dockerfile:
* NEXUS_USERNAME
* NEXUS_PASSWORD
* NEXUS_MAVEN_PUBLIC_URL
