FROM buildpack-deps:stretch as builder
MAINTAINER Xuejie Xiao <xxuejie@gmail.com>

RUN apt-get update && apt-get install -y git

RUN git clone https://github.com/maandree/libkeccak /root/libkeccak && cd /root/libkeccak && make && make install
RUN git clone https://github.com/maandree/sha3sum /root/sha3sum && cd /root/sha3sum && make

FROM debian:stretch
COPY --from=builder /root/libkeccak/libkeccak.so /usr/lib/libkeccak.so.1
COPY --from=builder /root/sha3sum/keccak-256sum /usr/local/bin/keccak-256sum
COPY --from=builder /root/sha3sum/keccak-256sum.1 /usr/local/share/man/man1/keccak-256sum.1
