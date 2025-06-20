Config = {}

Config.Framework = 'qb' -- 'qb' for QB-Core or 'esx' for ESX
Config.Inventory = 'ox' -- 'ox' for ox_inventory or 'qb' for qb-inventory
Config.Notification = 'ox' -- 'ox' for ox_lib, 'qb' for QBCore, 'esx' for ESX

Config.Command = 'starterpack'

Config.StarterPack = {
    {item = 'sandwich', count = 5},
    {item = 'water_bottle', count = 5},
    {item = 'phone', count = 1},
    {item = 'cash', count = 5000}
}

Config.Messages = {
    already_claimed = 'You have already claimed your starter pack!',
    claimed_success = 'You have successfully claimed your starter pack!',
    claim_error = 'There was an error claiming your starter pack.'
}