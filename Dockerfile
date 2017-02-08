FROM puppet/puppetdb
COPY puppetdb /etc/default/
RUN rm -fr /Dockerfile 