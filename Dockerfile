FROM linuxserver/baseimage:latest
MAINTAINER Patrick Oberdorf "patrick@oberdorf.net"

# Set the locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN apt-get update && apt-get install -y python \
        python-pycurl \
        python-crypto \
        tesseract-ocr \
        python-beaker \
        python-imaging \
        unrar \
        gocr \
        python-django \
        python-pyxmpp \
        git \
        rhino \
        wget \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN git clone https://github.com/pyload/pyload.git /opt/pyload \
	&& cd /opt/pyload \
	&& git checkout v0.4.9 \
	&& echo "/opt/pyload/pyload-config" > /opt/pyload/module/config/configdir \
	&& mv /opt/pyload/module/Utils.py /opt/pyload/module/utils.py \
	&& rm module/plugins/hooks/UpdateManager.py \
	&& wget https://gist.github.com/GammaC0de/a77279b6588c11aed9c9/raw/e67c25e144991612519940a67d8417ea43069a66/UpdateManager.py -O module/plugins/hooks/UpdateManager.py

COPY pyload-config/ /tmp/pyload-config
COPY init/ /etc/my_init.d/
COPY services/ /etc/service/
RUN chmod -v +x /etc/service/*/run /etc/my_init.d/*.sh

EXPOSE 8000
VOLUME /opt/pyload/pyload-config
VOLUME /opt/pyload/Downloads
