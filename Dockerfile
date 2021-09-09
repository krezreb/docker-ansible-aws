FROM alpine:3

RUN apk -v --update add \
	gcc git make mariadb-client openssh-client libressl-dev libffi-dev musl-dev openssl-dev perl py3-pip python3 python3-dev sshpass bash && \
	rm /var/cache/apk/*

ARG AWSCLI_VERSION=1.20.38
ARG ANSIBLE_VERSION=4.5.0

RUN pip3 install wheel==0.37.0 
RUN pip3 install cryptography==2.9.2 ansible==$ANSIBLE_VERSION

# Install boto and boto3
RUN pip3 install boto3 boto botocore

# Install AWS CLI
RUN pip3 install awscli=="$AWSCLI_VERSION"

# Install AWS ELASTIC BEANSTALK CLI
RUN pip3 install awsebcli==3.19.3

RUN mkdir /root/.ssh 
COPY ssh_config /root/.ssh/config
RUN chmod -R 0400 /root/.ssh

# for docker in docker
VOLUME /var/lib/docker