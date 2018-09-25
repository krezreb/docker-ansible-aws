FROM alpine:edge

RUN apk -v --update add \
      gcc git make libffi-dev musl-dev openssl-dev perl py-pip python python-dev sshpass bash && \
      pip install --upgrade awscli s3cmd python-magic ansible && \
      apk -v --purge del py-pip && \
      rm /var/cache/apk/*
