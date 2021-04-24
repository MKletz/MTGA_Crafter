# MTGA_Crafter
This PowerShell script will query scryfall for all commons and uncommons from a given set then generate decklists to import into MTGA for easy bulk crafting.

Edit the $Set value at the top of the script for the set you wish craft. If you want to do something other than commons/uncommons just change the $Query to whatever Scryfall query is appropriate.

Decklists of 248 cards each will be created in the directory the script is in. This is because MTGA limits decklists to 250 cards and 4 copies of 62 cards is 248.
