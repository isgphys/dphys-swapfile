# http://www.phys.ethz.ch/~franklin/Projects/dphys-swapfile/Makefile
# author/generator dphys2 makesrcpackage script - expanded by Neil Franklin,
#   last modification/generation 2004.06.04
# This Makefile is copyright ETH Zuerich Physics Departement,
#   use under either BSD or GPL license

# --- various site dependant user config variables

# for creating an <program>[-<version>].tar.gz archive
DIR = dphys-swapfile


# --- no user configurable stuff below here

# use RPREFIX as not in /usr, this is early start up stuff
RPREFIX = $(DESTDIR)
PREFIX  = $(RPREFIX)/usr
BINDIR  = $(RPREFIX)/bin
SBINDIR = $(RPREFIX)/sbin
MAN1DIR = $(PREFIX)/share/man/man1
MAN8DIR = $(PREFIX)/share/man/man8


# --- code for acting out the various  make  targets

all:
	@/bin/gzip -9 -c dphys-swapfile.8 > dphys-swapfile.8.gz

clean:
	@/bin/rm -f dphys-swapfile.8.gz

distclean: clean

install:
	@/bin/mkdir -p $(SBINDIR)
	@/bin/cp -p dphys-swapfile $(SBINDIR)
	@/bin/mkdir -p $(MAN8DIR)
	@/bin/cp -p dphys-swapfile.8.gz $(MAN8DIR)

uninstall:
	@/bin/rm -f $(SBINDIR)/dphys-swapfile
	@/bin/rm -f $(MAN8DIR)/dphys-swapfile.8.gz


# --- project management stuff

.PHONY: tar
tar:

	@# package this project into an .tar.gz for one nice download
	@/bin/echo packaging source and doc files into an .tar.gz ...
	@(cd ..; /bin/tar zcf $(DIR).tar.gz \
	  $(DIR)/FAQ $(DIR)/INSTALL $(DIR)/Logfile $(DIR)/Makefile \
	  $(DIR)/README $(DIR)/dphys-swapfile $(DIR)/dphys-swapfile.8 \
	  $(DIR)/index.html.de $(DIR)/index.html.en )
