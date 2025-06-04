# Fearx-StarterPacks

## Preview:

https://r2.fivemanage.com/reN0iza3vc4oGjJ0nDgay/Desktop2025.06.03-10.24.06.07.mp4


### FearX-StarterPacks is a script for FiveM. It allows players to claim a one-time starter pack with configurable items to help new players get started on your server.
Features:

- Optimized with 0.00ms
- One-time claim only - Players can only claim once per character
- Configurable items - Easily customize what items players receive
- ESX Compatible - Works with the latest ESX framework
- QBCore Compatible - Works with the latest QBCore framework
- ox_inventory/ Integration - Full compatibility with ox_inventory
- QB_inventory/ Integration - Full compatibility with QB_inventory
- Inventory space checking - Prevents claiming if not enough space
- Database tracking - Tracks claims in MySQL database
- Customizable command - Change the command name in config
- Race condition protection - Prevents multiple claims even when spamming

## Installation

Download the script and place it in your resources folder
Add ensure Fearx-StarterPacks to your server.cfg
The database table will be created automatically on first start
Restart your server

## Dependencies:

oxmysql - MySQL wrapper
ox_inventory - Inventory system
ox_lib - For notifications (optional)

## Configuration:

```lua


Config = {}

Config.Command = 'starterpack'

Config.StarterPack = {
    {item = 'bread', count = 5},
    {item = 'water', count = 5},
    {item = 'phone', count = 1},
    {item = 'cash', count = 5000}
}

Config.Messages = {
    already_claimed = 'You have already claimed your starter pack!',
    claimed_success = 'You have successfully claimed your starter pack!',
    claim_error = 'There was an error claiming your starter pack.'
}

```

