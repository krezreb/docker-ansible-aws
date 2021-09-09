FROM alpine:3

RUN apk -v --update add \
	gcc git make openssh-client libressl-dev libffi-dev musl-dev openssl-dev perl py3-pip python3 python3-dev sshpass bash && \
	rm /var/cache/apk/*

ARG AWSCLI_VERSION=1.20.38
ARG ANSIBLE_VERSION=2.4.3.0

RUN pip3 install "cryptography==2.9.2"
RUN pip3 install "ansible==$ANSIBLE_VERSION"

# Install boto and boto3
# boto is installed from maishsk:develop until https://github.com/boto/boto/pull/3794 is merged
RUN pip3 install boto3 && \
    cd /root && \
    git clone -b develop https://github.com/maishsk/boto.git && \
    cd boto && \
    python3 setup.py install && \
    cd .. && rm -rf boto


# Install AWS CLI
RUN pip3 install awscli=="$AWSCLI_VERSION" && \
    rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install AWS ELASTIC BEANSTALK CLI
RUN pip3 install awsebcli==3.19.3

# Install mysqldump
RUN apk -v --update add mariadb-client

RUN mkdir /root/.ssh 
COPY ssh_config /root/.ssh/config
RUN chmod -R 0400 /root/.ssh

