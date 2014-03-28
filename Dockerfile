FROM 10.64.27.125:5000/goldmann/eap

USER root

ADD ./ag-push.war /opt/jboss-eap-6.2/standalone/deployments/ag-push.war
RUN mkdir -p /opt/jboss-eap-6.2/modules/org/jboss/aerogear/simplepush/main
RUN mkdir /aerogear
ADD ./simplepush_module /opt/jboss-eap-6.2/modules/org/jboss/aerogear/simplepush/main/

ADD ./launch-aerogear /opt/jboss-eap-6.2/bin/
ADD ./generate-push-token-key /aerogear/generate-push-token-key
RUN chmod +x /opt/jboss-eap-6.2/bin/launch-aerogear /aerogear/generate-push-token-key
ADD ./standalone-ha.xml /opt/jboss-eap-6.2/standalone/configuration/standalone-ha.xml

RUN chown -R jbosseap:jbosseap /opt/jboss-eap-6.2
RUN chown -R jbosseap:jbosseap /aerogear
# Expose the simple push subsystem and notify ports
EXPOSE 8676
EXPOSE 8443

USER jbosseap

CMD ["/eap/bin/launch-aerogear"]
