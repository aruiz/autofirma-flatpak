#!/bin/sh
set -e
shopt -s failglob

mkdir deb-package
ar p  AutoFirma_1*.deb data.tar.gz | tar zxvf - -C deb-package
sed -i "s/ \/usr\// \/app\/usr\//" deb-package/usr/bin/autofirma

install -Dm755 deb-package/usr/bin/autofirma                                /app/usr/bin/autofirma
install -Dm644 deb-package/usr/lib/AutoFirma/AutoFirma.jar                  /app/usr/lib/AutoFirma/AutoFirma.jar
install -Dm644 deb-package/usr/lib/AutoFirma/AutoFirma.png                  /app/usr/lib/AutoFirma/AutoFirma.png
install -Dm644 deb-package/usr/lib/AutoFirma/AutoFirmaConfigurador.jar      /app/usr/lib/AutoFirma/AutoFirmaConfigurador.jar

mkdir -p /app/share/icons/hicolor/scalable/
install -Dm644 AutoFirma.svg                                                /app/share/icons/hicolor/scalable/com.github.aruiz.Autofirma.svg

mkdir -p /app/share/applications/
install -Dm644 com.github.aruiz.Autofirma.desktop                           /app/share/applications/com.github.aruiz.Autofirma.desktop
