FROM 10.64.27.125:5000/goldmann/eap

ADD ./standalone.xml /opt/jboss-eap-6.2/standalone/configuration/standalone.xml
ADD ./ag-push.war //opt/jboss-eap-6.2/standalone/deployments/ag-push.war
RUN mkdir -p /opt/jboss-eap-6.2/modules/org/jboss/aerogear/simplepush/main
ADD ./simplepush_module /opt/jboss-eap-6.2/modules/org/jboss/aerogear/simplepush/main/
RUN mkdir /aerogear-markers

# Expose the simple push subsystem and notify ports
EXPOSE 8676
EXPOSE 8443

CMD ["/eap/bin/launch", "standalone", "-c", "standlone.xml", "-b", "0.0.0.0"]