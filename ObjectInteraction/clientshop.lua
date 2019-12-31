local Dialog = ImportPackage("dialogui")
Dialog.setGlobalTheme("flat")

local _ = function(k,...) return ImportPackage("i18n").t(GetPackageName(),k,...) end

local fshop
local fShopIds = { }

local lastfShop

AddEvent("OnTranslationReady", function()
    fshop = Dialog.create(_("shop"), nil, _("cancel"))
    Dialog.addSelect(fshop, 1, _("shop"), 5)
    Dialog.setButtons(fshop, 1, _("buy"))
end)

AddRemoteEvent("fshopSetup", function(ShopObject)
    fShopIds = ShopObject
end)

function OnKeyPress(key)
    if key == "E" and not onSpawn and not onCharacterCreation then
		local NearestShop = GetNearestfShop()
		AddPlayerChat(NearestShop)
		
        if NearestShop ~= 0 then
            CallRemoteEvent("fshopInteract", NearestShop)
		end
	end
end
AddEvent("OnKeyPress", OnKeyPress)

AddEvent("OnDialogSubmit", function(dialog, button, ...)
	local args = { ... }
	if dialog == fshop then
		if button == 1 then
			if args[1] == "" then
				MakeNotification(_("select_item"), "linear-gradient(to right, #ff5f6d, #ffc371)")
			else
				CallRemoteEvent("fShopBuy", lastfShop, args[1])
			end
		end
    end
end)


function GetNearestfShop()
	local x, y, z = GetPlayerLocation()
	
	for k,v in pairs(GetStreamedNPC()) do
        local x2, y2, z2 = GetNPCLocation(v)
		local dist = GetDistance3D(x, y, z, x2, y2, z2)

		if dist < 250.0 then
			for k,i in pairs(fShopIds) do
				if v == i then
					return v
				end
			end
		end
	end

	return 0
end

AddRemoteEvent("openfShop", function(items, shopid)
    lastfShop = shopid

	local shopitems = {}
	for k,v in pairs(items) do
		shopitems[k] = _(k).."["..v.._("currency").."]"
	end
	Dialog.setSelectLabeledOptions(fshop, 1, 1, shopitems)
	Dialog.show(fshop)
end)