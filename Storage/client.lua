local _ = function(k,...) return ImportPackage("i18n").t(GetPackageName(),k,...) end
local Dialog = ImportPackage("dialogui")

local StorageBoxMenu
local StorageBoxInventory

AddEvent("OnTranslationReady", function()
    StorageBoxMenu = Dialog.create("Vehicle", nil, _("trunk"), _("unflip"), _("unlock_lock"), _("keys"), _("cancel"))

    StorageBoxInventory = Dialog.create(_("vehicle_trunk"), nil, _("cancel"))
    Dialog.addSelect(StorageBoxInventory, 1, _("inventory"), 5)
    Dialog.addTextInput(StorageBoxInventory, 1, _("quantity"))
    Dialog.setButtons(StorageBoxInventory, 1, _("store"))
    Dialog.addSelect(StorageBoxInventory, 2, _("trunk"), 5)
    Dialog.addTextInput(StorageBoxInventory, 2, _("quantity"))
    Dialog.setButtons(StorageBoxInventory, 2, _("get"))
end)


function getNearestStorageBox()
    local x, y, z = GetPlayerLocation()
    
    for k,v in pairs(GetStreamedObjects()) do
        local x2, y2, z2 = GetObjectLocation(v)
        local dist = GetDistance3D(x, y, z, x2, y2, z2)

		if dist < 200 then
			return v
		end
    end
    return 0
end

function OnKeyPress(key)
    local nearestVehicle = getNearestVehicle()

    if key == "F1" and not onSpawn and not onCharacterCreation then
        if nearestVehicle ~= 0 then
            CallRemoteEvent("ServerVehicleMenu", nearestVehicle)
        end
    end
end
AddEvent("OnKeyPress", OnKeyPress)

AddRemoteEvent("OpenStorageBoxMenu", function()
    Dialog.show(vehicleMenu)
end)

AddRemoteEvent("OpenStorageBoxInventory", function(inventory, StorageBoxInventory)
    local inventoryitems = {}
	for k,v in pairs(inventory) do
		inventoryitems[k] = _(k).."["..v.."]"
	end
	local StorageBoxItems = {}
	for k,v in pairs(StorageBoxInventory) do
		StorageBoxItems[k] = _(k).."["..v.."]"
	end
	Dialog.setSelectLabeledOptions(StorageBoxInventory, 1, 1, inventoryitems)
	Dialog.setSelectLabeledOptions(StorageBoxInventory, 2, 1, StorageBoxItems)
    Dialog.show(StorageBoxInventory)
end)

AddEvent("OnDialogSubmit", function(dialog, button, ...)
    local args = { ... }
	if dialog == vehicleMenu then
		if button == 1 then
            CallRemoteEvent("OpenTrunk")
        end
        if button == 2 then
            CallRemoteEvent("UnflipVehicle")
        end
        if button == 3 then
            CallRemoteEvent("unlockVehicle")
        end
        if button == 4 then
            CallRemoteEvent("VehicleKeys")
        end
    end

    if dialog == vehicleInventory then
        if button == 1 then
			if args[1] == "" then
				MakeNotification(_("select_item"), "linear-gradient(to right, #ff5f6d, #ffc371)")
			else
				if args[2] == "" then
					MakeNotification(_("select_amount"), "linear-gradient(to right, #ff5f6d, #ffc371)")
				else
					CallRemoteEvent("VehicleStore", args[1], args[2])
				end
			end
		end
		if button == 2 then
			if args[3] == "" then
				MakeNotification(_("select_item"), "linear-gradient(to right, #ff5f6d, #ffc371)")
			else
				if args[4] == "" then
					MakeNotification(_("select_amount"), "linear-gradient(to right, #ff5f6d, #ffc371)")
				else
					CallRemoteEvent("VehicleUnstore", args[3], args[4])
				end
			end
		end
        CallRemoteEvent("CloseTrunk")
    end
end)

