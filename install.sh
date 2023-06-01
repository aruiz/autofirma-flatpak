#!/bin/sh
set -e
shopt -s failglob

mkdir deb-package
ar p AutoFirma_1_*.deb data.tar.zst | tar xvf - --zstd -C deb-package
sed -i "s/ \/usr\// \/app\/usr\//" deb-package/usr/bin/autofirma
install -Dm755 deb-package/usr/bin/autofirma /app/usr/bin/autofirma
install -Dm644 deb-package/usr/lib/AutoFirma/AutoFirma.jar /app/usr/lib/AutoFirma/AutoFirma.jar
install -Dm644 deb-package/usr/lib/AutoFirma/AutoFirma.png /app/usr/lib/AutoFirma/AutoFirma.png
install -Dm644 deb-package/usr/lib/AutoFirma/AutoFirmaConfigurador.jar /app/usr/lib/AutoFirma/AutoFirmaConfigurador.jar
