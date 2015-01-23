FROM progrium/busybox

ENV NODE_VERSION 0.10.35

RUN \
  opkg-install curl bash git libstdcpp && \
  rm -f /lib/libpthread.so.0 && \
  ln -s /lib/libpthread-2.18.so /lib/libpthread.so.0 && \
  curl -s http://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz | gunzip | tar -xf - -C /

ENV PATH /node-v$NODE_VERSION-linux-x64/bin:$PATH

COPY . /src
RUN cd /src; npm install


ENV PORT 8000

EXPOSE  8080
CMD ["node", "/src/index.js"]
