#!/usr/bin/make -f

# Set temporary HOME for lazarus primary config directory
export HOME=$(pwd)/tmphome

ROOT = $(pwd)/debian/django-react-setup

override_dh_auto_clean:
$(RM) -r lib
$(RM) lib *.res project-name

override_dh_auto_build:
lazbuild --build-mode=Release project-name.lpi

override_dh_auto_install:
install -d -m 755 $(ROOT)/usr/bin
install -s -m 755 project-executable $(ROOT)/usr/bin
install -d -m 755 $(ROOT)/usr/share/applications
install -m 644 project-name.desktop $(ROOT)/usr/share/applications
install -d -m 755 $(ROOT)/usr/share/pixmaps
install -m 644 project-name.png $(ROOT)/usr/share/pixmaps
install -d -m 755 $(ROOT)/usr/share/project-name/i18n
install -D -m 644 i18n/*.po $(ROOT)/usr/share/project-name/i18n

%:
dh $@
