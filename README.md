# Hammerspoon Right Drag Scroll

Scrolls when right mouse button is dragged.

## Installation

1. Install [Hammerspoon](https://www.hammerspoon.org).
2. Download this repo.
3. Double click `RightDragScroll.spoon`. Hammerspoon will install it.
4. Add to `~/.hammerspoon/init.lua`:
    ```lua
    hs.loadSpoon("RightDragScroll")
    spoon.RightDragScroll:start()
    ```
5. Reload the config from the Hammerspoon menu item.
