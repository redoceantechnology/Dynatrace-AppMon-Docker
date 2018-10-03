FROM alpine:3.7

LABEL maintainer="Rafal Psciuk <rafal.psciuk@dynatrace.com>, Tomasz Wieremjewicz <tomasz.wieremjewicz@dynatrace.com>"

ENV MONGODB_DB /data/db/easyTravel

RUN apt-get update
RUN apk add --no-cache bash wget
RUN apk add --no-cache mongodb

RUN wget -O Dynatrace-OneAgent-Linux-1.149.188.sh "https://poc77785.live.dynatrace.com/api/v1/deployment/installer/agent/unix/default/latest?Api-Token=Yc1_EUiMR_esxjrpFkamR&arch=x86&flavor=default"
RUN wget https://ca.dynatrace.com/dt-root.cert.pem ; ( echo 'Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha-256"; boundary="--SIGNED-INSTALLER"'; echo ; echo ; echo '----SIGNED-INSTALLER' ; cat Dynatrace-OneAgent-Linux-1.149.188.sh ) | openssl cms -verify -CAfile dt-root.cert.pem > /dev/null

RUN /bin/sh Dynatrace-OneAgent-Linux-1.149.188.sh  APP_LOG_CONTENT_ACCESS=1 INFRA_ONLY=0

EXPOSE 27017 28017

# Deploy easyTravel database
RUN mkdir -p ${MONGODB_DB}

ADD build/easyTravel-mongodb-db.tar.gz ${MONGODB_DB}
RUN chown -R root:root ${MONGODB_DB}

CMD mongod --rest --httpinterface --smallfiles --dbpath ${MONGODB_DB}
