local checkTimer = 0
function OnPackageStart()
	Delay(1000, function()
		checkTimer = CreateTimer(Check, 5000)
		Check()
	end)
	
end
AddEvent("OnPackageStart", OnPackageStart)

function Check()
	local x, y, z = GetPlayerLocation()

	local terrain = GetTerrainHeight(x, y, 99999.9)

	if z < 0 and terrain -400 > z and not IsPlayerInVehicle() then
		CallRemoteEvent("UnderMapFix", terrain)
		AddPlayerChat("You've been teleported as we detected you were underground")
	end
	
end


local HitType = {
    "HIT_AIR",
    "HIT_PLAYER",
    "HIT_VEHICLE",
    "HIT_NPC",
    "HIT_OBJECT",
    "HIT_LANDSCAPE",
    "HIT_WATER"
}

--Collision events
AddEvent(">OnCollisionEnter", function(collision, hittype, hitid)
    AddPlayerChat(">OnCollisionEnter --> collision = "..collision.." - hittype = "..HitType[hittype].." hitid = "..hitid)
end)

AddEvent("OnCollisionLeave", function(collision, hittype, hitid)
    local HitType = {
        "HIT_AIR",
        "HIT_PLAYER",
        "HIT_VEHICLE",
        "HIT_NPC",
        "HIT_OBJECT",
        "HIT_LANDSCAPE",
        "HIT_WATER"
    }
    AddPlayerChat(">OnCOllisionLeave --> collision = "..collision.." - hittype = "..HitType[hittype].." hitid = "..hitid)
end)

--game events

AddEvent("OnResolutionChange", function(width, height)
    AddPlayerChat(">OnResolutionChange width = "..width.." - height = "..height)
end)

--player events

AddEvent("OnPlayerStreamIn", function(otherplayer)
	AddPlayerChat(">OnPlayerStreamIn - otherplayer = " .. otherplayer)
end)

AddEvent("OnPlayerStreamOut", function(otherplayer)
	AddPlayerChat(">OnPlayerStreamOut - otherplayer = " .. otherplayer)
end)

AddEvent("OnPlayerSwitchCamera", function(bIsFirstPerson)
    AddPlayerChat(">OnPlayerSwitchCamera bIsFirstPerson = "..tostring(bIsFirstPerson))
end)

AddEvent("OnPlayerEnterWater", function()
    AddPlayerChat(">OnPlayerEnterWater")
end)
AddEvent("OnPlayerLeaveWater", function()
    AddPlayerChat(">OnPlayerLeaveWater")
end)

AddEvent("OnPlayerDeath", function()
	AddPlayerChat(">OnPlayerDeath")
end)

AddEvent("OnPlayerChatCommand", function(cmd, exists)	
	AddPlayerChat(">OnPlayerChatCommand  - cmd = ".. cmd.. " - exists = "..tostring(exists))
end)

AddEvent("OnPlayerChat", function(text)
	AddPlayerChat(">OnPlayerChat - player = " .. player.. " - Text = ".. text)
end)

AddEvent("OnPlayerSpawn", function()
	AddPlayerChat(">OnPlayerSpawn: player spawned =" .. GetPlayerId())
end)

AddEvent("OnPlayerCrouch", function()
    AddPlayerChat(">OnPlayerCrouch")
end)

AddEvent("OnPlayerEndCrouch", function()
    AddPlayerChat(">OnPlayerEndCrouch")
end)

AddEvent("OnPlayerEndFall", function()
    AddPlayerChat("OnPlayerEndFall")
end)

AddEvent("OnPlayerFall", function()
    AddPlayerChat("OnPlayerFall")
end)

--Weapon events
AddEvent("OnPlayerWeaponShot", function(weapon, hittype, hitid, hitX, hitY, hitZ, startX, startY, normalX, normalY, normalZ) 
	AddPlayerChat(">OnPlayerWeaponShot -->  - weapon = " ..weapon.. " - hittype = " ..tostring(HitType[hittype]).. " - hitid = " ..tostring(hitid).. " - hitX = " ..hitX.. " hitY = ".. hitY.. " - hitZ = " .. hitZ.. " - startX = " .. startX.. " - startY = " .. startY.. " - normalX = " .. normalX.. " - normalY = " ..  normalY.. " - normalZ = " ..  normalZ)
end)

AddEvent("OnPlayerReloaded", function()
    AddPlayerChat(">OnPlayerReloaded")
end)

--Parachuting events
AddEvent("OnPlayerParachuteLand", function()
    AddPlayerChat(">OnPlayerParachuteLand")
end)

AddEvent("OnPlayerSkydiveCrash", function()
    AddPlayerChat(">OnPlayerSkydiveCrash")
end)

AddEvent("OnPlayerCancelSkydive", function()
    AddPlayerChat(">OnPlayerCancelSkydive")
end)

AddEvent("OnPlayerSkydive", function()
    AddPlayerChat(">OnPlayerSkydive")
end)
AddEvent("OnPlayerParachuteOpen", function()
    AddPlayerChat(">OnPlayerParachuteOpen")
end)
AddEvent("OnPlayerParachuteClose", function()
    AddPlayerChat(">OnPlayerParachuteClose")
end)

--key events
-- function OnKeyPress(key)
-- 	AddPlayerChat(">OnKeyPress key = "..key)
-- end
-- AddEvent("OnKeyPress", OnKeyPress)

-- function OnKeyRelease(key)
-- 	AddPlayerChat(">OnKeyRelease key = "..key)
-- end
-- AddEvent("OnKeyRelease", OnKeyRelease)

--npc events
AddEvent("OnNPCStreamIn", function(npc)
	AddPlayerChat(">OnNPCStreamIn --> npc = "..npc)
end)

AddEvent("OnNPCStreamOut", function(npc)
	AddPlayerChat(">OnNPCStreamOut --> npc = "..npc)
end)

--object events
AddEvent("OnObjectStreamIn", function(object)
    AddPlayerChat(">OnObjectStreamIn --> object = "..object)
end)

AddEvent("OnObjectHit", function(object, hittype, hitid, hitX, hitY, hitZ, normalX, normalY, normalZ)
    AddPlayerChat(">OnObjectHit --> object = " .. object.. " - hittype = " ..HitType[hittype].. " - hitid = " ..hitid.. " - hitX = " ..hitX.. " hitY = ".. hitY.. " - hitZ = " .. hitZ.. " - normalX = " .. normalX.. " - normalY = " ..  normalY.. " - normalZ = " ..  normalZ)
end)

AddEvent("OnPlayerBeginEditObject", function(object)
    AddPlayerChat(">OnPlayerBeginEditObject --> object = "..object)
end)

AddEvent("OnPlayerEndEditObject", function(object)
    AddPlayerChat(">OnPlayerEndEditObject --> object = "..object)
end)

--packages
AddEvent("OnPackageStart", function()
	AddPlayerChat(">OnPackageStart")
end)

AddEvent("OnPackageStop", function()
	AddPlayerChat(">OnPackageStop")
end)

AddEvent("OnScriptError", function(message)
	AddPlayerChat(">OnScriptError --> message = "..message)
end)

--pickup events
AddEvent("OnPickupStreamIn", function(Pickup) 
    if Pickup ~= nil then
        AddPlayerChat(">OnPickupStreamIn --> vehicle = "..Pickup)
    end
end)

AddEvent("OnPickupStreamOut", function(vehicle) 
    if Pickup ~= nil then
        AddPlayerChat(">OnPickupStreamOut --> vehicle = "..Pickup)
    end
end)
--text events
AddEvent("OnText3DStreamIn", function(text3d)
    AddPlayerChat(">OnText3DStreamIn = "..text3d)
end)

--Vehicle events
AddEvent("OnVehicleStreamIn", function(vehicle) 
	AddPlayerChat(">OnVehicleStreamIn --> vehicle = "..vehicle)
end)

AddEvent("OnVehicleStreamOut", function(vehicle) 
	AddPlayerChat(">OnVehicleStreamOut --> vehicle = "..vehicle)
end)

--WebUI events

--Sound events
AddEvent("OnSoundUpdateMeta", function(sound, meta)
    AddPlayerChat(">OnSountUpdateMeta --> sound = "..sound.." meta = "..meta)
end)

AddEvent("OnSoundFinished", function(sound)
    AddPlayerChat(">OnSoundFinished --> sound = "..sound)
end)

--Network events

AddEvent("OnPlayerNetworkUpdatePropertyValue", function(player, PropertyName, PropertyValue)
    if PropertyName ~= nil and PropertyValue ~= nil then
        AddPlayerChat(">OnPlayerNetworkUpdatePropertyValue --> player = "..player.." - PropertyName = "..PropertyName.." - PropertyValue = "..tostring(PropertyValue))
    end
end)

AddEvent("OnVehicleNetworkUpdatePropertyValue", function(Vehicle, PropertyName, PropertyValue)
    if PropertyName ~= nil and PropertyValue ~= nil then
        AddPlayerChat(">OnVehicleNetworkUpdatePropertyValue --> Vehicle = "..Vehicle.." - PropertyName = "..PropertyName.." - PropertyValue = "..tostring(PropertyValue))
    end
end)

AddEvent("OnNPCNetworkUpdatePropertyValue", function(npc, PropertyName, PropertyValue)
    if PropertyName ~= nil and PropertyValue ~= nil then
        AddPlayerChat(">OnNPCNetworkUpdatePropertyValue --> npc = "..npc.." - PropertyName = "..PropertyName.." - PropertyValue = "..tostring(PropertyValue))
    end
end)

AddEvent("OnPickupNetworkUpdatePropertyValue", function(Pickup, PropertyName, PropertyValue)
    if PropertyName ~= nil and PropertyValue ~= nil then
        AddPlayerChat(">OnPickupNetworkUpdatePropertyValue --> Pickup = "..Pickup.." - PropertyName = "..PropertyName.." - PropertyValue = "..tostring(PropertyValue))
    end
end)

AddEvent("OnText3DNetworkUpdatePropertyValue", function(textId, PropertyName, PropertyValue)
    if PropertyName ~= nil and PropertyValue ~= nil then
        AddPlayerChat(">OnText3DNetworkUpdatePropertyValue --> textId = "..textId.." - PropertyName = "..PropertyName.." - PropertyValue = "..tostring(PropertyValue))
    end
end)

local selX = 0
local selY = 0
local selZ = 0 
local isEdit = false

AddEvent("OnRenderHUD", function()
    if isEdit == true then
        SetDrawColor(RGB(0, 255, 0))
        DrawPoint3D(selX, selY, selZ + 5.0, 10.0)

        DrawCircle3D(selX, selY, selZ + 5.0, 1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 10.0)

        SetDrawColor(RGB(0, 255, 0))
        DrawLine3D(selX, selY, selZ + 5.0, selX, selY + 100.0, selZ + 5.0, 1.0)

        SetDrawColor(RGB(255, 0, 0))
        DrawLine3D(selX, selY, selZ + 5.0, selX + 100.0, selY, selZ + 5.0, 1.0)

        SetDrawColor(RGB(0, 0, 255))
        DrawLine3D(selX,selY, selZ + 5.0, selX, selY, selZ + 105.0, 1.0)
    end
end)

AddEvent("OnKeyPress", function(key)
	if key == "Left Mouse Button" and isEdit then
        local x, y, z, distance = GetMouseHitLocation()       
        --AddPlayerChat("Hit: "..x..", "..y..", "..z..", "..distance)
        selX = x
        selY = y
        selZ = z
        AddPlayerChat("Added point : "..x..", "..y..", "..z)
    end

    if key == "Y" then
        isEdit = not isEdit
        AddPlayerChat("isEdit = "..tostring(isEdit))
    end
end)
