#!/bin/sh
set -e
shopt -s failglob

mkdir deb-package
ar p  libpkcs11-dnie_1.6.8_amd64.deb data.tar.xz | tar xvfJ - -C deb-package

install -Dm644 deb-package/usr/share/libpkcs11-dnie/launch_icon.gif         /app/usr/share/libpkcs11-dnie/launch_icon.gif
install -Dm644 deb-package/usr/share/libpkcs11-dnie/launch.css              /app/usr/share/libpkcs11-dnie/launch.css
install -Dm644 deb-package/usr/share/libpkcs11-dnie/launch.pl               /app/usr/share/libpkcs11-dnie/launch.pl
install -Dm644 deb-package/usr/share/libpkcs11-dnie/launch.html             /app/usr/share/libpkcs11-dnie/launch.html
install -Dm644 deb-package/usr/share/libpkcs11-dnie/launch_logo.gif         /app/usr/share/libpkcs11-dnie/launch_logo.gif
install -Dm644 "deb-package/usr/share/libpkcs11-dnie/AC RAIZ DNIE 2.crt"   "/app/usr/share/libpkcs11-dnie/AC RAIZ DNIE 2.crt"
install -Dm644 deb-package/usr/lib/libpkcs11-dnie-asn1skeletons.la          /app/usr/lib64/libpkcs11-dnie-asn1skeletons.la
install -Dm644 deb-package/usr/lib/libpkcs11-dnie-asn1.la                   /app/usr/lib64/libpkcs11-dnie-asn1.la
install -Dm644 deb-package/usr/lib/libpkcs11-dnie-cryptopp.so.0             /app/usr/lib64/libpkcs11-dnie-cryptopp.so.0
install -Dm644 deb-package/usr/lib/libpkcs11-dnie-asn1.so.0.0.0             /app/usr/lib64/libpkcs11-dnie-asn1.so.0.0.0
install -Dm644 deb-package/usr/lib/libpkcs11-dnie-asn1skeletons.so          /app/usr/lib64/libpkcs11-dnie-asn1skeletons.so
install -Dm644 deb-package/usr/lib/libpkcs11-dnie-cryptopp.so.0.0.0         /app/usr/lib64/libpkcs11-dnie-cryptopp.so.0.0.0
install -Dm644 deb-package/usr/lib/libpkcs11-dnie-cryptopp.so               /app/usr/lib64/libpkcs11-dnie-cryptopp.so
install -Dm644 deb-package/usr/lib/libpkcs11-dnie-cryptopp.la               /app/usr/lib64/libpkcs11-dnie-cryptopp.la
install -Dm644 deb-package/usr/lib/libpkcs11-dnie-asn1.so.0                 /app/usr/lib64/libpkcs11-dnie-asn1.so.0
install -Dm644 deb-package/usr/lib/libpkcs11-dnie.la                        /app/usr/lib64/libpkcs11-dnie.la
install -Dm644 deb-package/usr/lib/libpkcs11-dnie-asn1.so                   /app/usr/lib64/libpkcs11-dnie-asn1.so
install -Dm644 deb-package/usr/lib/libpkcs11-dnie-asn1skeletons.so.0        /app/usr/lib64/libpkcs11-dnie-asn1skeletons.so.0
install -Dm644 deb-package/usr/lib/libpkcs11-dnie.so                        /app/usr/lib64/libpkcs11-dnie.so
install -Dm644 deb-package/usr/lib/libpkcs11-dnie-asn1skeletons.so.0.0.0    /app/usr/lib64/libpkcs11-dnie-asn1skeletons.so.0.0.0
