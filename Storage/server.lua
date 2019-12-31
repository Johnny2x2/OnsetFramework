local _ = function(k,...) return ImportPackage("i18n").t(GetPackageName(),k,...) end

StorageBoxData = {}

function CreateStorageBoxDataData(player, object, modelid)
    StorageBoxData[object] = {}

    StorageBoxData[object].id = 0
    StorageBoxData[object].owner = PlayerData[player].accountid
    StorageBoxData[object].modelid = modelid
    StorageBoxData[object].inventory = {}


    print("Data created for : "..object)
end

function OnPackageStart()
    -- Save all player data automatically 
    CreateTimer(function()
		for k,v in pairs(StorageBoxData) do
            SaveStorageBoxData(k)
            
        end
        print("All Storage Box have been saved !")
    end, 30000)


end
AddEvent("OnPackageStart", OnPackageStart)

function onGetStorageBoxDatabase(object)
    StorageBoxData[object].id = mariadb_get_insert_id()
end


function SpawnAllStorageBoxes()

    local query = mariadb_prepare(sql, "SELECT * FROM player_storagebox;")

    mariadb_async_query(sql, query, function()
        local rows = mariadb_get_row_count()
        if rows ~= 0 then
            for i=1, rows do
                local result = mariadb_get_assoc(i)
                       
            end
        end
    end)

    json_decode(
    createStorageBox(player, vehicle, modelid, x, y, x, rx, ry, rz)
end

function SaveStorageBoxData(object) 
    local query = mariadb_prepare(sql, "UPDATE player_storagebox SET ownerid = '?', inventory = '?' WHERE id = '?' LIMIT 1;",
    StorageBoxData[object].owner,
    json_encode(StorageBoxData[object].inventory),
    StorageBoxData[vehicle].id
    )
    
    mariadb_query(sql, query)
end

function DestroyStorageBoxData(object)
	if (StorageBoxData[object] == nil) then
		return
    end
    StorageBoxData[object] = nil
end

AddRemoteEvent("ServerStorageBoxMenu", function(player, object)
    if StorageBoxData[object].owner == PlayerData[player].accountid then
        CallRemoteEvent(player, "OpenStorageBoxMenu")
    end
end)

AddRemoteEvent("OpenTrunk", function(player)
    local vehicle = GetNearestCar(player)
    CallRemoteEvent(player, "OpenOpenStorageBoxInventoryInventory", PlayerData[player].inventory, VehicleData[vehicle].inventory)
end)


AddRemoteEvent("CloseTrunk", function(player)
    local vehicle = GetNearestStorageBox(player)
    SetVehicleTrunkRatio(vehicle, 0.0)
end)


function CreateSpawnStorageBox(player,  modelid, x, y, x, rx, ry, rz)
        local StorageBox = CreateObject(modelid, x, y, z, rx, ry , rz)
        SetObjectPropertyValue(StorageBox, "isSB", 1, true)

        local query = mariadb_prepare(sql, "INSERT INTO player_storagebox (id, ownerid, modelid, locationX, locationY, locationZ, rX, rY, rZ, inventory) VALUES (NULL, '?', '?', '?', '?','?','?','?','?','[]');",
            tostring(PlayerData[player].accountid),
            tostring(modelid),x,y,z,rx,ry,rz)
        mariadb_async_query(sql, query, function ()
            StorageBoxData[StorageBox].id = mariadb_get_insert_id()
        end)
    else
        AddPlayerChat(player, "Failed to place storage box: To close to another storage box")     
    end
end
AddCommand("spawnSB",CreateSpawnStorageBox)

function CreateStorageBox(player, vehicle, modelid, x, y, x, rx, ry, rz)
    local StorageBox = CreateObject(modelid, x, y, z, rx, ry , rz)
    SetObjectPropertyValue(StorageBox, "isSB", 1, true)
end

function GetNearestStorageBox(player)
    local x, y, z = GetPlayerLocation(player)
    for k,v in pairs(GetAllVehicles()) do
        local x2, y2, z2 = GetVehicleLocation(v)
        local dist = GetDistance3D(x, y, z, x2, y2, z2)
        if dist < 300.0 then
            if GetObjectPropertyValue(v, "isSB") == 1 then           
                return v
            end
        end
    end
    return 0
end

function AddStorageBoxInventory(object, item, amount)
    if StorageBoxData[object].inventory[item] == nil then
        StorageBoxData[object].inventory[item] = amount
    else
        StorageBoxData[object].inventory[item] = StorageBoxData[object].inventory[item] + amount
    end
end

function RemoveStorageBoxInventory(object, item, amount)
    if StorageBoxData[object].inventory[item] == nil then
        return
    else
        if StorageBoxData[object].inventory[item] - amount < 1 then
            StorageBoxData[object].inventory[item] = nil
        else
            StorageBoxData[object].inventory[item] = StorageBoxData[object].inventory[item] - amount
        end
    end
end