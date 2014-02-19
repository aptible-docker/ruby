FROM quay.io/aptible/ubuntu:12.10
MAINTAINER Frank Macreery <frank@macreery.com>

RUN apt-get -y install wget build-essential zlib1g-dev libssl-dev \
    libreadline6-dev libyaml-dev
RUN cd /tmp && \
    wget -q http://cache.ruby-lang.org/pub/ruby/ruby-2.0.0-p353.tar.gz && \
    tar xzf ruby-2.0.0-p353.tar.gz
RUN cd /tmp/ruby-2.0.0-p353 && ./configure --enable-shared --prefix=/usr && \
    make && make install

RUN gem install bundler

ADD test /tmp/test
RUN bats /tmp/test

ENTRYPOINT ["/usr/bin/ruby"]
CMD ["-h"]
