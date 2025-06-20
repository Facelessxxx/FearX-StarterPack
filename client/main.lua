if Config.Framework == 'qb' then
    QBCore = exports['qb-core']:GetCoreObject()
    
    RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
        
    end)
    
    RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
        
    end)
else
    ESX = exports['es_extended']:getSharedObject()
    
    RegisterNetEvent('esx:playerLoaded')
    AddEventHandler('esx:playerLoaded', function(xPlayer)
        ESX.PlayerData = xPlayer
    end)
    
    RegisterNetEvent('esx:setJob')
    AddEventHandler('esx:setJob', function(job)
        ESX.PlayerData.job = job
    end)
end