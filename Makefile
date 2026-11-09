.SUFFIXES:

HARE = hare
HAREFLAGS =
PANDOC = pandoc
HAREDOC = haredoc
PYTHON = python3

DESTDIR =
PREFIX ?= /usr/local
BINDIR = $(PREFIX)/bin
MANDIR = $(PREFIX)/share/man

SRCDIR ?= $(PREFIX)/src
HARESRCDIR = $(SRCDIR)/hare
THIRDPARTYDIR = $(HARESRCDIR)/third-party
MODULEDIR = $(DESTDIR)$(THIRDPARTYDIR)/si

BASH_DIR ?=
ZSH_DIR ?=

TARGET = si

SOURCES = $(wildcard ./*.ha ./cmd/si/*.ha ./si/*.ha)
VERSION_FILE = ./cmd/si/version.ha

MAN_SOURCE = ./docs/manpage.md
MAN_PAGE = ./docs/si.1
MAN_TEXT = ./docs/si.1.txt

HAREDOC_PAGE = ./docs/module.md

SEM_VERSION = 0.1.0
GIT_VERSION = $(shell if command -v git >/dev/null 2>&1; then git describe --always --dirty 2>/dev/null || printf 'unknown'; else printf 'unknown'; fi)

# Optional documentation dependencies.
HAVE_HAREDOC = $(shell command -v $(HAREDOC) >/dev/null 2>&1 && echo yes)
HAVE_PANDOC = $(shell command -v $(PANDOC) >/dev/null 2>&1 && echo yes)

DOC_TARGETS =

ifeq ($(HAVE_HAREDOC),yes)
DOC_TARGETS += $(HAREDOC_PAGE)
endif

ifeq ($(HAVE_PANDOC),yes)
DOC_TARGETS += $(MAN_PAGE)
endif

all: build

build: $(VERSION_FILE) $(TARGET)

check:
	$(HARE) test

docs: $(DOC_TARGETS)

# Build executable.
$(TARGET): $(SOURCES) $(VERSION_FILE)
	@mkdir -p ./bin
	$(HARE) build $(HAREFLAGS) -o ./bin/$@ ./cmd/$@/

# Update version information.
$(VERSION_FILE): FORCE
	@mkdir -p "$(@D)"
	@{ \
		printf '// SPDX-License-Identifier: MPL-2.0\n'; \
		printf '// (C) 2026 Tom Spencer <tcs.git@pm.me>\n\n'; \
		printf '// Semantic version of the current release.\n'; \
		printf 'export def SEM_VERSION: str = "%s";\n' "$(SEM_VERSION)"; \
		printf '// Git commit identifier of the current build.\n'; \
		printf 'export def GIT_VERSION: str = "%s";\n' "$(GIT_VERSION)"; \
	} > "$@"

# Generate markdown module documentation.
$(HAREDOC_PAGE): $(SOURCES)
	@mkdir -p "$(@D)"
	$(HAREDOC) -a ./si | $(PYTHON) ./scripts/generate_docs.py > "$@"

# Generate man page.
$(MAN_PAGE): $(MAN_SOURCE)
	@mkdir -p "$(@D)"
	$(PANDOC) "$(MAN_SOURCE)" -t man -s -o "$@"

FORCE:

install: build docs install-bin install-lib install-docs install-completions

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

# Generate and install shell completions using the compiled executable.
install-completions: build
	@if [ -n "$(BASH_DIR)" ]; then \
		mkdir -p "$(DESTDIR)$(BASH_DIR)"; \
		./bin/$(TARGET) --completions bash > "$(DESTDIR)$(BASH_DIR)/$(TARGET)"; \
	else \
		echo "Bash completion directory not specified; skipping"; \
	fi
	@if [ -n "$(ZSH_DIR)" ]; then \
		mkdir -p "$(DESTDIR)$(ZSH_DIR)"; \
		./bin/$(TARGET) --completions zsh > "$(DESTDIR)$(ZSH_DIR)/_$(TARGET)"; \
	else \
		echo "Zsh completion directory not specified; skipping"; \
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
	rm -f ./bin/$(TARGET) $(MAN_PAGE)

help:
	@printf '%s\n' \
		'Usage: make [target] [VARIABLE=value]' \
		'' \
		'Targets:' \
		'  all                   Build executable (default)' \
		'  build                 Build executable' \
		'  check                 Run test suite' \
		'  docs                  Build available documentation' \
		'  install               Install all components' \
		'  install-bin           Install executable' \
		'  install-lib           Install Hare module' \
		'  install-docs          Install man page' \
		'  install-completions   Generate and install shell completions' \
		'  uninstall             Remove installed components' \
		'  clean                 Remove generated build artifacts' \
		'' \
		'Variables:' \
		'  PREFIX                Installation prefix (default: /usr/local)' \
		'  DESTDIR               Staging directory' \
		'  HARESRCDIR            Hare source directory' \
		'  BASH_DIR              Bash completion directory' \
		'  ZSH_DIR               Zsh completion directory'

.PHONY: all build check docs install install-bin install-lib \
        install-docs install-completions uninstall uninstall-bin \
        uninstall-lib uninstall-docs uninstall-completions clean help FORCE
