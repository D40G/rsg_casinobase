local QBCore = exports['qb-core']:GetCoreObject()

-- sell chips
RegisterServerEvent("rsg_blackjack:server:sellchips")
AddEventHandler("rsg_blackjack:server:sellchips", function()
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local chips = 0
    if Player.PlayerData.items ~= nil and next(Player.PlayerData.items) ~= nil then 
        for k, v in pairs(Player.PlayerData.items) do 
            if Player.PlayerData.items[k] ~= nil then 
                if Player.PlayerData.items[k].name == "casinochips" then 
                    chips = chips + 1 * Player.PlayerData.items[k].amount
                    Player.Functions.RemoveItem("casinochips", Player.PlayerData.items[k].amount, k)
                end
            end
        end
		Player.Functions.AddMoney("cash", chips, "sold-catch")
		TriggerClientEvent('QBCore:Notify', src, 'Thank you, chips exchanged for $'..chips, 'success')
		TriggerEvent("qb-log:server:CreateLog", 'casino', lab, "red", "**"..Player.PlayerData.name .. "** (citizenid: *" .. Player.PlayerData.citizenid .. "* | id: *(" .. Player.PlayerData.source .. "))*: has received $"..chips.." from the casino cashier!")
	end
end)

function SetExports()
exports["rsg_blackjack"]:SetGetChipsCallback(function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    local chips = Player.Functions.GetItemByName("casinochips")

    if Player.PlayerData.items ~= nil and next(Player.PlayerData.items) ~= nil then 
        chips = chips
    end

    return TriggerClientEvent('QBCore:Notify', src, "You have no chips..")
end)

    exports["rsg_blackjack"]:SetTakeChipsCallback(function(source, amount)
        local Player = QBCore.Functions.GetPlayer(source)

        if Player ~= nil then
            Player.Functions.RemoveItem("casinochips", amount)
            TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['casinochips'], "remove")
            TriggerEvent("qb-log:server:CreateLog", "casino", "Chips", "yellow", "**"..GetPlayerName(source) .. "** put $"..amount.." on the blackjack table")
        end
    end)

    exports["rsg_blackjack"]:SetGiveChipsCallback(function(source, amount)
        local Player = QBCore.Functions.GetPlayer(source)

        if Player ~= nil then
            Player.Functions.AddItem("casinochips", amount)
            TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['casinochips'], "add")
            TriggerEvent("qb-log:server:CreateLog", "casino", "Chips", "green", "**"..GetPlayerName(source) .. "** got $"..amount.." from the blackjack table")
        end
    end)
end

AddEventHandler("onResourceStart", function(resourceName)
	if ("rsg_blackjack" == resourceName) then
        Citizen.Wait(1000)
        SetExports()
    end
end)

SetExports()