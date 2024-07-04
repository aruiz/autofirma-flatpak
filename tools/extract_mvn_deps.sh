#!/usr/bin/env bash
set -e

AUTOFIRMA_MANIFEST_ID="com.github.aruiz.Autofirma"
AUTOFIRMA_MANIFEST_FILE="${AUTOFIRMA_MANIFEST_ID}.yaml"
AUTOFIRMA_DEV_MANIFEST_FILE="${AUTOFIRMA_MANIFEST_ID}-dev.yaml"

AUTOFIRMA_FLATPAK_BUILD_DIR="build/dev_autofirma"
AUTOFIRMA_FLATPAK_STATE_DIR="build/.flatpak-builder-dev-autofirma"

# Create required directories
mkdir -p $AUTOFIRMA_FLATPAK_BUILD_DIR $AUTOFIRMA_FLATPAK_STATE_DIR

# Create a copy of the manifest file
cp $AUTOFIRMA_MANIFEST_FILE $AUTOFIRMA_DEV_MANIFEST_FILE

# Remove the maven-dependencies from the copied manifest
sed -e "s:^.*maven-dependencies.yaml.*$::g" -i $AUTOFIRMA_DEV_MANIFEST_FILE

# Allow to flatpak to use the network
awk -i inplace '{
    if (/    build-options:/) {
        print
        print "      build-args:"
        print "        - --share=network"
    } else {
        print
    }
}' $AUTOFIRMA_DEV_MANIFEST_FILE

# Build the flatpak for the dev-autofirma's manifest
flatpak-builder --user --build-only --force-clean --keep-build-dirs --disable-cache \
                --state-dir $AUTOFIRMA_FLATPAK_STATE_DIR                            \
                --install-deps-from=flathub                                         \
                $AUTOFIRMA_FLATPAK_BUILD_DIR                                        \
                $AUTOFIRMA_DEV_MANIFEST_FILE

# Extract the maven dependencies and create the maven-dependencies.yaml
MAVEN_REPO="$AUTOFIRMA_FLATPAK_STATE_DIR/build/autofirma/.m2/repository"

find "$MAVEN_REPO" \( -iname '*.jar' -o -iname '*.pom' \) -printf '%P\n' | sort -V | \
      grep -v "es/gob/afirma/afirma-client/"                       | \
      grep -v "es/gob/afirma/afirma-core/"                         | \
      grep -v "es/gob/afirma/afirma-core-.*/"                      | \
      grep -v "es/gob/afirma/afirma-crypto-.*/"                    | \
      grep -v "es/gob/afirma/afirma-keystores-.*/"                 | \
      grep -v "es/gob/afirma/afirma-server-.*/"                    | \
      grep -v "es/gob/afirma/afirma-signature-.*/"                 | \
      grep -v "es/gob/afirma/afirma-ui-.*/"                        | \
      grep -v "es/gob/afirma/lib/afirma-lib-itext/"                | \
      grep -v "es/gob/afirma/lib/afirma-lib-itext-.*/"             | \
      grep -v "es/gob/afirma/lib/afirma-lib-jmimemagic/0.0.8/"     | \
      grep -v "es/gob/afirma/lib/afirma-lib-juniversalchardet/"    | \
      grep -v "es/gob/afirma/lib/afirma-lib-oro/0.0.8/"            | \
      grep -v "es/gob/afirma/lib/support-libraries/1.0.6/"         | \
      xargs -rI '{}' bash -c "echo -e \"- type: file\n  dest: .m2/repository/\$(dirname {})\n  url: https://repo.maven.apache.org/maven2/{}\n  sha256: \$(sha256sum \"$MAVEN_REPO/{}\" | cut -c 1-64)\"" \
      > maven-dependencies.yaml

rm -fr $AUTOFIRMA_FLATPAK_BUILD_DIR
rm -fr $AUTOFIRMA_FLATPAK_STATE_DIR
rm $AUTOFIRMA_DEV_MANIFEST_FILE