--[[
# Script Name:  DioSlime
# Description:  <Gathers slime beneath Ectofungus and notes>
# Instructions: Stand near the pools of slime beneath the Ectofungus
# Author:        <Diodude (discord)>
# Version:      <1.0>
# Datum:        <2024.05.11>
--]] -- imports
local API = require("api")

-- variables
local MAX_IDLE_TIME_MINUTES = 15
local afk = os.time()

local slimePuddle = 17119
local slimeBucket = 4286
local notePaper = 30372

-- helper functions
local function idleCheck()
    local timeDiff = os.difftime(os.time(), afk)
    local randomTime = math.random((MAX_IDLE_TIME_MINUTES * 60) * 0.6, (MAX_IDLE_TIME_MINUTES * 60) * 0.9)

    if timeDiff > randomTime then
        API.PIdle2()
        afk = os.time()
        return true
    end
end

local function gameStateChecks()
    local gameState = API.GetGameState2()
    if (gameState ~= 3) then
        API.logDebug('Not ingame with state:', gameState)
        API.Write_LoopyLoop(false)
        return
    end
    if not API.PlayerLoggedIn() then
        API.logDebug('Not Logged In')
        API.Write_LoopyLoop(false)
        return;
    end
end

while (API.Read_LoopyLoop()) do
    API.logDebug("Starting Script!")
    print("Starting Script!")

    API.DoRandomEvents()
    idleCheck()
    gameStateChecks()

    if API.InvFull_() then
        API.logDebug("Noting Slime!")
        print("Noting Slime!")
        API.DoAction_Interface(0x24, 0x10be, 0, 1473, 5, 3, 2832)
        -- API.DoAction_Inventory1(slimeBucket, 0, 0, API.OFF_ACT_GeneralInterface_route1)
        API.RandomSleep2(1200, 400, 800)
        API.DoAction_Interface(0x24, 0x76a4, 0, 1473, 5, 1, 3888)
        -- API.DoAction_Inventory1(notePaper, 0, 0, API.OFF_ACT_GeneralInterface_route1)
        API.RandomSleep2(1200, 400, 800)
    else
        API.logDebug("Getting Slime!")
        API.DoAction_Object1(0x29, 0, {slimePuddle}, 50)
        API.RandomSleep2(1200, 400, 800)
    end

    API.RandomSleep2(1200, 500, 1000)
end
