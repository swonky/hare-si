
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

BASH_SOURCE = ./scripts/si.bash
ZSH_SOURCE = ./scripts/si.zsh
BASH_DIR ?=
ZSH_DIR ?=

TARGET = si

SOURCES = $(wildcard ./*.ha ./cmd/si/*.ha ./si/*.ha)
VERSION_FILE = ./si/version.ha
COMPLETIONS_HA = ./cmd/si/completions.ha

MAN_SOURCE = ./docs/si.1.scd
MAN_PAGE = ./docs/si.1
MAN_TEXT = ./docs/si.1.txt

SEM_VERSION = 0.0.1
GIT_VERSION = $(shell if command -v git >/dev/null 2>&1; then git describe --always --dirty 2>/dev/null || printf 'unknown'; else printf 'unknown'; fi)

# Optional documentation dependencies.
HAVE_SCDOC = $(shell command -v $(SCDOC) >/dev/null 2>&1 && echo yes)
HAVE_GROFF = $(shell command -v $(GROFF) >/dev/null 2>&1 && command -v $(COL) >/dev/null 2>&1 && echo yes)

DOC_TARGETS =

ifeq ($(HAVE_SCDOC),yes)
DOC_TARGETS += $(MAN_PAGE)

ifeq ($(HAVE_GROFF),yes)
DOC_TARGETS += $(MAN_TEXT)
endif
endif

all: build

build: $(COMPLETIONS_HA) $(TARGET) $(DOC_TARGETS)

# Generate embedded shell completions.
$(COMPLETIONS_HA): $(BASH_SOURCE) $(ZSH_SOURCE)
	@mkdir -p "$(@D)"
	@{ \
		printf 'def BASH_COMPLETIONS: str = `'; \
		cat "$(BASH_SOURCE)"; \
		printf '`;\n\ndef ZSH_COMPLETIONS: str = `'; \
		cat "$(ZSH_SOURCE)"; \
		printf '`;\n'; \
	} > "$@"

# Build executable.
$(TARGET): $(SOURCES) $(VERSION_FILE) $(COMPLETIONS_HA)
	@mkdir -p ./bin
	$(HARE) build $(HAREFLAGS) -o ./bin/$@ ./cmd/$@/

# Generate version information.
$(VERSION_FILE): FORCE
	@printf 'export const SEM_VERSION: str = "%s";\nexport const GIT_VERSION: str = "%s";\n' \
		"$(SEM_VERSION)" "$(GIT_VERSION)" > "$@.tmp"
	@if ! cmp -s "$@.tmp" "$@"; then \
		mv "$@.tmp" "$@"; \
	else \
		rm -f "$@.tmp"; \
	fi

# Generate man page.
$(MAN_PAGE): $(MAN_SOURCE)
	$(SCDOC) < "$(MAN_SOURCE)" > "$@"

# Generate plain-text man page.
$(MAN_TEXT): $(MAN_PAGE)
	$(GROFF) -man -Tutf8 -P-cbou "$(MAN_PAGE)" | $(COL) -b > "$@"

FORCE:

# Installation.
install: build install-bin install-lib install-docs install-completions

install-bin:
	install -Dm755 "./bin/$(TARGET)" "$(DESTDIR)$(BINDIR)/$(TARGET)"

install-lib:
	mkdir -p "$(MODULEDIR)"
	install -m644 ./si/*.ha "$(MODULEDIR)/"

install-docs:
	@if [ -f "$(MAN_PAGE)" ]; then \
		install -Dm644 "$(MAN_PAGE)" "$(DESTDIR)$(MANDIR)/man1/$(TARGET).1"; \
	else \
		echo "WARNING: man page unavailable; skipping installation"; \
	fi

install-completions:
	@if [ -n "$(BASH_DIR)" ] && [ -d "$(DESTDIR)$(BASH_DIR)" ]; then \
		install -m644 "$(BASH_SOURCE)" "$(DESTDIR)$(BASH_DIR)/$(TARGET).bash"; \
	elif [ -n "$(BASH_DIR)" ]; then \
		echo "WARNING: Bash completion directory not found; skipping"; \
	fi
	@if [ -n "$(ZSH_DIR)" ] && [ -d "$(DESTDIR)$(ZSH_DIR)" ]; then \
		install -m644 "$(ZSH_SOURCE)" "$(DESTDIR)$(ZSH_DIR)/_$(TARGET)"; \
	elif [ -n "$(ZSH_DIR)" ]; then \
		echo "WARNING: Zsh completion directory not found; skipping"; \
	fi

uninstall: uninstall-bin uninstall-lib uninstall-docs uninstall-completions

uninstall-bin:
	rm -f "$(DESTDIR)$(BINDIR)/$(TARGET)"

uninstall-lib:
	rm -rf "$(DESTDIR)$(THIRDPARTYDIR)/si"

uninstall-docs:
	rm -f "$(DESTDIR)$(MANDIR)/man1/$(TARGET).1"

uninstall-completions:
	@if [ -n "$(BASH_DIR)" ]; then \
		rm -f "$(DESTDIR)$(BASH_DIR)/$(TARGET).bash"; \
	fi
	@if [ -n "$(ZSH_DIR)" ]; then \
		rm -f "$(DESTDIR)$(ZSH_DIR)/_$(TARGET)"; \
	fi

clean:
	rm -f ./bin/$(TARGET) $(MAN_PAGE) $(MAN_TEXT) $(COMPLETIONS_HA)

.PHONY: all build install install-bin install-lib install-docs \
        install-completions uninstall uninstall-bin uninstall-lib \
        uninstall-docs uninstall-completions clean FORCE

