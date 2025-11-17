# Extract version from typst.toml
VERSION := $(shell grep '^version = ' typst.toml | sed 's/version = "\(.*\)"/\1/')

# Create symlink to local package cache
.PHONY: link link-macos link-linux link-windows

link:
ifeq ($(OS),Windows_NT)
	$(MAKE) link-windows
else
ifeq ($(shell uname), Darwin)
	$(MAKE) link-macos
else ifeq ($(shell uname), Linux)
	$(MAKE) link-linux
else
	@echo "Unsupported OS"
	@exit 1
endif
endif

link-macos:
	mkdir -p ~/Library/Caches/typst/packages/preview/tufted
	ln -sf . ~/Library/Caches/typst/packages/preview/tufted/$(VERSION)

link-linux:
	mkdir -p ~/.cache/typst/packages/preview/tufted
	ln -sf $(PWD) ~/.cache/typst/packages/preview/tufted/$(VERSION)

# TODO: Test on Windows
link-windows:
	if not exist "%LOCALAPPDATA%\typst\packages\preview\tufted" mkdir "%LOCALAPPDATA%\typst\packages\preview\tufted"
	mklink /D "%LOCALAPPDATA%\typst\packages\preview\tufted\$(VERSION)" .

