
AddRemoteEvent("UnderMapFix", function(player, Terrain)
	local x, y, z = GetPlayerLocation(player)
	SetPlayerLocation(player, x, y, Terrain + 100)	
end)

AddEvent("OnPackageStart", function()
	print("OnPackageStart")
end)

AddEvent("OnPackageStop", function()
	print("OnPackageStop")
end)

AddEvent("OnPlayerServerAuth", function(player)
	print("OnPlayerServerAuth : " ..player)
end)

AddEvent("OnPlayerSteamAuth", function(player)
	print("OnPlayerSteamAuth : " .. player)
end)

AddEvent("OnPlayerStreamIn", function(player, otherplayer)
	print("OnPlayerStreamIn - player = " .. player .. " - otherplayer = " .. otherplayer)
end)

AddEvent("OnPlayerStreamOut", function(player, otherplayer)
	print("OnPlayerStreamOut - player = " .. player .. " - otherplayer = " .. otherplayer)
end)

AddEvent("OnPlayerJoin", function(player)
	print("OnPlayerJoin: " .. player)
end)

AddEvent("OnPlayerSpawn", function(player)
	print("OnPlayerSpawn: " .. player)
end)

AddEvent("OnPlayerDeath", function(player)
	print("OnPlayerDeath: " .. player)
end)

AddEvent("OnPlayerQuit", function(player)
	print("OnPlayerQuit: " .. player)
end)

AddEvent("OnPlayerChat", function(player, text)
	print("OnPlayerChat - player = " .. player.. " - Text = ".. text)
end)

AddEvent("OnPlayerChatCommand", function(player, cmd, exists)	
	print("OnPlayerChatCommand - player = "..player.." - cmd = ".. cmd.. " - exists = ".. tostring(exists))
end)


AddEvent("OnPlayerDamage", function(player, damagetype, amount)
	local DamageName = {
		"Weapon",
		"Explosion",
		"Fire",
		"Fall",
		"Vehicle Collision"
	}

	print("OnPlayerDamage --> "..GetPlayerName(player).."("..player..") took "..amount.." damage of type "..DamageName[damagetype])
end)

AddEvent("OnPlayWeaponHitEffects", function (player, Weapon, HitType, HitId, StartLocation, HitLocation, HitLocationRelative, HitNormal, HitResult)
	print("OnPlayWeaponHitEffects --> player = "..player.." Weapon = "..Weapon.." HitType = "..HitType.." HitId = ".. HitId.. " StartLocation = "..StartLocation.. " HitLocation = ".. HitLocation.. " HitLocationRelative = ".. HitLocationRelative.. " HitNormal = "..HitNormal.. " HitResult = "..HitResult)
end)

AddEvent("OnPlayerWeaponShot", function(player, weapon, hittype, hitid, hitX, hitY, hitZ, startX, startY, normalX, normalY, normalZ) 
	print("OnPlayerWeaponShot --> player = "..player.. "  - weapon = " ..weapon.. " - hittype = " ..hittype.. " - hitid = " ..hitid.. " - hitX = " ..hitX.. " hitY = ".. hitY.. " - hitZ = " .. hitZ.. " - startX = " .. startX.. " - startY = " .. startY.. " - normalX = " .. normalX.. " - normalY = " ..  normalY.. " - normalZ = " ..  normalZ)
end)

AddEvent("OnClientConnectionRequest", function(ip, port) 
	print("OnClientConnectionRequest IP = "..ip.. " - port = "..port)
end)

AddEvent("OnPlayerPickupHit", function(player, pickup) 
	print("OnPlayerPickupHit --> player = " .. player.. "- pickup = "..pickup)
end)

AddEvent("OnPlayerEnterVehicle", function(player, vehicle, seat) 
	print("OnPlayerEnterVehicle --> player = "..player.. " - vehicle = "..vehicle.. " - seat = "..seat)
end)

AddEvent("OnPlayerLeaveVehicle", function(player, vehicle, seat) 
	print("OnPlayerLeaveVehicle --> player = "..player.. " - vehicle = "..vehicle.. " - seat = "..seat)
end)

AddEvent("OnPlayerStateChange", function(player,newstate,oldstate)
	local playerStates = {
		"PS_NONE",
		"PS_ONFOOT",
		"PS_DRIVER",
		"PS_PASSENGER",
		"PS_ENTER_VEHICLE_DRIVER",
		"PS_ENTER_VEHICLE_PASSENGER",
		"PS_EXIT_VEHICLE",
		"PS_SPECTATE"
	}
	print("OnPlayerStateChange --> player = "..player.." - newstate "..playerStates[newstate+1]..", "..newstate.. " - oldstate = "..playerStates[oldstate+1]..", "..oldstate)
end)

AddEvent("OnVehicleRespawn", function(vehicle)
	print("OnVehicleRespawn --> vehicle = "..vehicle)
end)

AddEvent("OnVehicleStreamIn", function(vehicle, player) 
	print("OnVehicleStreamIn --> vehicle = "..vehicle.. "- player = "..player)
end)

AddEvent("OnVehicleStreamOut", function(vehicle, player) 
	print("OnVehicleStreamOut --> vehicle = "..vehicle.. "- player = "..player)
end)

AddEvent("OnNPCReachTarget", function(npc)
	print("OnNPCReachTarget --> npc = "..npc)
end)

function OnNPCDamage(npc, damagetype, amount)
	local DamageName = {
		"Weapon",
		"Explosion",
		"Fire",
		"Fall",
		"Vehicle Collision"
	}

	print(npc.." took "..amount.." damage of type "..DamageName[damagetype])
end
AddEvent("OnNPCDamage", OnNPCDamage)

AddEvent("OnNPCSpawn", function(npc) 	
	print("OnNPCSpawn --> npc = "..npc)
end)

AddEvent("OnNPCDeath", function(npc, player) 	
	print("OnNPCSpawn --> npc = "..npc.. " - player = "..player)
end)

AddEvent("OnNPCStreamIn", function(npc)
	print("OnNPCStreamIn --> npc = "..npc)
end)

AddEvent("OnNPCStreamIn", function(npc, player)
	print("OnNPCStreamOut --> npc = "..npc.. " player = "..player)
end)

AddEvent("OnPlayerDownloadFile", function(player, FileName, Checksum)
	print("OnPlayerDownloadFile --> player = "..player.." - fileName = ".. FileName.." - checksum = ".. Checksum)
end)