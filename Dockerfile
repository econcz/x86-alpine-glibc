FROM i386/alpine:latest

ENV GLIB_VERSION=2.32-5.0
ENV GLIB_ARCH=i686

ADD ./ld.so.conf ./tmp/ld.so.conf

RUN apk add --update --no-cache wget tar zstd && \
    mkdir -p glibc-${GLIBC_VERSION} \
    /usr/glibc && \
    ln -s /bin/bash /usr/bin/bash && \
    wget http://pool.mirror.archlinux32.org/${GLIB_ARCH}/core/glibc-${GLIB_VERSION}-${GLIB_ARCH}.pkg.tar.zst -O glibc-${GLIB_VERSION}-${GLIB_ARCH}.pkg.tar.zst && \
    unzstd glibc-${GLIB_VERSION}-${GLIB_ARCH}.pkg.tar.zst && \
    tar xf glibc-${GLIB_VERSION}-${GLIB_ARCH}.pkg.tar -C glibc-${GLIBC_VERSION} && \
    mv tmp/ld.so.conf /etc/ld.so.conf && \
    cp -a glibc-${GLIBC_VERSION}/usr /usr/glibc/ && \
    glibc-${GLIBC_VERSION}/usr/bin/ldconfig /usr/glibc/usr /usr/glibc/usr/lib && \
    ln -s /usr/glibc/usr/lib/ld-linux.so.2 /lib/ld-linux.so.2  && \
    rm -Rf glibc-${GLIBC_VERSION} glibc-${GLIB_VERSION}-${GLIB_ARCH}.pkg.* && \
    apk del wget tar zstd
