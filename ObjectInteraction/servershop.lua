local _ = function(k,...) return ImportPackage("i18n").t(GetPackageName(),k,...) end

fShopObjectsCached = { }
fShopTable = { 
    {
        items = { 
            CHAIR_02 = 512,
            CRATE_01 = 1544,
            BRIEFCASE_01 = 526

        },
        location = { 
            { -169529, -38594, 1146, 90 }
        },
        npc = {},
        spawn = { 
            { -169529, -38650, 1146, 90 }
        }   
    }
}


AddEvent("OnPackageStart", function()
    for k,v in pairs(fShopTable) do
        for i,j in pairs(v.location) do
            v.npc[i] = CreateNPC(v.location[i][1], v.location[i][2], v.location[i][3], v.location[i][4])
            CreateText3D(_("shop").."\n".._("press_e"), 18, v.location[i][1], v.location[i][2], v.location[i][3] + 120, 0, 0, 0)  
            table.insert(fShopObjectsCached, v.npc[i])
        end
	end
end)

AddEvent("OnPlayerJoin", function(player)
    CallRemoteEvent(player, "fshopSetup", fShopObjectsCached)
end)


AddRemoteEvent("fshopInteract", function(player, shopobject)
    local shop, npcid = GetfShopByObject(shopobject)

	if shop then
		local x, y, z = GetNPCLocation(shop.npc[npcid])
		local x2, y2, z2 = GetPlayerLocation(player)
        local dist = GetDistance3D(x, y, z, x2, y2, z2)

		if dist < 250 then
			for k,v in pairs(fShopTable) do
                if shopobject == v.npc[npcid] then
					CallRemoteEvent(player, "openfShop", v.items, v.npc[npcid])
				end
			end  			
		end
	end
end)


function GetfShopByObject(shopobject)
    for k,v in pairs(fShopTable) do
        for i,j in pairs(v.npc) do
            if j == shopobject then
                return v,i
            end
        end
	end
	return nil
end


function getfPrice(shop, item)
    for k,v in pairs(fShopTable) do
        for i,j in pairs(v.npc) do
            if j == shop then
                return v.items[item]
            end
        end
    end
    return 0
end


AddRemoteEvent("fShopBuy", function(player, shopid, item) 
    local price = getfPrice(shopid, item)

    if PlayerData[player].cash < price then
        CallRemoteEvent(player, "MakeNotification", _("not_enought_cash"), "linear-gradient(to right, #ff5f6d, #ffc371)")
    else
        PlayerData[player].cash = PlayerData[player].cash - price
        CallRemoteEvent(player, "MakeNotification", _("shop_success_buy", _(item), price, _("currency")), "linear-gradient(to right, #00b09b, #96c93d)")
        
        if item == "CHAIR_02" then
        	local object = CreateInteractiveObject(player, 512, -169529, -38300, 1146)
        end
        
        if item == "BRIEFCASE_01" then 
            local object = CreateInteractiveObject(player, 526 -169529, -38300, 1146)
        end
    end
end)

AddEvent("OnNPCDamage", function(npc)
    SetNPCHealth( npc, 100 )
end)