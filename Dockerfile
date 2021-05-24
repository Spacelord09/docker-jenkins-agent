FROM jenkins/agent:latest-buster-jdk11
USER root
RUN apt-get update && apt-get install psmisc && rm -rf /var/lib/apt/lists/*
USER jenkins