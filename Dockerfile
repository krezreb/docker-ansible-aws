FROM alpine:edge

RUN apk -v --update add \
	gcc git make openssh-client libffi-dev musl-dev openssl-dev perl py-pip python python-dev sshpass bash && \
	rm /var/cache/apk/*

ARG AWSCLI_VERSION=1.16.15
ARG ANSIBLE_VERSION=2.4.3.0

RUN pip install "ansible==$ANSIBLE_VERSION"


# Install boto and boto3
# boto is installed from maishsk:develop until https://github.com/boto/boto/pull/3794 is merged
RUN pip install boto3 && \
    cd /root && \
    git clone -b develop https://github.com/maishsk/boto.git && \
    cd boto && \
    python setup.py install && \
    cd .. && rm -rf boto


# Install AWS CLI
RUN pip install awscli=="$AWSCLI_VERSION" && \
    rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install AWS ELASTIC BEANSTALK CLI
RUN pip install awsebcli --upgrade




