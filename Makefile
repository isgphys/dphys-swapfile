# http://www.phys.ethz.ch/~franklin/Projects/dphys-swapfile/Makefile
# author/generator dphys2 makesrcpackage script - expanded by Neil Franklin,
#   last modification/generation 2006.09.15
# This Makefile is copyright ETH Zuerich Physics Departement
#   use under either modified/non-advertising BSD or GPL license

# --- various site dependant user config variables

# for creating an <program>[-<version>].tar.gz archive
DIR = dphys-swapfile


# --- no user configurable stuff below here

PREFIX  = $(DESTDIR)/usr
BINDIR  = $(PREFIX)/bin
SBINDIR = $(PREFIX)/sbin
MAN1DIR = $(PREFIX)/share/man/man1
MAN8DIR = $(PREFIX)/share/man/man8
DOCDIR  = $(PREFIX)/share/doc/dphys-swapfile
EXADIR  = $(DOCDIR)/examples

# use R_PREFIX (root prefix) as not in /usr, this is early run start up stuff
R_PREFIX  = $(DESTDIR)
R_SBINDIR = $(R_PREFIX)/sbin


# --- code for acting out the various  make  targets

all:
	@/bin/gzip -9 -c dphys-swapfile.8 > dphys-swapfile.8.gz

clean:
	@/bin/rm -f dphys-swapfile.8.gz

distclean: clean

install:
	@/bin/mkdir -p $(R_SBINDIR)
	@/bin/cp -p dphys-swapfile       $(R_SBINDIR)

	@/bin/mkdir -p $(MAN8DIR)
	@/bin/cp -p dphys-swapfile.8.gz  $(MAN8DIR)

	@/bin/mkdir -p $(EXADIR)
	@/bin/cp -p dphys-swapfile.example  $(EXADIR)
	@/bin/cp -p init.d.example          $(EXADIR)

uninstall:
	@/bin/rm -f $(EXADIR)/init.d.example
	@/bin/rm -f $(EXADIR)/dphys-config.example
	@/bin/rmdir $(EXADIR)

	@/bin/rm -f $(MAN8DIR)/dphys-swapfile.8.gz

	@/bin/rm -f $(R_SBINDIR)/dphys-swapfile


# --- project management stuff

.PHONY: tar
tar:

	@# package this project into an .tar.gz for one nice download
	@/bin/echo packaging source and doc files into an .tar.gz ...
	@(cd ..; /bin/tar zcf $(DIR).tar.gz \
	  $(DIR)/FAQ $(DIR)/INSTALL $(DIR)/Logfile $(DIR)/Makefile \
	  $(DIR)/README $(DIR)/dphys-swapfile $(DIR)/dphys-swapfile.8 \
	  $(DIR)/dphys-swapfile.example $(DIR)/index.html.de \
	  $(DIR)/index.html.en $(DIR)/init.d.example )
