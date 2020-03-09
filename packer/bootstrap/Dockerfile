FROM jenkins/jenkins:lts
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"
COPY plugins.txt /var/jenkins_home/
COPY security.groovy /usr/share/jenkins/ref/init.groovy.d/security.groovy
WORKDIR /var/jenkins_home/
RUN /usr/local/bin/install-plugins.sh < /var/jenkins_home/plugins.txt
COPY --chown=jenkins:jenkins jobs /var/jenkins_home/jobs
