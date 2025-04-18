CC = clang
CFLAGS = -fobjc-arc -Wall -Wextra
FRAMEWORKS = -framework AppKit -framework Foundation
SRC = wallpaper.m
BUILD_DIR = build
OUT = $(BUILD_DIR)/wallpaper
INSTALL_PATH = /usr/local/bin/wallpaper
PLIST_NAME = com.aspauldingcode.wallpaper.plist
PLIST_SRC = $(PLIST_NAME)
PLIST_DEST = $(HOME)/Library/LaunchAgents/$(PLIST_NAME)

all: build

build:
	mkdir -p $(BUILD_DIR)
	$(CC) $(CFLAGS) $(FRAMEWORKS) -o $(OUT) $(SRC)

clean:
	rm -rf $(BUILD_DIR)

install: build
	install -m 755 $(OUT) $(INSTALL_PATH)
	@echo "Installed binary to $(INSTALL_PATH)"

	install -m 644 $(PLIST_SRC) $(PLIST_DEST)
	@echo "Installed plist to $(PLIST_DEST)"

	launchctl unload $(PLIST_DEST) 2>/dev/null || true
	launchctl load $(PLIST_DEST)
	@echo "Launch agent reloaded"
