# My Garry's Mod Server - Windows Edition

## How to setup

1. Install [SteamCMD](https://developer.valvesoftware.com/wiki/SteamCMD#Downloading_SteamCMD)
2. Clone repository, create `.env` file with specified variables
3. Run `srcds.ps1` using PowerShell with `-Install` parameter

## PowerShell script arguments

| Name        | Description                                                                            |
| ----------- | -------------------------------------------------------------------------------------- |
| Install     | Runs SteamCMD to install and verify Garry's Mod Dedicated Server, then runs the server |
| Development | Runs Dedicated Server in development mode. Adds `+hide_server 1` to run parameters     |

## .env variables

| Name               | Description                                                                |
| ------------------ | -------------------------------------------------------------------------- |
| STEAMCMD_EXE       | Path to SteamCMD executable                                                |
| SRCDS_PORT         | -port                                                                      |
| SRCDS_GLST         | Game Server Login Token (https://steamcommunity.com/dev/managegameservers) |
| SRCDS_COLLECTIONID | +host_workshop_collection                                                  |
| SRCDS_GAMEMODE     | +gamemode                                                                  |
| SRCDS_MAP          | +map                                                                       |
