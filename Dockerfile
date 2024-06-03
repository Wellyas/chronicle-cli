FROM python:3.11-alpine3.19
LABEL version="0.0.1"


ENV CODE_WORKDIR="/opt/app"
WORKDIR $CODE_WORKDIR
COPY requirements_dev.txt .
RUN \
    apk update && apk add --no-cache \
    ca-certificates \
    git && \
    apk update && apk add --no-cache --virtual .build-deps openssl-dev musl-dev libffi-dev libxslt-dev libxml2-dev gcc python3-dev g++ openssl-dev cargo pkgconfig cmake make ninja-build && \
    rm -rf /var/cache/apk/* && \
    update-ca-certificates && \
    if [ ! -d "$CODE_WORKDIR" ] ; then mkdir $CODE_WORKDIR ; fi && \
    pip install --upgrade pip && pip install --no-cache-dir -r requirements_dev.txt && \
    apk del .build-deps
