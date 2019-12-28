
local _ = function(k,...) return ImportPackage("i18n").t(GetPackageName(),k,...) end

local HungerFoodHud
local ThirstHud
local HealthHud
local VehicleSpeedHud
local VehicleFuelHud
local VehicleHealthHud
local SpeakingHud
local map
function OnPackageStart()
    
    map = CreateWebUI(0, 0, 0, 0, 0, 32)
    SetWebVisibility(map, 2)
    SetWebAnchors(map, 0, 0, 1, 1)
    SetWebAlignment(map, 0, 0)
    SetWebURL(map, "http://asset/onsetrp/Map/minimap.html")
    
	ShowHealthHUD(false)
    ShowWeaponHUD(true)
end
AddEvent("OnPackageStart", OnPackageStart)

AddEvent( "OnGameTick", function()
    --Minimap refresh
    local x, y, z = GetCameraRotation()
    local px,py,pz = GetPlayerLocation()
    --ExecuteWebJS(minimap, "SetHUDHeading("..(360-y)..");")
    --ExecuteWebJS(minimap, "SetMap("..px..","..py..","..y..");")
    -- Hud refresh
    --CallRemoteEvent("getHudData")
end )

function Scoreboard_OnKeyPress(key)
    if key == 'Tab' then
        SetWebVisibility(map, 1)
    end
end
AddEvent('OnKeyPress', Scoreboard_OnKeyPress)

function Scoreboard_OnKeyRelease(key)
    if key == 'Tab' then
      SetWebVisibility(ScoreboardUI, 0)
    end
end
AddEvent('OnKeyRelease', Scoreboard_OnKeyRelease)

function SetHUDMarker(name, h, r, g, b)
    if h == nil then
        ExecuteWebJS(minimap, "SetHUDMarker(\""..name.."\");");
    else
        ExecuteWebJS(minimap, "SetHUDMarker(\""..name.."\", "..h..", "..r..", "..g..", "..b..");");
    end
end

AddRemoteEvent("SetHUDMarker", SetHUDMarker)
