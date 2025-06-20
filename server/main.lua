if Config.Framework == 'qb' then
    QBCore = exports['qb-core']:GetCoreObject()
else
    ESX = exports['es_extended']:getSharedObject()
end

function SendNotification(source, message, type)
    if Config.Notification == 'ox' then
        TriggerClientEvent('ox_lib:notify', source, {
            title = 'Starter Pack',
            description = message,
            type = type
        })
    elseif Config.Notification == 'qb' then
        TriggerClientEvent('QBCore:Notify', source, message, type)
    elseif Config.Notification == 'esx' then
        TriggerClientEvent('esx:showNotification', source, message)
    end
end

MySQL.ready(function()
    MySQL.query([[
        CREATE TABLE IF NOT EXISTS `fearx_starterpacks` (
            `identifier` varchar(60) NOT NULL,
            `claimed` tinyint(1) DEFAULT '0',
            PRIMARY KEY (`identifier`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
    ]])
end)

RegisterCommand(Config.Command, function(source, args, rawCommand)
    local Player = nil
    local identifier = nil
    
    if Config.Framework == 'qb' then
        Player = QBCore.Functions.GetPlayer(source)
        if not Player then return end
        identifier = Player.PlayerData.citizenid
    else
        Player = ESX.GetPlayerFromId(source)
        if not Player then return end
        identifier = Player.getIdentifier()
    end
    
    local result = MySQL.query.await('SELECT claimed FROM fearx_starterpacks WHERE identifier = ?', {identifier})
    
    if result[1] and result[1].claimed == 1 then
        SendNotification(source, Config.Messages.already_claimed, 'error')
        return
    end
    
    if result[1] then
        local updateResult = MySQL.update.await('UPDATE fearx_starterpacks SET claimed = 1 WHERE identifier = ? AND claimed = 0', {identifier})
        if updateResult == 0 then
            SendNotification(source, Config.Messages.already_claimed, 'error')
            return
        end
    else
        MySQL.insert.await('INSERT INTO fearx_starterpacks (identifier, claimed) VALUES (?, 1)', {identifier})
    end
    
    local success = true
    local failedItems = {}
    
    for _, item in pairs(Config.StarterPack) do
        if Config.Framework == 'qb' then
            if item.item == 'cash' then
                Player.Functions.AddMoney('cash', item.count)
            else
                if Config.Inventory == 'ox' then
                    local canCarry = exports.ox_inventory:CanCarryItem(source, item.item, item.count)
                    if canCarry then
                        exports.ox_inventory:AddItem(source, item.item, item.count)
                    else
                        table.insert(failedItems, item.item)
                        success = false
                    end
                else
                    local canCarry = Player.Functions.AddItem(item.item, item.count)
                    if not canCarry then
                        table.insert(failedItems, item.item)
                        success = false
                    end
                end
            end
        else
            if item.item == 'money' then
                Player.addMoney(item.count)
            else
                if Config.Inventory == 'ox' then
                    local success_add = exports.ox_inventory:AddItem(source, item.item, item.count)
                    if not success_add then
                        table.insert(failedItems, item.item)
                        success = false
                    end
                else
                    Player.addInventoryItem(item.item, item.count)
                end
            end
        end
    end
    
    if success then
        SendNotification(source, Config.Messages.claimed_success, 'success')
    else
        SendNotification(source, 'Not enough inventory space!', 'error')
    end
end, false)