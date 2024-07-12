<center><img src="https://github.com/zyggy123/zyggy123/blob/images/a-visually-captivating-digital-artwork-of-the-icon-LLOBLlb5TMqLYNKXaaQakw-PHo4zlHbS9uSr4VTJDS0xA.jpeg" alt="Logo" width="500"/></center>

## Name: Lottery Instant Chance System
## Author: Zyggy123
## License: GNU Affero General Public License v3.0

## Description

This Lua script implements a customizable lottery system for AzerothCore and TrinityCore servers. Players can enter the lottery using Emblems of Frost, with a chance to win various prizes. The script features automated prize draws and an intuitive NPC interface for player interaction.

### Features:

- **Customizable Entry Cost:** Players can enter the lottery by spending Emblems of Frost.
- **Automated Prize Draws:** The script automatically selects winners at predefined intervals.
- **Flexible Prize System:** Customize the prizes and their chances of being won.
- **NPC Interface:** Provides an easy-to-use menu for players to interact with the lottery system.
- **Detailed Instructions:** Includes comprehensive instructions for installation, configuration, and customization.

## Installation

1. Place the `lottery.lua` file in your server's `lua_scripts` directory.
2. Modify the following variables at the top of the script to fit your server's settings:

   - `LOTTERY_COST`: Cost for players to enter the lottery (in Emblems of Frost).
   - `COOLDOWN_TIME`: Time interval between consecutive entries (in seconds).
   - `PRIZES`: Customize the list of prizes, each with an ID, name, and chance of winning.

3. Restart your server or reload Lua scripts for changes to take effect.

## Usage

Players interact with the lottery system through a designated NPC. The NPC provides the following options:

1. Enter the lottery
2. View prizes and their chances
3. Close interaction

The system automatically manages cooldowns and prize distributions.

## Customization

Easily customize the script by adjusting the following variables:

- **LOTTERY_COST:** Modify the entry cost using Emblems of Frost.
- **COOLDOWN_TIME:** Adjust the cooldown period between entries.
- **PRIZES:** Edit the prize list by adding, removing, or modifying entries as needed.

### Customizable Prizes

Modify the `PRIZES` table in the script to adjust prizes, each defined with an ID, name, and chance of being won:

```lua
local PRIZES = {
    {id = 12345, name = "Custom Item 1", chance = 10},
    {id = 67890, name = "Custom Item 2", chance = 5},
    -- Add or remove prizes as necessary
}
```
Video

[![Video Demo](https://i9.ytimg.com/vi/gWrXG_T-Omk/mqdefault.jpg?sqp=CLC4wrQG-oaymwEmCMACELQB8quKqQMa8AEB-AH8CYAC0AWKAgwIABABGGUgVyhKMA8=&rs=AOn4CLBddr8u-CbAnPo-y4gs-nXg7JXgwg)](https://www.youtube.com/watch?v=gWrXG_T-Omk)
