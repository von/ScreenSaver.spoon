--- === ScreenSaver ===
--- Control the MacOSX screen saver.
---

local ScreenSaver = {}


-- Metadata
ScreenSaver.name="ScreenSaver"
ScreenSaver.version="0.2"
ScreenSaver.author="Von Welch"
-- https://opensource.org/licenses/Apache-2.0
ScreenSaver.license="Apache-2.0"
ScreenSaver.homepage="https://github.com/von/ScreenSaver.spoon"

-- Constants
local defaultsPath = "/usr/bin/defaults"
local killallPath = "/usr/bin/killall"

--- ScreenSaver.defaultTimeout
--- Variable
--- Idle timeout in seconds to be used if no value provided.
ScreenSaver.defaultTimeout = 1200

--- ScreenSaver.defaultSuspendTime
--- Variable
--- Default time to suspend screensaver for suspend() method. In seconds.
ScreenSaver.defaultSuspendTime = 3600

--- ScreenSaver.lastTimeout
--- Variable
--- Timeout that was in place when disable() called.
ScreenSaver.lastTimeout = nil

--- ScreenSaver:debug(enable)
--- Function
--- Enable or disable debugging
---
--- Parameters:
---  * enable - Boolean indicating whether debugging should be on
---
--- Returns:
---  * Nothing
function ScreenSaver:debug(enable)
  if enable then
    self.log.setLogLevel('debug')
    self.log.d("Debugging enabled")
  else
    self.log.d("Disabling debugging")
    self.log.setLogLevel('info')
  end
end


--- ScreenSaver:init()
--- Function
--- Initializes a ScreenSaver
---
--- Parameters:
---  * None
---
--- Returns:
---  * ScreenSaver object

function ScreenSaver:init()
  -- Set up logger for spoon
  self.log = hs.logger.new("ScreenSaver")

  -- Path to this file itself
  -- See also http://www.hammerspoon.org/docs/hs.spoons.html#resourcePath
  self.path = hs.spoons.scriptPath()

  -- timer used by suspend() method
  self.timer = nil

  return self
end

--- ScreenSaver:disable()
--- Function
--- Disable the screensaver.
---
--- Parameters:
--- * None
---
--- Returns:
--- * true on sucess, false on error

function ScreenSaver:disable()
  if self.timer then
    -- Cancel existing suspend
    self.timer:stop()
    self.timer = nil
  end
  self.lastTimeout = self:getTimeout()
  self:setTimeout(0)
end

--- ScreenSaver:enable()
--- Function
--- Enable the screensaver.
---
--- Parameters:
--- * idleTimeout (optional): Timeout in seconds. If not provided, then the value
--- saved from the last vall to disable() will be used. If there is no saved value,
--- then ScreenSaver.defaultTimeout will be used. If provided should be one of:
--- 60, 120, 300, 600, 1200, 1800, 6000
---
--- Returns:
--- * true on sucess, false on error

function ScreenSaver:enable(timeout)
  local t = timeout or self.lastTimeout or self.defaultTimeout
  if self.timer then
    -- Cancel existing suspend
    self.timer:stop()
    self.timer = nil
  end
  self:setTimeout(t)
end

--- ScreenSaver:suspend()
--- Function
--- Suspend the screensaver.
---
--- Parameters:
--- * time (optional): Suspend the screensaver for time in seconds. If not provided,
--- suspends for ScreenSaver.defaultSuspendTime.
---
--- Returns:
--- * true on sucess, false on error

function ScreenSaver:suspend(time)
  local t = time or self.defaultSuspendTime
  if self.timer then
    -- Cancel existing suspend
    self.timer:stop()
    self.timer = nil
  end
  if not self:disable() then
    return false
  end
  self.timer = hs.timer.doAfter(t, function() self:enable() end)
  return true
end

--- ScreenSaver:getTimeout()
--- Function
--- Return the current timeout.
---
--- Parameters:
--- * None
---
--- Returns:
--- * Current timeout in seconds, nil on error
function ScreenSaver:getTimeout()
  local command = string.format(
    "%s -currentHost read com.apple.screensaver idleTime",
    defaultsPath)
  local output, status, type, rc = hs.execute(command)
  if not status then
    self.log.ef(
      "getTimeout(): execution of %s failed: type: %s rc: %d",
      defaultsPath, type, rc)
    return nil
  end
  self.log.df("Got idle timeout: %s", output)
  return tonumber(output)
end

--- ScreenSaver:setTimeout()
--- Function
--- Set idle timeout for the screensaver.
--- Note that OSX seems to only accept following values for screensaver idle delay:
--- 60, 120, 300, 600, 1200, 1800, 6000
--- Any other values seems to cause the default of 1200 to be used.
--- Set to 0 to disable screensaver.
---
--- Parameters:
--- * timeout: Timeout in seconds.
---
--- Returns:
--- * true on success, false on error.

function ScreenSaver:setTimeout(timeout)
  self.log.df("Setting idle timeout: %d", timeout)
  local command = string.format(
    "%s -currentHost write com.apple.screensaver idleTime -int %d",
    defaultsPath, timeout)
  local output, status, type, rc = hs.execute(command)
  if not status then
    self.log.ef(
      "setTimeout(): execution of %s failed: type: %s rc: %d",
      defaultsPath, type, rc)
    return false
  end
  -- Restart cfprefsd. Needed to causes defaults to be read.
  -- Kudos: https://superuser.com/a/914884
  command = string.format("%s cfprefsd", killallPath)
  local output, status, type, rc = hs.execute(command)
  if not status then
    self.log.ef(
      "setTimeout(): failed to restart cfprefsd: type %s rc: %d",
      type, rc)
    return false
  end
  return true
end

--- ScreenSaver:bindHotKeys(table)
--- Function
--- The method accepts a single parameter, which is a table. The keys of the table
--- are strings that describe the action performed, and the values of the table are
--- tables containing modifiers and keynames/keycodes. E.g.
---   {
---     disable = {{"cmd", "alt"}, "d"},
---     enable = {{"cmd", "alt"}, "e"},
---     suspend = {{"cmd", "alt"}, "s"}
---    }
---
---
--- Parameters:
---  * mapping - Table of action to key mappings
---
--- Returns:
---  * ScreenSaver object

function ScreenSaver:bindHotKeys(mapping)
  local spec = {
    disable = hs.fnutils.partial(self.disable, self),
    enable = hs.fnutils.partial(self.enable, self),
    suspend = hs.fnutils.partial(self.suspend, self)
  }
  hs.spoons.bindHotkeysToSpec(spec, mapping)
  return self
end

return ScreenSaver
