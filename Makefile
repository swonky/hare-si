PREFIX ?= /usr/local
BINDIR ?= $(PREFIX)/bin

TARGET := ./bin/si
SOURCES := $(wildcard *.ha)
VERSION_FILE := version.ha

SEM_VERSION := 0.0.1
GIT_VERSION := $(shell git describe --always --dirty 2>/dev/null || echo unknown)

.PHONY: all build install uninstall clean FORCE

all: build

build: $(TARGET)

$(TARGET): $(SOURCES) $(VERSION_FILE)
	@mkdir -p ./bin
	hare build -o $@ 

$(VERSION_FILE): FORCE
	@printf 'export const sem_version: str = "%s";\nexport const git_version: str = "%s";\n' "$(SEM_VERSION)" "$(GIT_VERSION)" > $@

FORCE:

install: build
	install -Dm755 $(TARGET) "$(DESTDIR)$(BINDIR)/si"

uninstall:
	rm -f "$(DESTDIR)$(BINDIR)/si"

clean:
	rm -f $(TARGET)
