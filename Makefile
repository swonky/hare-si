.POSIX:
.SUFFIXES:

HARE = hare
HAREFLAGS =
SCDOC = scdoc

DESTDIR =
PREFIX ?= /usr/local
BINDIR = $(PREFIX)/bin
MANDIR = $(PREFIX)/share/man

SRCDIR ?= $(PREFIX)/src

HARESRCDIR = $(SRCDIR)/hare
THIRDPARTYDIR = $(HARESRCDIR)/third-party

TARGET = si
SOURCES = $(wildcard *.ha)
VERSION_FILE = ./si/version.ha

MAN_SOURCE = ./docs/si.1.scd
MAN_PAGE = ./docs/si.1

SEM_VERSION = 0.0.1
GIT_VERSION = $(shell git describe --always --dirty 2>/dev/null || echo unknown)

all: build

build: $(TARGET) $(MAN_PAGE)

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

FORCE:

install: build
	install -Dm755 ./bin/$(TARGET) "$(DESTDIR)$(BINDIR)/$(TARGET)"
	$(MAKE) install-docs

install-docs: $(MAN_PAGE)
	install -Dm644 $(MAN_PAGE) "$(DESTDIR)$(MANDIR)/man1/$(TARGET).1"

uninstall:
	rm -f "$(DESTDIR)$(BINDIR)/$(TARGET)"
	$(MAKE) uninstall-docs

uninstall-docs:
	rm -f "$(DESTDIR)$(MANDIR)/man1/$(TARGET).1"

clean:
	rm -f ./bin/$(TARGET) $(MAN_PAGE)

.PHONY: all build install install-docs uninstall uninstall-docs clean FORCE
