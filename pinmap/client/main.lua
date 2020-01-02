function OnScriptError(message)
    AddPlayerChat('<span color="#ff0000bb" style="bold" size="10">'..message..'</>')
end
AddEvent("OnScriptError", OnScriptError)

local gui = nil

local function OnPackageStart()
	local screenX, screenY = GetScreenSize()
	gui = CreateWebUI(0, 0, 0, 0)
	LoadWebFile(gui, "http://asset/OnsetFramework/pinmap/client/web/map.html")

	SetWebAlignment(gui, 0, 0)
	SetWebAnchors(gui, 0.1, 0.1, 0.9, 0.9)

	SetWebVisibility(gui, WEB_HIDDEN)
end
AddEvent("OnPackageStart", OnPackageStart)

local isMapOpen = false
local timeMapClosed = GetTimeSeconds() --This is to prevent the map from automatically opening again
function OnKeyPress(key)
	if (key == "M") then
		dt = GetTimeSeconds() - timeMapClosed
		if (dt < 0.5) then
			return false
		end
		if (isMapOpen) then
			CloseMap()
		else
			isMapOpen = true
			UpdatePositionOnMap()
			SetWebVisibility(gui, WEB_VISIBLE)
			SetInputMode(INPUT_GAMEANDUI)
			ShowMouseCursor(true)
		end
	end
end
AddEvent("OnKeyPress", OnKeyPress)

function InitializeMapValues() --This will send the width/height of the map which will be used by the WebUI to make sure user does not drag map off screen as well as send the legend info
	local screenX, screenY = GetScreenSize()
	mapWidth = screenX * 0.8
	mapHeight = screenY * 0.8
	jsString = "AssignParameters(" .. mapWidth .. "," .. mapHeight ..");"
	ExecuteWebJS(gui, jsString)


	ExecuteWebJS(gui, "RegisterLegendIcon('market', 'Market', 'market.png');")
	ExecuteWebJS(gui, "RegisterBlip('market', 129000, 78521);")

	ExecuteWebJS(gui, "RegisterLegendIcon('gunstore', 'Gun Store', 'gunstore.png');")
	ExecuteWebJS(gui, "RegisterBlip('gunstore', 101527, -34633);")
	ExecuteWebJS(gui, "RegisterBlip('gunstore', 135200, 192240);")

end
AddEvent("OnMapUILoaded", InitializeMapValues)

local destinationWP = nil
function UpdateMapDestination(worldX, worldY)
	_, _, _, _, worldZ = LineTrace(worldX, worldY, 3000, worldX, worldY, -3000)
	if (destinationWP ~= nil) then
		DestroyWaypoint(destinationWP)
	end
	destinationWP = CreateWaypoint(worldX, worldY, worldZ, "Destination")
end
AddEvent("UpdateMapDestination", UpdateMapDestination)

function ClearMapDestination()
	if (destinationWP ~= nil) then
		DestroyWaypoint(destinationWP)
		destinationWP = nil
	end
end
AddEvent("ClearMapDestination", ClearMapDestination)

function UpdatePositionOnMap()
	if (isMapOpen == true) then
		local x, y, z = GetPlayerLocation()
		heading = GetPlayerHeading() + 90
		if (heading < 0) then
			heading = heading + 360
		end
		jsString = "UpdatePlayerPosition(" .. x .. "," .. y .. "," .. z .. "," .. heading .. ");"
		ExecuteWebJS(gui, jsString)
	end
end
CreateTimer(UpdatePositionOnMap, 250)

function CloseMap()
	SetWebVisibility(gui, WEB_HIDDEN)
	SetInputMode(INPUT_GAME)
	timeMapClosed = GetTimeSeconds()
	isMapOpen = false
	ShowMouseCursor(false)
end
AddEvent("CloseMap", CloseMap)