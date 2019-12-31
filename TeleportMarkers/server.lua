--Add New teleport Markers Here
TeleportMarkerTable = 
{
	{
        Modelid = 334, --Teleport Pickup Model ID
        location = {216569.641, 175567.078, 1305.324}, --Teleport Pickup location
        TeleportTo = {216569.641, 175967.078, 1305.324}, --Teleport player location
        pickupid = 0 --Pickup id of the teleport markers
    },
    {
        Modelid = 334,
        location = {216569.641, 175710.734, 1305.324},
        TeleportTo = {216569.641, 175310.734, 1305.324},
        pickupid = 0
    }
}

AddEvent("OnPackageStart", function()
    for k,v in pairs(TeleportMarkerTable) do
        v.pickupid = CreatePickup(v.Modelid, v.location[1], v.location[2], v.location[3])
	end	
end)


AddEvent("OnPlayerPickupHit", function(player, pickup) 
    for k,v in pairs(TeleportMarkerTable) do
        if pickup == v.pickupid then
			SetPlayerLocation(player, v.TeleportTo[1], v.TeleportTo[2], v.TeleportTo[3])
		end
	end	
end)
