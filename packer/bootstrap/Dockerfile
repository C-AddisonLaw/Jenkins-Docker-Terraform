FROM jenkins/jenkins:lts
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"
COPY plugins.txt /var/jenkins_home/
COPY jenkins.yaml /usr/share/jenkins/ref/
COPY security.groovy /usr/share/jenkins/ref/init.groovy.d/security.groovy
ENV CASC_JENKINS_CONFIG /var/jenkins_home/jenkins.yaml
WORKDIR /var/jenkins_home/
RUN /usr/local/bin/install-plugins.sh < /var/jenkins_home/plugins.txt
