FROM node:10

LABEL maintainer "hakoai <hakoai64@gmail.com>"
ENV PURESCRIPT_DOWNLOAD_SHA1 f0c9fae808ae27973de7c77519f87ae6e4837312

RUN yarn global add bower pulp@12.3.1

RUN cd /opt \
    && wget https://github.com/purescript/purescript/releases/download/v0.12.3/linux64.tar.gz \
    && echo "$PURESCRIPT_DOWNLOAD_SHA1 linux64.tar.gz" | sha1sum -c - \
    && tar -xvf linux64.tar.gz \
    && rm /opt/linux64.tar.gz

ENV PATH /opt/purescript:$PATH

RUN userdel node
RUN useradd -m -s /bin/bash pureuser

WORKDIR /home/pureuser

USER pureuser

RUN mkdir tmp && cd tmp && pulp init

CMD cd tmp && pulp psci