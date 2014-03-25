FROM 10.64.27.125:5000/goldmann/eap

ADD ./ag-push.war /opt/jboss-eap-6.2/standalone/deployments/ag-push.war
RUN mkdir -p /opt/jboss-eap-6.2/modules/org/jboss/aerogear/simplepush/main && mkdir /aerogear
ADD ./simplepush_module /opt/jboss-eap-6.2/modules/org/jboss/aerogear/simplepush/main/

ADD ./launch-aerogear /opt/jboss-eap-6.2/bin/
ADD ./generate-push-token-key /aerogear/generate-push-token-key
RUN chmod +x /opt/jboss-eap-6.2/bin/launch-aerogear /aerogear/generate-push-token-key

# Expose the simple push subsystem and notify ports
EXPOSE 8676
EXPOSE 8443

ADD ./standalone-ha.xml /opt/jboss-eap-6.2/standalone/configuration/standalone-ha.xml

CMD ["/eap/bin/launch-aerogear"]
