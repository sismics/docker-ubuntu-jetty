#
# Dockerfile for Ubuntu + Jetty Web Server
#

FROM sismics/ubuntu-java:11.0.18
MAINTAINER Jean-Marc Tremeaux <jm.tremeaux@sismics.com>

# Download and install Jetty
ENV JETTY_VERSION 11.0.14
RUN wget -nv -O /tmp/jetty.tar.gz \
    "https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-home/${JETTY_VERSION}/jetty-home-${JETTY_VERSION}.tar.gz" \
    && tar xzf /tmp/jetty.tar.gz -C /opt \
    && mv /opt/jetty* /opt/jetty \
    && useradd jetty -U -s /bin/false \
    && chown -R jetty:jetty /opt/jetty \
    && mkdir /opt/jetty/webapps
WORKDIR /opt/jetty
RUN chmod +x bin/jetty.sh

# Init configuration
COPY opt /opt
EXPOSE 8080
ENV JETTY_HOME /opt/jetty
ENV JAVA_OPTIONS -Xmx512m

# Set the default command to run when starting the container
CMD ["bin/jetty.sh", "run"]
