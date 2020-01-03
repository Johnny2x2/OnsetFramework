
local teleportPlace = {
    gas_station = { 125773, 80246, 1645 },
    town = { -182821, -41675, 1160 },
    prison = { -167958, 78089, 1569 },
    diner = { 212405, 94489, 1340 },
    city = { 211526, 176056, 1250 },
    desert_town = { -16223, -8033, 2062 },
    old_town = { 39350, 138061, 1570 }
}

AddCommand("city", function(player)
    SetPlayerLocation(player, 211526, 176056, 1250)
end)

AddCommand("prison", function(player)
    SetPlayerLocation(player, -167958, 78089, 1569)
end)

AddCommand("npc", function(player)
    local x, y, z = GetPlayerLocation(player)
    local h = GetPlayerHeading(player)
    CreateNPC(x, y, z, h)
end)

AddCommand("object", function(player, modelid)
	local x, y, z = GetPlayerLocation(player)

	local object = CreateObject(modelid, x, y+200, z)
	AddPlayerChat(player, "object created "..object)
end)

AddCommand("weapon", function(player, weapon_model)
    SetPlayerWeapon(player, weapon_model, 200, true, GetPlayerEquippedWeaponSlot(player))
end)

AddCommand("pickup", function(player, modelid)
    local x, y, z = GetPlayerLocation(player)
    CreatePickup(modelid, x, y, z)   
end)

function cmd_v(player, model)
	if (model == nil) then
		return AddPlayerChat(player, "Usage: /v <model>")
	end

	model = tonumber(model)

	if (model < 1 or model > 25) then
		return AddPlayerChat(player, "Vehicle model "..model.." does not exist.")
	end

	local x, y, z = GetPlayerLocation(player)
	local h = GetPlayerHeading(player)

	local vehicle = CreateVehicle(model, x, y, z, h)
	if (vehicle == false) then
		return AddPlayerChat(player, "Failed to spawn your vehicle")
	end

	SetVehicleLicensePlate(vehicle, "ONSET")
	AttachVehicleNitro(vehicle, true)

	if (model == 8) then
		-- Set Ambulance blue color and license plate text
		SetVehicleColor(vehicle, RGB(0.0, 60.0, 240.0))
		SetVehicleLicensePlate(vehicle, "EMS-02")
	end

	SetPlayerInVehicle(player, vehicle , 1)
	AddPlayerChat(player, "Vehicle "..vehicle)
end
AddCommand("vehicle", cmd_v)

local hat = 0
function cmd_attach(player, hatobject, bone, x, y, z, r1, r2, r3)
	local hatModel = 0

	if hatobject == nil then
		local startHats = 398
		local endHats = 477

		hatModel = Random(startHats, endHats)
	else
		hatModel = math.tointeger(hatobject)
	end

	local x1, y1, z1 = GetPlayerLocation(player)

	if hat == 0 then
		hat = CreateObject(hatModel, x1, y1, z1)
	else
		DestroyObject(hat)		
		hat = CreateObject(hatModel, x1, y1, z1)
	end

	SetObjectAttached(hat, ATTACH_PLAYER, player, x, y, z, r1, r2, r3, bone)
end
AddCommand("attach", cmd_attach)

function cmd_attach(player, vehicleid, objectid, bone, x, y, z, r1, r2, r3)
	SetObjectAttached(objectid, ATTACH_VEHICLE, vehicleid, x, y, z, r1, r2, r3, bone)
end
AddCommand("attachv", cmd_attach)

AddCommand("anim", function(playerid, animationid)
    SetPlayerAnimation(playerid, animationid)
end)

AddCommand("getloc", function(player)
	local x, y, z = GetPlayerLocation(player)	
	AddPlayerChat(player, "location = ".. x..", "..y..", "..z) 
end)

AddCommand("setloc", function(player, x, y, z)
	SetPlayerLocation(player, x, y, z, 0)
end)
	--Backpack /attach 821 pelvis  10 -20 3  180 90 -90

AddCommand("fwdx", function(player, dist)
	local x, y, z = GetPlayerLocation(player)
	local h = GetPlayerHeading(player)
	SetPlayerLocation(player, x + dist, y, z, h)
end)

AddCommand("fwdy", function(player, dist)
	local x, y, z = GetPlayerLocation(player)
	local h = GetPlayerHeading(player)
	SetPlayerLocation(player, x, y + dist, z, h)
end)

