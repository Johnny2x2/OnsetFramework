local _ = function(k,...) return ImportPackage("i18n").t(GetPackageName(),k,...) end

local deliveryNpc = {
    {
        location = {162908.33, 185217.33, 1183, 90} ,                                                 
        spawn = { 163700, 183155.22, 1282.77, 90 },
        npc = 0
    },
    {
        location = {-162908.33, 185217.33, 1183.5, 90} ,                                                 
        spawn = { -163700, 183155.22, 1282.77, 90 },
        npc = 0
    }
}

local garbage = {
    {-194053.0625, -44136.609375, 1151.7413330078},
    {-194469.140625, -44692.0546875, 1148.1514892578},
    {-194456.3125, -46672.43359375, 1148.1514892578},
    {-195033.765625, -47723.33203125, 1148.1505126953},
    {-193969.0625, -48198.5859375, 1148.1505126953},
    {-188525.78125, -47113.9140625, 1148.1505126953},
    {-186823.390625, -48089.51171875, 1148.1505126953},
    {-185500.203125, -47879.328125, 1149.2749023438},
    {-188907.484375, -45118.65625, 1148.1513671875},
    {-188907.4375, -44785.44140625, 1148.1511230469},
    {-187602.71875, -35908.48046875, 1148.1502685547},
    {-185509.0625, -35852.6484375, 1148.1502685547},
    {-183735.515625, -40732.31640625, 1148.1510009766},                     
    {-183735.1875, -41032.85546875, 1148.1513671875},
    {-181748.671875, -42604.5546875, 1148.1510009766},
    {-174117.25, -64476.62890625, 1148.1500244141},
    {-173928.5625, -65023.953125, 1148.1500244141},
    {-171019.53125, -64636.78515625, 1147.9018554688},
    {-171019.515625, -64289.4765625, 1147.9018554688},
    {-177116.421875, -66945.5078125, 1147.8018798828},
    {-177256.546875, -67133.3984375, 1147.8018798828},
    {-177254.53125, -67421.0859375, 1147.8018798828},
    {-177313.078125, -67631.65625, 1147.8018798828},
    {-178402.5, -65967.1484375, 1147.8018798828},
    {-178402.609375, -66264.390625, 1147.8018798828},
    {-181053.5625, -67383.1796875, 1152.0147705078},
    {-181692.828125, -67535.34375, 1147.8939208984},
    {-182089.484375, -67001.578125, 1158.0418701172},
    {-182054.15625, -66423.890625, 1147.7019042969},
    {-169279.421875, -45646.53125, 1149.9621582031},
    {-169674.1875, -44335.6953125, 1148.1510009766},
    {-173141.53125, -41913.3671875, 1148.1510009766},
    {-174834.375, -41834.4609375, 1148.1510009766},
    {-174729.078125, -36123.36328125, 1148.1505126953},
    {-177445.0625, -36783.41796875, 1148.1502685547},
    {-177951.09375, -37955.8359375, 1148.1520996094},
    {-183322.484375, -47967.45703125, 1153.2230224609},
    {-186047.5625, -52065.39453125, 1146.94921875}
}


local deliveryNpcCached = {}
local playerDelivery = {}

AddEvent("OnPackageStart", function()
    for k,v in pairs(deliveryNpc) do
        deliveryNpc[k].npc = CreateNPC(deliveryNpc[k].location[1], deliveryNpc[k].location[2], deliveryNpc[k].location[3],deliveryNpc[k].location[4])
        CreateText3D(_("garbage_job").."\n".._("press_e"), 18, deliveryNpc[k].location[1], deliveryNpc[k].location[2], deliveryNpc[k].location[3] + 120, 0, 0, 0)
        table.insert(deliveryNpcCached, deliveryNpc[k].npc)
    end
end)

AddEvent("OnPlayerQuit", function( player )
    if playerDelivery[player] ~= nil then
        playerDelivery[player] = nil
    end
end)

AddEvent("OnPlayerJoin", function(player)
    CallRemoteEvent(player, "SetupDeliveryTemplate", deliveryNpcCached)
end)

AddRemoteEvent("StartStopDeliveryTemplate", function(player)
    local nearestDelivery = GetNearestDeliveryTemplate(player)
    if PlayerData[player].job == "" then
        if PlayerData[player].job_vehicle ~= nil then
            RemoveVehicle(PlayerData[player].job_vehicle)
            RemovePlayerFromVehicleRestriction(PlayerData[player].job_vehicle, player)
            DestroyVehicle(PlayerData[player].job_vehicle)
            DestroyVehicleData(PlayerData[player].job_vehicle)
            PlayerData[player].job_vehicle = nil
            CallRemoteEvent(player, "ClientDestroyCurrentWaypoint")
        else
            local isSpawnable = true
            local jobCount = 0
            for k,v in pairs(PlayerData) do
                if v.job == "GARBAGE" then
                    jobCount = jobCount + 1
                end
            end
            if jobCount == 15 then
                return CallRemoteEvent(player, "MakeNotification", _("job_full"), "linear-gradient(to right, #ff5f6d, #ffc371)")
            end
            for k,v in pairs(GetAllVehicles()) do
                local x, y, z = GetVehicleLocation(v)
                local dist2 = GetDistance3D(deliveryNpc[nearestDelivery].spawn[1], deliveryNpc[nearestDelivery].spawn[2], deliveryNpc[nearestDelivery].spawn[3], x, y, z)
                if dist2 < 500.0 then
                    isSpawnable = false
                    break
                end
            end
            if isSpawnable then
                local vehicle = CreateVehicle(9, deliveryNpc[nearestDelivery].spawn[1], deliveryNpc[nearestDelivery].spawn[2], deliveryNpc[nearestDelivery].spawn[3], deliveryNpc[nearestDelivery].spawn[4])
                PlayerData[player].job_vehicle = vehicle
                CreateVehicleData(player, vehicle, 9)
                SetVehiclePropertyValue(vehicle, "locked", true, true)
                SetVehiclePropertyValue(vehicle, "garbage_bags", 0, true)
                PlayerData[player].job = "GARBAGE"
                AddVehicle(vehicle)
                AddPlayerToVehicleRestriction(vehicle, player)
                return
            end
        end
    elseif PlayerData[player].job == "GARBAGE" then
        if PlayerData[player].job_vehicle ~= nil then
                RemoveVehicle(PlayerData[player].job_vehicle)
                RemovePlayerFromVehicleRestriction(PlayerData[player].job_vehicle, player)
            DestroyVehicle(PlayerData[player].job_vehicle)
            DestroyVehicleData(PlayerData[player].job_vehicle)
            PlayerData[player].job_vehicle = nil
        end
        PlayerData[player].job = ""
        playerDelivery[player] = nil
        CallRemoteEvent(player, "ClientDestroyCurrentWaypoint")
    end
end)


AddRemoteEvent("OpenDeliveryMenuTemplate", function(player)
    if PlayerData[player].job == "GARBAGE" then
        CallRemoteEvent(player, "DeliveryMenuTemplate")
    end
end)


AddRemoteEvent("GarbageCollect", function(player, container)
    if player_data[player].job ~= "GARBAGE" then
        return
    end

    if garbage[container] == true then
        garbage[container] = false
        PlayerData[player].cash = PlayerData[player].cash + 40 --Cash reward for collecting
        CallRemoteEvent(player, "MakeNotification", _("trash_sucess", 40), "linear-gradient(to right, #00b09b, #96c93d)")

        Delay(600000, function()
            garbage[container] = true
        end)
        
    else
        AddPlayerChat(player, "This container is empty!")
    end
end)

function GetNearestDeliveryTemplate(player)
	local x, y, z = GetPlayerLocation(player)
	
	for k,v in pairs(GetAllNPC()) do
        local x2, y2, z2 = GetNPCLocation(v)
		local dist = GetDistance3D(x, y, z, x2, y2, z2)

		if dist < 250.0 then
			for k,i in pairs(deliveryNpc) do
				if v == i.npc then
					return k
				end
			end
		end
	end

	return 0
end
