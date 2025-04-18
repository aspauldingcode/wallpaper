# Wallpaper CLI for macOS

This is a macOS tool that enables a daemon to set the wallpaper on macOS using a configuration file located at `~/.config/wallpaper/config.json`.

The tool installs a launch agent to allow for automatic wallpaper changes based on the configuration file, ensuring your wallpaper can be updated programmatically at specified intervals or events.

---

## Features

- Set your macOS wallpaper automatically from a configuration file.
- Uses a launch agent to run the wallpaper setter daemon in the background.
- Configurations are read from `~/.config/wallpaper/config.json`.


## caveats

- Since the wallpaper set on all workspaces in macOS hasn't been
reverse-engineered properly, we're stuck to using a loop which sets the
wallpaper for the active display/workspace. __I know this isn't ideal__.

---

## Installation

### Prerequisites

- macOS with command-line tools installed.
- `clang` as the C compiler.
  
### Steps to Compile and Install

1. **Clone the repository:**
   ```bash
   git clone https://github.com/aspauldingcode/wallpaper.git
   cd wallpaper
   ```

2. **Build the binary:**
   The Makefile uses `clang` to compile the source code. Run the following to build the binary:
   ```bash
   make
   ```

3. **Install the binary:**
   Once compiled, you can install the binary and the necessary launch agent.
   ```bash
   sudo make install
   ```

   This will:
   - Copy the compiled binary to `/usr/local/bin/wallpaper`.
   - Install the launch agent plist to `~/Library/LaunchAgents/com.aspauldingcode.wallpaper.plist`.
   - Load the launch agent so the daemon can start running.

4. **Configure the wallpaper tool:**
   Create the configuration file at `~/.config/wallpaper/config.json` with your desired wallpaper settings.

   Example `config.json`:
   ```json
   {
       "image": "/path/to/your/wallpaper.jpg",
       "mode": "fill"
   }
   ```

   Ensure the path to the wallpaper image is correct and points to an existing file.

5. **The daemon will now be running:**
   The wallpaper tool will be loaded automatically by the launch agent. It will listen for changes to the configuration file and update your wallpaper accordingly.

---

### Common Makefile Targets

- `make build`: Compiles the binary.
- `make clean`: Cleans up the build directory.
- `make install`: Installs the binary and plist, and reloads the launch agent.

## Usage

Once installed, the wallpaper tool will run as a daemon in the background, periodically checking your configuration file (`~/.config/wallpaper/config.json`) for changes. The wallpaper will automatically update according to the configuration.

You can unload or reload the launch agent with the following commands:
- Unload: `launchctl unload ~/Library/LaunchAgents/com.aspauldingcode.wallpaper.plist`
- Reload: `launchctl load ~/Library/LaunchAgents/com.aspauldingcode.wallpaper.plist`
