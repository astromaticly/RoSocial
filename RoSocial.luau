--[[
    RoSocial Library
    ----------------
    An open-source Roblox library for interacting with social features such as friends lists and more.

 	Features:
    - In-game friends system
    - Groups and clans
    - Messaging system
    - Party system
    - Player status tracking

    Usage:
    local RoSocial = require(path.to.RoSocial)

    Example:
    local friendsList = RoSocial:GetFriends(player)
    for _, friend in ipairs(friendsList) do
        print(friend.Name)
    end

    Contribution:
    RoSocial is an open-source project. Contributions are welcome!
    To contribute, please fork the repository, make your changes, and submit a pull request.
    Please follow the coding standards and include appropriate comments and documentation.

    License:
    RoSocial is licensed under the MIT License.
    See LICENSE for more information.

    Authors:
    - astromaticly (@astromaticly)

    Repository:
    GitHub: https://github.com/YourGitHubUsername/RoSocial

    Version:
    1.0.0
--]]

local RoSocial = {}

-- Roblox Services

local Players = game:GetService("Players")
local HttpsService = game:GetService("HttpService")
local DataStoreService = game:GetService("DataStoreService")
local MessagingService = game:GetService("MessagingService")
local RunService = game:GetService("RunService")
local SocialService = game:GetService("SocialService")

-- Events

local FilterText

local CreatePartyEvent
local JoinPartyEvent
local LeavePartyEvent

-- Packages

local Promise = require(script.Promise)
local Warp = require(script.Warp)

-- Local Functions

local function iteratePages(pages)
	return coroutine.wrap(function()
		local pageNum = 1
		while true do
			for _, item in ipairs(pages:GetCurrentPage()) do
				coroutine.yield(item, pageNum)
			end
			if pages.IsFinished then
				break
			end
			pages:AdvanceToNextPageAsync()
			pageNum = pageNum + 1
		end
	end)
end

------------- [[                                    ]] -------------
--							Friends  
------------- [[                            		]] -------------

-- Function to retrieve friends list
function RoSocial:GetFriends(player: Player)
	local UserId = Players:GetUserIdFromNameAsync(player.Name)
	local FriendsTable = {}
	
	return Promise.new(function(resolve, reject, onCancel)
		
		local success, FriendsList = pcall(function()
			return Players:GetFriendsAsync(UserId)
		end)
				
		if not success then
			reject("Failed to get friends list for userId: " .. tostring(UserId))
			return
		end
		
		local coroutineIterator = iteratePages(FriendsList)
		
		local function processNext()
			local success, item, page = coroutine.resume(coroutine.create(coroutineIterator))
			if success and item then
				table.insert(FriendsTable, item.Username)
				processNext()
			elseif not success then
				reject("Failed to process friends list: " .. tostring(item))
			else
				resolve(FriendsTable)
			end
		end
		
		processNext()
		
		if onCancel then
			onCancel(function()
				coroutine.close(coroutineIterator)
			end)
		end
	end)
end


function RoSocial:CreateInvitePrompt(player: Player)
	return SocialService:PromptGameInvite(player)
end

------------- [[                                    ]] -------------
--							In-Game Status  
------------- [[                            		]] -------------

function RoSocial:NewStatus(player: Player)
	
end


------------- [[                                    ]] -------------
--							Utility  
------------- [[                            		]] -------------


function RoSocial:FilterText(player: Player)
	
end


------------- [[                                    ]] -------------
--							Initalization  
------------- [[                            		]] -------------



function RoSocial:Initialize()
	if not self.Initialized then
		-- Perform necessary initialization steps
		print("RoSocial is initializing...")
		
		FilterText = Warp.Server("RoSocial_FilterText")
		
		--[[
		CreatePartyEvent = Warp.Server("RoSocial_JoinParty")
		JoinPartyEvent = Warp.Server("RoSocial_JoinParty")
		LeavePartyEvent = Warp.Server("RoSocial_LeaveParty")
		--]]
	
		script:SetAttribute("Initialized", true)
		print("RoSocial has been initialized.")
		
	else
		warn(string.format("[RoSocial.Initialize]: %s", "RoSocial is already initialized."))
	end
end




return RoSocial
