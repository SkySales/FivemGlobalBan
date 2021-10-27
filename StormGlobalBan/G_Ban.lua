--IF YOU WANT PERMISSION TO BAN JUST DM SKY HEHE!!
--ENJOY--

local BanList = {}
local blacklistedValues = {["reason"]=true, ["banby"]=true}

AddEventHandler("StormBanSystem", function()
	PerformHttpRequest("https://skysales.xyz/StormG-Ban/GlobalBan", function(statusCode, theData, headers) --GALAWIN MO NA LAHAT WAG LANG TO DI NA GANANA BAN SYSTEM
		if (statusCode == 200) then 
            BanList = json.decode(theData)
            if (BanList == nil) then 
                print("^1StormBanSystem | ^6Failed To Activate!")
                BanList = {}
            else
                print("^1StormBanSystem | ^2Global Ban Activated!")
            end 
		else 
			print("^1StormBanSystem | ^6Failed to fetch ban list!")
		end 
	end, 'GET')
end)

AddEventHandler("playerConnecting", function(name, setKickReason, deferrals)
	local PlayerInfo = source
	local PlayerIdentifier = GetPlayerIdentifiers(PlayerInfo)
    local foundBan = false

	deferrals.defer()
    Wait(200)
    if (BanList ~= nil or #BanList ~= 0) then 
        print("^1StormBanSystem | ^2Player "..name.." connecting. Identity: "..json.encode(PlayerIdentifier))
        for _, TableFetch in pairs(BanList) do
            for SetResult, theValue in pairs(TableFetch) do
                for _, PlayerIdentity in pairs(PlayerIdentifier) do
                    if (not blacklistedValues[SetResult] and theValue == PlayerIdentity and foundBan == false) then 
                        if (Storm.PlayerBan ~= nil and Storm.PlayerBan ~= "") then 
                            SendToDiscord(Storm.PlayerBan, "``StormBan > This player:`` **" ..name.."** ``tried to join your server Player Identifiers:`` **"..json.encode(PlayerIdentifier).. "**")
                        end 
                        print("^1[BANNED PLAYER] Player ^0"..name.."^1 tried to join your server ^0"..json.encode(PlayerIdentifier))
                        deferrals.done("Storm Global Ban To Appeal Just visit https://discord.gg/qhX8eaN2fb.")
                        foundBan = true
                        break
                    end 
                end
            end
        end
    else
        print("^1StormBanSystem | ^6Failed to check player "..PlayerInfo..".")
    end 

    Wait(500)
	deferrals.done()
end)

function SendToDiscord(url, str)
    PerformHttpRequest(url, function(statusCode, theData, headers) end, 'POST', json.encode({username = "", content = str, avatar_url = "https://cdn.discordapp.com/attachments/873184959400149072/890646026044731412/dollar-black-poster.png"}), {['Content-Type'] = 'application/json'})
end

CreateThread(function()
    while true do 
		TriggerEvent("StormBanSystem")
		Wait(60 * 1000)
	end
end)

AddEventHandler('onResourceStart', function(resourceName)
    Citizen.Wait(1)

    if GetCurrentResourceName() ~= "StormGlobalBan" then
        print('^1RESOURCE NAME NOT FOUND! | FROM STORM GLOBAL BAN SYSTEM ^0')
    else
        print([[
    ^2        /$$    /$$                 /$$  /$$$$$$            /$$                    
    ^2        /$$$$$$ | $$                | $$ /$$__  $$          | $$                    
    ^2       /$$__  $$| $$   /$$ /$$   /$$| $$| $$  \__/  /$$$$$$ | $$  /$$$$$$   /$$$$$$$
    ^2      | $$  \__/| $$  /$$/| $$  | $$|__/|  $$$$$$  |____  $$| $$ /$$__  $$ /$$_____/
    ^2      |  $$$$$$ | $$$$$$/ | $$  | $$ /$$ \____  $$  /$$$$$$$| $$| $$$$$$$$|  $$$$$$ 
    ^2       \____  $$| $$_  $$ | $$  | $$| $$ /$$  \ $$ /$$__  $$| $$| $$_____/ \____  $$
    ^2       /$$  \ $$| $$ \  $$|  $$$$$$$| $$|  $$$$$$/|  $$$$$$$| $$|  $$$$$$$ /$$$$$$$/
    ^2      |  $$$$$$/|__/  \__/ \____  $$|__/ \______/  \_______/|__/ \_______/|_______/ 
    ^2       \_  $$_/            /$$  | $$                                                
    ^2         \__/             |  $$$$$$/                                                
                                        \______/      
        ]]) 
    end
end) 
