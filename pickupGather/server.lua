local _ = function(k,...) return ImportPackage("i18n").t(GetPackageName(),k,...) end

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
    --Start Initial Drop
    SpawnGatherItems()

    --Respawn Pickup Items every minute
    CreateTimer(function()
        DestroyAllpickupGatherObjects() --Destroy all pickup items before respawning all new ones
        SpawnGatherItems() -- Spawn all gather items
        AddPlayerChatAll("Spawning Gather items") --Temp delete after debug
        local gatherObjectsList = GetpickupGatherObjects() --Get ids of all new gather items
        for i, j in pairs(GetAllPlayers()) do
            CallRemoteEvent(j, "pickupGatherSetup", gatherObjectsList) --Send ids to all players
        end      
    end, 60000) 
end)

AddEvent("OnPlayerJoin", function(player)
	CallRemoteEvent(player, "pickupGatherSetup", GetpickupGatherObjects()) --Give player gather ids at start
end)

--Spawn all gather items in gather list
function SpawnGatherItems()
    for k,v in pairs(PickupGatherTable) do
        for i,j in pairs(v.location) do
            v.pickupid[i] = CreateObject(v.Modelid, v.location[i][1], v.location[i][2], v.location[i][3])
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
                    local randomBerryAmount = Random(2, 5)
                    CallRemoteEvent(player, "MakeNotification", _("Gather", randomBerryAmount, _(v.pickupItem)), "linear-gradient(to right, #00b09b, #96c93d)")
                    AddInventory(player, v.pickupItem, randomBerryAmount)
                    DestroyObject(pgobject)
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

function GetpickupGatherObjects()
    local gatherObjectsidlist = {}
    local ListSize = 0
    for k,v in pairs(PickupGatherTable) do
        for i,j in pairs(v.pickupid) do
            ListSize = ListSize + 1
            gatherObjectsidlist[ListSize] = j         
        end
	end
	return gatherObjectsidlist
end

function DestroyAllpickupGatherObjects()
    for k,v in pairs(PickupGatherTable) do
        for i,j in pairs(v.pickupid) do
            DestroyObject(j)      
        end
	end
end