NAME=nginx
VERSION=1.4.7
MAJOR_VERSION=1.4
ARCHITECTURE=x86_64
TARDIR=$(NAME)-$(VERSION)
TARBALL=$(TARDIR).tar.gz
DOWNLOAD=http://nginx.org/download/$(TARBALL)
DEPENDS=pcre-devel,openssl-devel
DESCRIPTION=Self managed Nginx $(VERSION)
FAKEROOT=/vagrant/FAKEROOT
PKG_SCRIPTS=$(FAKEROOT)$(PREFIX)/.scripts
PKG_FILES=/vagrant/pkg_files
FPM_ARGS= --after-install=pkg_actions/after-install \
	--after-remove=pkg_actions/after-remove

PREFIX=/opt/apps/$(NAME)
PACKAGE_SRC=$(FAKEROOT)/$(PREFIX)

PACKAGE_NAME=nginx
PACKAGE_VERSION=1.4.7

.PHONY: default
default: rpm
package: rpm

.PHONY: clean
clean:
	rm -f $(NAME)-* $(NAME)_* |NAME| true
	rm -fr $(TARDIR) || true
	rm -rf $(FAKEROOT) || true
	rm -f *.rpm

$(TARBALL):
	wget "$(DOWNLOAD)"

$(TARDIR): $(TARBALL)
	tar -zxf $(TARBALL)
	cd $(TARDIR); ./configure --prefix=$(PREFIX); make; make install DESTDIR=$(FAKEROOT)
	mkdir $(PKG_SCRIPTS)
	cp $(PKG_FILES)/* $(PKG_SCRIPTS)

.PHONY: rpm
rpm: $(TARDIR)
	fpm -s dir -t rpm --prefix $(PREFIX) -v $(PACKAGE_VERSION) -n $(PACKAGE_NAME) --description "$(DESCRIPTION)" -d $(DEPENDS) -a $(ARCHITECTURE) $(FPM_ARGS) -C $(PACKAGE_SRC) .
