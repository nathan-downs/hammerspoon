# Hammerspoon configurations
A collection of Hammerspoon scripts to automate and enhance macOS functionality.

## Overview
This repository contains my personal Hammerspoon configuration that automatically manages external monitor brightness settings. The primary functionality ensures that external monitors maintain their brightness settings even after disconnection/reconnection or system sleep.

## Features
- Automatic Monitor Brightness Control: Automatically sets external monitor brightness to 100% when connected
- Event-Based Triggering: Responds to display connection/disconnection events
- Startup Initialization: Sets correct brightness levels on system startup
- Error Handling: Provides notifications for successful operations or errors

## Installation
1. Install Hammerspoon:
    ```
    brew install --cask hammerspoon
    ```
2. Clone this repository to your Hammerspoon configuration directory:
    ```
    git clone https://github.com/[yourusername]/hammerspoon-config.git ~/.hammerspoon
    ```
    Or copy the `init.lua` file directly to your Hammerspoon directory.
3. Install the m1ddc utility (required for controlling external monitors):
    ```
    brew install m1ddc
    ```
4. Launch Hammerspoon or reload your configuration if it's already running.

## How It Works
The configuration uses Hammerspoon's screen watcher to detect when displays are connected or disconnected. When such an event occurs, it waits a few seconds for the display to initialize, then sets the brightness to 100% using the m1ddc utility.

Key components:

- IPC Module: Enables command-line interaction with Hammerspoon
- Screen Watcher: Monitors for display changes
- Task Execution: Runs the m1ddc command with proper error handling
- Notifications: Provides feedback on operations

## Requirements
- macOS
- Hammerspoon
- m1ddc utility (for controlling external monitors)
- External monitor that supports DDC/CI over USB-C (DisplayPort Alt Mode)

## Customization
To adjust the brightness level or target a different display, modify the following line in init.lua:
```
{"display", "2", "set", "luminance", "100"}
```
- Change "2" to target a different display number
- Change "100" to set a different brightness level

## Troubleshooting
If the script doesn't work as expected:

1. Verify m1ddc is installed and working by running in Terminal:
    ```
    m1ddc display 2 set luminance 100
    ```
2. Verify the m1ddc path is correct:
    - Find the m1ddc installation location:
    ```
    which m1ddc
    ```
    - Update the `m1ddcPath` varible in `init.lua` to match your system:
    ```
    local m1ddcPath = "/path/to/your/m1ddc"
    ```
3. Check the Hammerspoon console for error messages
4. Ensure your monitor supports DDC/CI commands
5. Verify the correct display number is being targeted

## License
[MIT License](https://mit-license.org/)

## Acknowledgments
- [Hammerspoon](https://www.hammerspoon.org/) for the excellent automation framework
- [m1ddc](https://github.com/waydabber/m1ddc) for providing monitor control functionality on Apple Silicon Macs