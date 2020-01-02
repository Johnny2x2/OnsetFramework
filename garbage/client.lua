local Dialog = ImportPackage("dialogui")
local _ = function(k,...) return ImportPackage("i18n").t(GetPackageName(),k,...) end

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

local deliveryNPC
local deliveryNpcMenu
local deliveryMenu

AddRemoteEvent("SetupDeliveryTemplate", function(deliverynpc) 
    deliveryNPC = deliverynpc
end)

AddEvent("OnTranslationReady", function()
    deliveryNpcMenu = Dialog.create(_("delivery_menu"), nil, _("start_stop_delivery") ,_("cancel"))
end)

AddEvent("OnKeyPress", function( key )

    if key == "E" and not onSpawn and not onCharacterCreation then
        local NearestDelivery = GetNearestDeliveryTemplate()
        if NearestDelivery ~= 0 then
            Dialog.show(deliveryNpcMenu)
		end
    end

    if key == "F3" and not onSpawn and not onCharacterCreation then
        CallRemoteEvent("OpenDeliveryMenuTemplate")
    end

    if key == "G" then
        local px, py, pz = GetPlayerLocation()
        for i=1,#garbage do
            if GetDistance3D(px, py, pz, garbage[i][1], garbage[i][2], garbage[i][3]) < 100 then
                CallRemoteEvent("GarbageCollect", i)
                return
            end
        end
    end

end)


AddEvent("OnDialogSubmit", function(dialog, button, ...)
	if dialog == deliveryNpcMenu then
		if button == 1 then
            CallRemoteEvent("StartStopDeliveryTemplate")
        end
    end
    if dialog == deliveryMenu then
        if button == 1 then
            CallRemoteEvent("NextDeliveryTemplate")
        end
        if button == 2 then
            CallRemoteEvent("FinishDeliveryTemplate")
        end
    end
end)

AddRemoteEvent("DeliveryMenuTemplate", function()
    Dialog.show(deliveryMenu)
end)


function GetNearestDeliveryTemplate()
	local x, y, z = GetPlayerLocation()
	
	for k,v in pairs(GetStreamedNPC()) do
        local x2, y2, z2 = GetNPCLocation(v)
		local dist = GetDistance3D(x, y, z, x2, y2, z2)

		if dist < 250.0 then
			for k,i in pairs(deliveryNPC) do
				if v == i then
					return v
				end
			end
		end
	end

	return 0
end