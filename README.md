# x86-alpine-glibc

A glibc 32-bit docker image for Alpine Linux built for https://ish.app (:ish-glibc-3.12 etc., the original iSH App image is :ish-import). This time the Alpine itself is also 32 bit!

Initial code by: https://github.com/vimalathithen/alpine-glibc-x86 URLs fixed, Alpine version upgraded, glibc version upgraded

Alpine Linux has musl libc and if you have requirements to run software that depend on the 32 bit glibc (GNU c) version such as Oracle JDK 32 bit, this image can be used. The x86 glibc binary is used to build the image.
