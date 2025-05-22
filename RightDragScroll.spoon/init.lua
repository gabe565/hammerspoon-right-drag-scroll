--- === RightDragScroll ===
---
--- Scroll when right mouse button is dragged. Useful with trackball mice, but works with anything.
---
--- https://github.com/gabe565/hammerspoon-right-drag-scroll

local obj = {}
obj.__index = obj

-- Metadata
obj.name = "RightDragScroll"
obj.version = "0.1"
obj.author = "gabe565"
obj.homepage = "https://github.com/gabe565/hammerspoon-right-drag-scroll"
obj.license = 'MIT - https://opensource.org/licenses/MIT'

-- RightDragScroll.scrollDistTolerance
-- Variable
-- Maximum scroll distance that will trigger a right click
obj.scrollDistTolerance = 20

--- RightDragScroll.scrollDurationTolerance
--- Variable
--- Maximum fractional seconds where a scroll will trigger a right click
obj.scrollDurationTolerance = 0.2

--- RightDragScroll.scrollMultiplierX
--- Variable
--- Horizontal natural scroll multiplier
obj.scrollMultiplierX = 6

--- RightDragScroll.scrollMultiplierY
--- Variable
--- Vertical natural scroll multiplier
obj.scrollMultiplierY = 6

--- RightDragScroll.smoothFactor
--- Variable
--- Adjust this value (0 to 1) to control the smoothing effect
obj.smoothFactor = 0.5

obj.scrollDist = {x = 0, y = 0}
obj.pressedAt = 0

function obj.rightMouseDownCb(e)
  obj.scrollDist = {x = 0, y = 0}
  obj.pressedAt = hs.timer.secondsSinceEpoch()
  return true
end

function obj.rightMouseUpCb(e)
  if hs.math.abs(obj.scrollDist.x) < obj.scrollDistTolerance and hs.math.abs(obj.scrollDist.y) < obj.scrollDistTolerance and hs.timer.secondsSinceEpoch() - obj.pressedAt < obj.scrollDurationTolerance then
    obj.rightMouseDownTap:stop()
    obj.rightMouseUpTap:stop()
    hs.eventtap.rightClick(e:location())
    obj.rightMouseDownTap:start()
    obj.rightMouseUpTap:start()
    return true
  end
  return false
end

function obj.rightMouseDraggedCb(e)
  hs.mouse.absolutePosition(hs.mouse.absolutePosition())

  local dx = e:getProperty(hs.eventtap.event.properties["mouseEventDeltaX"]) * obj.scrollMultiplierX * obj.smoothFactor
  local dy = e:getProperty(hs.eventtap.event.properties["mouseEventDeltaY"]) * obj.scrollMultiplierY * obj.smoothFactor
  if dx == 0 and dy == 0 then
    return true
  end

  local scroll = hs.eventtap.event.newScrollEvent({dx, dy}, {}, "pixel")
  scroll:setFlags(e:getFlags())

  obj.scrollDist.x = obj.scrollDist.x + dx
  obj.scrollDist.y = obj.scrollDist.y + dy

  return true, {scroll}
end

function obj:init()
  self.rightMouseDownTap = hs.eventtap.new({hs.eventtap.event.types.rightMouseDown}, self.rightMouseDownCb)
  self.rightMouseUpTap = hs.eventtap.new({hs.eventtap.event.types.rightMouseUp}, self.rightMouseUpCb)
  self.rightMouseDragged = hs.eventtap.new({hs.eventtap.event.types.rightMouseDragged}, self.rightMouseDraggedCb)

  -- Eager-load the modules
  hs.mouse.absolutePosition()
  hs.timer.secondsSinceEpoch()
  hs.math.abs(0)
end

--- RightDragScroll:start()
--- Method
--- Starts event traps
---
--- Parameters:
---  * None
---
--- Returns:
---  * The RightDragScroll object
function obj:start()
  self.rightMouseDownTap:start()
  self.rightMouseUpTap:start()
  self.rightMouseDragged:start()
  return self
end

--- RightDragScroll:stop()
--- Method
--- Stops event traps
---
--- Parameters:
---  * None
---
--- Returns:
---  * The RightDragScroll object
function obj:stop()
  self.rightMouseDownTap:stop()
  self.rightMouseUpTap:stop()
  self.rightMouseDragged:stop()
  return self
end

return obj
