.POSIX:
.SUFFIXES:
HARE = hare
HAREFLAGS =

DESTDIR =
PREFIX ?= /usr/local
SRCDIR ?= $(PREFIX)/src

HARESRCDIR = $(SRCDIR)/hare
THIRDPARTYDIR = $(HARESRCDIR)/third-party

TARGET := si
SOURCES := $(wildcard *.ha)
VERSION_FILE := ./si/version.ha

SEM_VERSION := 0.0.1
GIT_VERSION := $(shell git describe --always --dirty 2>/dev/null || echo unknown)

all: build

build: $(TARGET)

$(TARGET): $(SOURCES) $(VERSION_FILE)
	@mkdir -p ./bin
	$(HARE) build $(HAREFLAGS) -o bin/$@ cmd/$@/

$(VERSION_FILE): FORCE
	@printf 'export const sem_version: str = "%s";\nexport const git_version: str = "%s";\n' "$(SEM_VERSION)" "$(GIT_VERSION)" > $@

FORCE:

install: build
	install -Dm755 $(TARGET) "$(DESTDIR)$(BINDIR)/si"

uninstall:
	rm -f "$(DESTDIR)$(BINDIR)/si"

clean:
	rm -f $(TARGET)

.PHONY: all build install uninstall clean FORCE
