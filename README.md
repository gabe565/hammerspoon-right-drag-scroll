# Hammerspoon Right Drag Scroll

Scroll when right mouse button is dragged. Useful with trackball mice, but works with anything.

## Installation

1. Install [Hammerspoon](https://www.hammerspoon.org).
2. Download this repo.
3. Double click `RightDragScroll.spoon`. Hammerspoon will install it.
4. Open the Hammerspoon menu item and click "Open Config" (or edit `~/.hammerspoon/init.lua`).
5. Add the following lines to the config and save:
    ```lua
    hs.loadSpoon("RightDragScroll")
    spoon.RightDragScroll:start()
    ```
5. Reload the config from the Hammerspoon menu item.
6. Now you can hold the right mouse button and move the cursor to scroll!
