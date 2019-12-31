function cmd_commands(playerid)
    CallRemoteEvent(playerid, "openmenuremote")
end
AddCommand("help", cmd_commands)
AddCommand("?", cmd_commands)

AddEvent("OnPlayerJoin", function(player)
    AddPlayerChat(player,"Type /help or /? for help menu")
end)

