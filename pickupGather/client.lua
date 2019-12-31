local Dialog = ImportPackage("dialogui")
local _ = _ or function(k,...) return ImportPackage("i18n").t(GetPackageName(),k,...) end

local GatherObject
local ispickupGather
local GatherObjectIds = { }


AddEvent("OnKeyPress", function(key)
    if key == "E" then
        local NearestPickupGather= GetNearestpickupGather()

		if NearestPickupGather ~= 0 then
            CallRemoteEvent("pickupGatherInteract", NearestPickupGather)
        end
        
	end
end)

AddRemoteEvent("pickupGatherSetup", function(GatherObject)
	GatherObjectIds = GatherObject
end)


function GetNearestpickupGather()

	local x, y, z = GetPlayerLocation()

    for k,v in pairs(GetStreamedObjects()) do
        
		local x2, y2, z2 = GetObjectLocation(v)

        local dist = GetDistance3D(x, y, z, x2, y2, z2)
        
		if dist < 250.0 then
            for k,i in pairs(GatherObjectIds) do
				if v == i then
					return v
				end
			end
		end
    end
    
    return 0
    
end

function tablefind(tab, el)
	for index, value in pairs(tab) do
		if value == el then
			return index
		end
	end
end


