# RoSocial

RoSocial is an open-source Lua module for managing social features in Roblox games. It provides an easy-to-use interface for handling friends lists, groups, messaging, parties, and player status tracking within your game environment.

# Features
- Friends System: Add, remove, and manage friends.
- Groups and Clans: Create and manage player groups.
- Messaging System: Send and receive messages between players.
- Party System: Create and manage in-game parties.
- Player Status Tracking: Track online/offline status of players.

# Installation
To use RoSocial in your Roblox game, follow these steps:
1. Download the latest release from GitHub Releases.
2. Import the module into your game
3. Require the module in your scripts:

```lua
local RoSocial = require(path.to.RoSocial)
```
#Ensure you have Promise.lua & Warp installed & added under the module:

Install promise with: [https://github.com/evaera/roblox-lua-promise](https://github.com/evaera/roblox-lua-promise)

Install warp with: [https://github.com/imezx/Warp](https://github.com/imezx/Warp)


## Usage

### Handling Asynchronous Operations with Promises

RoSocial uses Promises to manage asynchronous operations, such as fetching data or making API calls. Promises simplify error handling and chaining of asynchronous tasks. Here’s how you can integrate Promises into your usage of RoSocial:

#### Example: Fetching Friends List

```lua
-- Example using Promises to fetch a player's friends list

local RoSocial = require(game.ReplicatedStorage.RoSocial)

local friends = RoSocial:GetFriends(game.Players.astromaticly)

friends:andThen(function(friendslist)
	print(friendslist)
end):catch(warn)
```
