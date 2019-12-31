local _ = function(k,...) return ImportPackage("i18n").t(GetPackageName(),k,...) end

PickupGatherCached = { }
--Add New pickup gather item
PickupGatherTable = 
{
	{
        Modelid = 130, --pickup Model ID
        pickupItem = "wild_berries",
        location = {  --Pickup location
            {216569.641, 175910.734, 1290.324},
            {216569.641, 176010.734, 1290.324}
        }  ,     
        pickupid = {} --Pickup id of the object
    },
    {
        Modelid = 131,
        pickupItem = "wild_berries_2",
        location = {
            {215569.641, 175710.734, 1290.324},
            {216569.641, 176010.734, 1290.324}
        },
        pickupid = {}
    }
}

AddEvent("OnPackageStart", function()

    SpawnGatherItems()

    --Respawn Berries every minute
    CreateTimer(function()
        ReSpawnGatherItems()
        AddPlayerChatAll("Spawning Gather items") --Temp delete after debug
        CallRemoteEvent(player, "pickupGatherSetup", PickupGatherCached )
    end, 60000) 

end)


AddEvent("OnPlayerJoin", function(player)
	CallRemoteEvent(player, "pickupGatherSetup", PickupGatherCached )
end)


function ReSpawnGatherItems()
    for k,v in pairs(PickupGatherTable) do
        for i,j in pairs(v.location) do
            if v.pickupid == nil then
                v.pickupid[i] = CreateObject(v.Modelid, v.location[i][1], v.location[i][2], v.location[i][3])
                CreateText3D(_("Gather").."\n".._("press_e"), 18, v.location[i][1], v.location[i][2], v.location[i][3], 0, 0, 0)	
                table.insert(PickupGatherCached, v.pickupid[i])
            elseif v.pickupid[i] == nil then
                v.pickupid[i] = CreateObject(v.Modelid, v.location[i][1], v.location[i][2], v.location[i][3])
                CreateText3D(_("Gather").."\n".._("press_e"), 18, v.location[i][1], v.location[i][2], v.location[i][3], 0, 0, 0)
                table.insert(PickupGatherCached, v.pickupid[i])	
            end

		end      
	end	
end

function SpawnGatherItems()
    for k,v in pairs(PickupGatherTable) do
        for i,j in pairs(v.location) do
            v.pickupid[i] = CreateObject(v.Modelid, v.location[i][1], v.location[i][2], v.location[i][3])
            CreateText3D(_("Gather"), 18, v.location[i][1], v.location[i][2], v.location[i][3], 0, 0, 0)	
		end      
	end	
end

AddRemoteEvent("pickupGatherInteract", function(player, pgobject)
    local pickupGather, objectid = GetpickupGatherByObject(pgobject)

	if pickupGather then
		local x, y, z = GetObjectLocation(pickupGather.pickupid[objectid])
		local x2, y2, z2 = GetPlayerLocation(player)
        local dist = GetDistance3D(x, y, z, x2, y2, z2)

		if dist < 250 then
			for k,v in pairs(PickupGatherTable) do
				if pgobject == v.pickupid[objectid] then
					local randomBerryAmount = math.Random(2, 5)
                    CallRemoteEvent(player, "MakeNotification", "GOT " .. randomBerryAmount .." BERRIES", "linear-gradient(to right, #00b09b, #96c93d)")
                    AddInventory(player, v.pickupItem, randomBerryAmount)
                    DestroyPickup(v.pickupid[i])
                    v.pickupid[i] = nil     
				end
			end  
			
		end
	end
end)

function GetpickupGatherByObject(object)
    for k,v in pairs(PickupGatherTable) do
        for i,j in pairs(v.pickupid) do
            if j == object then
                return v,i
            end
        end
	end
	return nil
end