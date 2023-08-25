FROM rockylinux:8

RUN dnf install -y stunnel openssl

ENV PRIVATE_KEY=/tmp/private.key
ENV PUBLIC_KEY=/tmp/public.key

RUN /usr/bin/openssl req -utf8 -newkey rsa:2048 -keyout ${PRIVATE_KEY} -nodes -x509 -days 3650 -out ${PUBLIC_KEY} -subj /C=XX/O=EXAMPLE/CN=stunnel.example.com
RUN cat ${PRIVATE_KEY} > /etc/pki/tls/certs/stunnel.pem
RUN echo "" >> /etc/pki/tls/certs/stunnel.pem
RUN cat ${PUBLIC_KEY} >> /etc/pki/tls/certs/stunnel.pem

RUN rm -f /tmp/openssl.*

WORKDIR /etc/stunnel

COPY stunnel.conf /etc/stunnel/

CMD ["stunnel"]