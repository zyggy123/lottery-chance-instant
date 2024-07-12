local LOTTERY_COST = 1 -- Cost to enter the lottery with Emblem of Frost
local EMBLEM_OF_FROST_ID = 49426 -- ID for Emblem of Frost

local COOLDOWN_TIME = 10 -- 1 hour cooldown between lottery entries (in seconds)

local lastParticipationTime = {} -- Table to store the last participation time of each player

-- Table with possible prizes
local prizes = {
    {id = 49623, name = "Shadowmourne", chance = 5}, -- Legendary weapon
    {id = 43952, name = "Reins of the Azure Drake", chance = 5}, -- Epic mount
    {id = 0, name = "Gold", count = 1000, chance = 5}, -- 1000 gold
    {id = 13379, name = "Piccolo of the Flaming Fire", chance = 5},
    {id = 37254, name = "Super Simian Sphere", chance = 5},
    {id = 44606, name = "Toy Train Set", chance = 5},
    {id = 20769, name = "Disgusting Oozeling", chance = 5},
    {id = 43499, name = "Iron Boot Flask", chance = 5},
    {id = 1973, name = "Orb of Deception", chance = 5},
    {id = 6657, name = "Savory Deviate Delight", chance = 5},
    {id = 5462, name = "Dartol's Rod of Transformation", chance = 5},
    {id = 8529, name = "Noggenfogger Elixir", chance = 5},
    {id = 52201, name = "Kalytha's Haunted Locket", chance = 5},
    {id = 19979, name = "Hook of the Master Angler", chance = 5},
    {id = 54651, name = "Gnomeregan Pride", chance = 5},
    {id = 35275, name = "Orb of the Sin'dorei", chance = 5},
    {id = 32782, name = "Time-Lost Figurine", chance = 5},
    {id = 50741, name = "Vrykul Drinking Horn", chance = 5}, -- Replaced "The Heartbreaker" which does not exist
    {id = 40110, name = "Haunted Memento", chance = 5},
    {id = 21540, name = "Elune's Lantern", chance = 5},
    {id = 12820, name = "Winterfall Firewater", chance = 5},
    {id = 19290, name = "Darkmoon Card: Twisting Nether", chance = 5},
    {id = 88370, name = "Puntable Marmot", chance = 5}
}

-- Set the random seed
math.randomseed(os.time())

-- Function to check if a player can enter the lottery based on cooldown
local function canPlayerEnterLottery(player)
    local playerId = player:GetGUIDLow()
    if not lastParticipationTime[playerId] then
        return true -- If never participated, allow entry
    end

    local currentTime = os.time()
    if currentTime - lastParticipationTime[playerId] >= COOLDOWN_TIME then
        return true -- Enough time has passed since last participation
    else
        return false -- Still in cooldown
    end
end

-- Function to update the last participation time of the player
local function updateLastParticipationTime(player)
    lastParticipationTime[player:GetGUIDLow()] = os.time()
end

-- Function to choose a prize from the prize list based on defined chances
local function choosePrize()
    local totalChance = 0
    for _, prize in ipairs(prizes) do
        totalChance = totalChance + prize.chance
    end

    local roll = math.random(totalChance)
    local currentSum = 0

    for _, prize in ipairs(prizes) do
        currentSum = currentSum + prize.chance
        if roll <= currentSum then
            return prize
        end
    end
end

-- Function to handle interaction with the NPC
local function onGossipHello(event, player, object)
    player:GossipClearMenu()
    player:GossipMenuAddItem(0, "Enter the lottery for 1 Emblem of Frost", 1, 1)
    player:GossipMenuAddItem(0, "View prizes and chances", 1, 2)
    player:GossipMenuAddItem(0, "Close", 1, 3)
    player:GossipSendMenu(1, object)
end

-- Function to handle the selection of options in the NPC menu
local function onGossipSelect(event, player, object, sender, intid, code)
    if intid == 1 then
        if canPlayerEnterLottery(player) then
            if player:HasItem(EMBLEM_OF_FROST_ID, LOTTERY_COST) then
                player:RemoveItem(EMBLEM_OF_FROST_ID, LOTTERY_COST)
                local prize = choosePrize()
                if prize then
                    local message = ""
                    if prize.name == "Gold" then
                        player:ModifyMoney(prize.count * 10000) -- 1 gold = 10000 copper
                        message = string.format("Congratulations! You won %d gold!", prize.count)
                    elseif prize.count then
                        player:AddItem(prize.id, prize.count)
                        message = string.format("Congratulations! You won %dx %s!", prize.count, prize.name)
                    else
                        player:AddItem(prize.id, 1)
                        message = string.format("Congratulations! You won %s!", prize.name)
                    end
                    object:SendUnitSay(message, 0) -- NPC uses /s to say the message
                    updateLastParticipationTime(player) -- Update the last participation time
                else
                    player:SendBroadcastMessage("An error occurred while selecting your prize!")
                end
            else
                player:SendBroadcastMessage("You don't have enough Emblems of Frost to enter the lottery!")
            end
        else
            player:SendBroadcastMessage("You must wait before entering the lottery again.")
        end
        player:GossipComplete() -- Close the gossip window after entering the lottery
    elseif intid == 2 then
        player:GossipClearMenu()
        for _, prize in ipairs(prizes) do
            local prizeText = string.format("%s - %d%% chance", prize.name, prize.chance)
            player:GossipMenuAddItem(0, prizeText, 1, 2)
        end
        player:GossipMenuAddItem(0, "Back", 1, 4)
        player:GossipSendMenu(1, object)
    elseif intid == 4 then
        onGossipHello(event, player, object)
    else
        player:GossipComplete() -- Close the gossip window if "Close" or any other option is selected
    end
end

local NPC_ID = 500000 -- Choose an available ID for your NPC

-- Register the NPC's gossip events
RegisterCreatureGossipEvent(NPC_ID, 1, onGossipHello)
RegisterCreatureGossipEvent(NPC_ID, 2, onGossipSelect)

print("Lottery script successfully loaded for NPC with ID " .. NPC_ID)
