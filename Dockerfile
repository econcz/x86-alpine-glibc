FROM econcz/x86-alpine-glibc:ish-import

ENV ALPINE_VERSION=3.14
ENV GLIB_VERSION=2.41+r47+g046b33800c3e-1.0
ENV GLIB_ARCH=i686

# Prepare own ld.so.conf
ADD ./ld.so.conf ./tmp/ld.so.conf

# Fix depedenciees
RUN cp /etc/apk/repositories /tmp/repositories
RUN echo "https://dl-cdn.alpinelinux.org/alpine/v${ALPINE_VERSION}/main/"      >  /etc/apk/repositories
RUN echo "https://dl-cdn.alpinelinux.org/alpine/v${ALPINE_VERSION}/community/" >> /etc/apk/repositories
RUN apk update
RUN apk add --update --no-cache tzdata gd

RUN apk add --update --no-cache wget tar zstd && \
    mkdir -p glibc-${GLIBC_VERSION} \
    /usr/glibc && \
    ln -s /bin/bash /usr/bin/bash && \
    wget https://mirror.yandex.ru/archlinux32/${GLIB_ARCH}/core/glibc-${GLIB_VERSION}-${GLIB_ARCH}.pkg.tar.zst -O glibc-${GLIB_VERSION}-${GLIB_ARCH}.pkg.tar.zst && \
    unzstd glibc-${GLIB_VERSION}-${GLIB_ARCH}.pkg.tar.zst && \
    tar xf glibc-${GLIB_VERSION}-${GLIB_ARCH}.pkg.tar -C glibc-${GLIBC_VERSION} && \
    mv tmp/ld.so.conf /etc/ld.so.conf && \
    cp -a glibc-${GLIBC_VERSION}/usr /usr/glibc/ && \
    glibc-${GLIBC_VERSION}/usr/bin/ldconfig /usr/glibc/usr /usr/glibc/usr/lib && \
    ln -s /usr/glibc/usr/lib/ld-linux.so.2 /lib/ld-linux.so.2  && \
    rm -Rf glibc-${GLIBC_VERSION} glibc-${GLIB_VERSION}-${GLIB_ARCH}.pkg.* && \
    apk del wget tar zstd

RUN cp /tmp/repositories /etc/apk/repositories
RUN rm -rf /tmp/*
