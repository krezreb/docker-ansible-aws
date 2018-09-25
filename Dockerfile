FROM alpine:edge

RUN apk -v --update add \
	gcc git make libffi-dev musl-dev openssl-dev perl py-pip python python-dev sshpass bash && \
	rm /var/cache/apk/*

RUN pip install --upgrade awscli s3cmd python-magic ansible

### Working with AWS region **eu-west-3** (Paris)
# While this [PR](https://github.com/boto/boto/pull/3784) is not landed, boto won't work with AWS region **eu-west-3**.

RUN cd /root && \
        git clone https://github.com/maishsk/boto.git && \
        cd boto && \
        python setup.py install && \
	cd .. && rm -rf boto

