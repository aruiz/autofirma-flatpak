MANIFEST_ID = com.github.aruiz.Autofirma

all: build

build:
	mkdir -p builddir/autofirma
	flatpak remote-add --if-not-exists --user flathub https://dl.flathub.org/repo/flathub.flatpakrepo
	flatpak-builder --user --force-clean --install-deps-from=flathub --repo=local-repo builddir/autofirma $(MANIFEST_ID).yaml

install:
	flatpak remote-add --if-not-exists --user --no-gpg-verify autofirma-local `pwd`/local-repo
	flatpak install --user --reinstall --noninteractive autofirma-local $(MANIFEST_ID)

uninstall:
	flatpak list --user | grep $(MANIFEST_ID) \
	  && flatpak uninstall --user --noninteractive $(MANIFEST_ID) \
	  || true

run:
	flatpak run --user $(MANIFEST_ID)

run_shell:
	flatpak run --command=sh --devel $(MANIFEST_ID)

update_mvn_deps:
	tools/extract_mvn_deps.sh

clean:
	rm -fr build/
	rm -fr local-repo/
	rm -fr .flatpak-buikder/

mrproper: clean uninstall
	flatpak remote-list --user | grep autofirma-local \
	  && flatpak remote-delete --user --force autofirma-local \
	  || true

.PHONY: build update_mvn_deps clean mrproper