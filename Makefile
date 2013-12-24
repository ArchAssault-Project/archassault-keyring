V=20131027

PREFIX = /usr/local

install:
	install -dm755 $(DESTDIR)$(PREFIX)/share/pacman/keyrings/
	install -m0644 archassault{.gpg,-trusted,-revoked} $(DESTDIR)$(PREFIX)/share/pacman/keyrings/

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/share/pacman/keyrings/archassault{.gpg,-trusted,-revoked}
	rmdir -p --ignore-fail-on-non-empty $(DESTDIR)$(PREFIX)/share/pacman/keyrings/

dist:
	git archive --format=tar --prefix=archassault-keyring-$(V)/ $(V) | gzip -9 > archassault-keyring-$(V).tar.gz
	gpg --detach-sign --use-agent archassault-keyring-$(V).tar.gz

upload:
	scp archassault-keyring-$(V).tar.gz archassault-keyring-$(V).tar.gz.sig archassault.org:/srv/http/SOMETHING/archlinux-keyring/

.PHONY: install uninstall dist upload
