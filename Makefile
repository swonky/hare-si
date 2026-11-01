.POSIX:
.SUFFIXES:

HARE = hare
HAREFLAGS =
SCDOC = scdoc
GROFF = groff
COL = col

DESTDIR =
PREFIX ?= /usr/local
BINDIR = $(PREFIX)/bin
MANDIR = $(PREFIX)/share/man

SRCDIR ?= $(PREFIX)/src

HARESRCDIR = $(SRCDIR)/hare
THIRDPARTYDIR = $(HARESRCDIR)/third-party
MODULEDIR = $(DESTDIR)$(THIRDPARTYDIR)/si

TARGET = si
SOURCES = $(wildcard *.ha)
VERSION_FILE = ./si/version.ha

MAN_SOURCE = ./docs/si.1.scd
MAN_PAGE = ./docs/si.1
MAN_TEXT = ./docs/si.1.txt

SEM_VERSION = 0.0.1
GIT_VERSION = $(shell git describe --always --dirty 2>/dev/null || echo unknown)

all: build

build: $(TARGET) $(MAN_PAGE) $(MAN_TEXT)

$(TARGET): $(SOURCES) $(VERSION_FILE)
	@mkdir -p ./bin
	$(HARE) build $(HAREFLAGS) -o bin/$@ cmd/$@/

$(VERSION_FILE): FORCE
	@printf 'export const sem_version: str = "%s";\nexport const git_version: str = "%s";\n' "$(SEM_VERSION)" "$(GIT_VERSION)" > $@

$(MAN_PAGE): $(MAN_SOURCE)
	@if command -v $(SCDOC) >/dev/null 2>&1; then \
		$(SCDOC) < $(MAN_SOURCE) > $@; \
	else \
		echo "WARNING: scdoc not found; skipping man page generation"; \
	fi

$(MAN_TEXT): $(MAN_PAGE)
	@if command -v $(GROFF) >/dev/null 2>&1 && command -v $(COL) >/dev/null 2>&1; then \
		$(GROFF) -man -Tutf8 -P-cbou $(MAN_PAGE) | $(COL) -b > $@; \
	else \
		echo "WARNING: groff or col not found; skipping MAN_TEXT generation"; \
	fi

FORCE:

install: build
	$(MAKE) install-bin
	$(MAKE) install-lib
	$(MAKE) install-docs

install-bin:
	install -Dm755 ./bin/$(TARGET) "$(DESTDIR)$(BINDIR)/$(TARGET)"

install-lib:
	mkdir -p $(MODULEDIR)
	install -Dm644 ./si/* $(MODULEDIR)

install-docs: $(MAN_PAGE)
	install -Dm644 $(MAN_PAGE) "$(DESTDIR)$(MANDIR)/man1/$(TARGET).1"

uninstall:
	$(MAKE) uninstall-bin
	$(MAKE) uninstall-lib
	$(MAKE) uninstall-docs

uninstall-bin:
	rm -f "$(DESTDIR)$(BINDIR)/$(TARGET)"

uninstall-lib:
	rm -rf $(DESTDIR)$(THIRDPARTYDIR)/si

uninstall-docs:
	rm -f "$(DESTDIR)$(MANDIR)/man1/$(TARGET).1"

clean:
	rm -f ./bin/$(TARGET) $(MAN_PAGE) $(MAN_TEXT)

.PHONY: all build install install-docs uninstall uninstall-docs clean FORCE
