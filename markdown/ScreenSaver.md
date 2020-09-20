# [docs](index.md) » ScreenSaver
---



## API Overview
* Variables - Configurable values
 * [defaultSuspendTime](#defaultSuspendTime)
 * [defaultTimeout](#defaultTimeout)
 * [lastTimeout](#lastTimeout)
* Functions - API calls offered directly by the extension
 * [bindHotKeys](#bindHotKeys)
 * [debug](#debug)
 * [disable](#disable)
 * [enable](#enable)
 * [getTimeout](#getTimeout)
 * [init](#init)
 * [setTimeout](#setTimeout)
 * [suspend](#suspend)

## API Documentation

### Variables

| [defaultSuspendTime](#defaultSuspendTime)         |                                                                                     |
| --------------------------------------------|-------------------------------------------------------------------------------------|
| **Signature**                               | `ScreenSaver.defaultSuspendTime`                                                                    |
| **Type**                                    | Variable                                                                     |
| **Description**                             | Default time to suspend screensaver for suspend() method. In seconds.                                                                     |

| [defaultTimeout](#defaultTimeout)         |                                                                                     |
| --------------------------------------------|-------------------------------------------------------------------------------------|
| **Signature**                               | `ScreenSaver.defaultTimeout`                                                                    |
| **Type**                                    | Variable                                                                     |
| **Description**                             | Idle timeout in seconds to be used if no value provided.                                                                     |

| [lastTimeout](#lastTimeout)         |                                                                                     |
| --------------------------------------------|-------------------------------------------------------------------------------------|
| **Signature**                               | `ScreenSaver.lastTimeout`                                                                    |
| **Type**                                    | Variable                                                                     |
| **Description**                             | Timeout that was in place when disable() called.                                                                     |

### Functions

| [bindHotKeys](#bindHotKeys)         |                                                                                     |
| --------------------------------------------|-------------------------------------------------------------------------------------|
| **Signature**                               | `ScreenSaver:bindHotKeys(table)`                                                                    |
| **Type**                                    | Function                                                                     |
| **Description**                             | The method accepts a single parameter, which is a table. The keys of the table                                                                     |
| **Parameters**                              | <ul><li>mapping - Table of action to key mappings</li></ul> |
| **Returns**                                 | <ul><li>ScreenSaver object</li></ul>          |

| [debug](#debug)         |                                                                                     |
| --------------------------------------------|-------------------------------------------------------------------------------------|
| **Signature**                               | `ScreenSaver:debug(enable)`                                                                    |
| **Type**                                    | Function                                                                     |
| **Description**                             | Enable or disable debugging                                                                     |
| **Parameters**                              | <ul><li>enable - Boolean indicating whether debugging should be on</li></ul> |
| **Returns**                                 | <ul><li>Nothing</li></ul>          |

| [disable](#disable)         |                                                                                     |
| --------------------------------------------|-------------------------------------------------------------------------------------|
| **Signature**                               | `ScreenSaver:disable()`                                                                    |
| **Type**                                    | Function                                                                     |
| **Description**                             | Disable the screensaver.                                                                     |
| **Parameters**                              | <ul><li>* None</li></ul> |
| **Returns**                                 | <ul><li>* true on sucess, false on error</li></ul>          |

| [enable](#enable)         |                                                                                     |
| --------------------------------------------|-------------------------------------------------------------------------------------|
| **Signature**                               | `ScreenSaver:enable()`                                                                    |
| **Type**                                    | Function                                                                     |
| **Description**                             | Enable the screensaver.                                                                     |
| **Parameters**                              | <ul><li>* idleTimeout (optional): Timeout in seconds. If not provided, then the value</li><li>saved from the last vall to disable() will be used. If there is no saved value,</li><li>then ScreenSaver.defaultTimeout will be used. If provided should be one of:</li><li>60, 120, 300, 600, 1200, 1800, 6000</li></ul> |
| **Returns**                                 | <ul><li>* true on sucess, false on error</li></ul>          |

| [getTimeout](#getTimeout)         |                                                                                     |
| --------------------------------------------|-------------------------------------------------------------------------------------|
| **Signature**                               | `ScreenSaver:getTimeout()`                                                                    |
| **Type**                                    | Function                                                                     |
| **Description**                             | Return the current timeout.                                                                     |
| **Parameters**                              | <ul><li>* None</li></ul> |
| **Returns**                                 | <ul><li>* Current timeout in seconds, nil on error</li></ul>          |

| [init](#init)         |                                                                                     |
| --------------------------------------------|-------------------------------------------------------------------------------------|
| **Signature**                               | `ScreenSaver:init()`                                                                    |
| **Type**                                    | Function                                                                     |
| **Description**                             | Initializes a ScreenSaver                                                                     |
| **Parameters**                              | <ul><li>None</li></ul> |
| **Returns**                                 | <ul><li>ScreenSaver object</li></ul>          |

| [setTimeout](#setTimeout)         |                                                                                     |
| --------------------------------------------|-------------------------------------------------------------------------------------|
| **Signature**                               | `ScreenSaver:setTimeout()`                                                                    |
| **Type**                                    | Function                                                                     |
| **Description**                             | Set idle timeout for the screensaver.                                                                     |
| **Parameters**                              | <ul><li>* timeout: Timeout in seconds.</li></ul> |
| **Returns**                                 | <ul><li>* true on success, false on error.</li></ul>          |

| [suspend](#suspend)         |                                                                                     |
| --------------------------------------------|-------------------------------------------------------------------------------------|
| **Signature**                               | `ScreenSaver:suspend()`                                                                    |
| **Type**                                    | Function                                                                     |
| **Description**                             | Suspend the screensaver.                                                                     |
| **Parameters**                              | <ul><li>* time (optional): Suspend the screensaver for time in seconds. If not provided,</li><li>suspends for ScreenSaver.defaultSuspendTime.</li></ul> |
| **Returns**                                 | <ul><li>* true on sucess, false on error</li></ul>          |

