local Dialog = ImportPackage("dialogui")
local _ = function(k,...) return ImportPackage("i18n").t(GetPackageName(),k,...) end

local personalMenu

AddEvent("OnTranslationReady", function()
    personalMenu = Dialog.create(_("personal_menu"), _("bank_balance").." : {bank} ".._("currency").." | ".._("cash").." : {cash} ".._("currency"), _("transfer") ,_("use"), _("cancel"))
    Dialog.addSelect(personalMenu, 1, _("inventory"), 5)
    Dialog.addTextInput(personalMenu, 1, _("quantity"))
    Dialog.addSelect(personalMenu, 1, _("player"), 3)
end)


AddRemoteEvent("OpenPersonalMenu", function(cash, bank, inventory, playerList)
    Dialog.setVariable(personalMenu, "cash", cash)
    Dialog.setVariable(personalMenu, "bank", bank)
    local items = {}
	for k,v in pairs(inventory) do
		items[k] = _(k).."["..v.."]"
    end
    Dialog.setSelectLabeledOptions(personalMenu, 1, 1, items)
    Dialog.setSelectLabeledOptions(personalMenu, 1, 3, playerList)
    Dialog.show(personalMenu)
end)

AddEvent("OnDialogSubmit", function(dialog, button, ...)
	local args = { ... }
    if dialog == personalMenu then
        if button == 1 then
            if args[1] == "" then
				MakeNotification(_("select_item"), "linear-gradient(to right, #ff5f6d, #ffc371)")
			else
				if args[2] == ""  or math.floor(args[2]) < 1 then
					MakeNotification(_("select_amount"), "linear-gradient(to right, #ff5f6d, #ffc371)")
                else
                    if args[3] == "" then
                        MakeNotification(_("select_player"), "linear-gradient(to right, #ff5f6d, #ffc371)")
                    else
                        CallRemoteEvent("TransferInventory", args[1], math.floor(args[2]), args[3])
                    end   
				end
			end
        end
		if button == 2 then
			if args[1] == "" then
				MakeNotification(_("select_item"), "linear-gradient(to right, #ff5f6d, #ffc371)")
			else
				if args[2] == ""  or math.floor(args[2]) < 1 then
					MakeNotification(_("select_amount"), "linear-gradient(to right, #ff5f6d, #ffc371)")
				else
                    CallRemoteEvent("UseInventory", args[1], math.floor(args[2]))
				end
			end
		end
    end
end)


AddEvent("OnKeyPress", function( key )
    if key == "F4" and not onSpawn and not onCharacterCreation then
        CallRemoteEvent("ServerPersonalMenu")
    end
end)

AddRemoteEvent("LockControlMove", function(move)
    SetIgnoreMoveInput(move)
end)


AddRemoteEvent("GetHigh", function()

    SetPostEffect("ImageEffects", "VignetteIntensity", 1.0)
    SetPostEffect("Chromatic", "Intensity", 5.0)
    SetPostEffect("Chromatic", "StartOffset", 0.1)
    SetPostEffect("MotionBlur", "Amount", 0.05)
    SetPostEffect("MotionWhiteBalanceBlur", "Temp", 7000)
    SetCameraShakeRotation(0.0, 0.0, 1.0, 10.0, 0.0, 0.0)
    SetCameraShakeFOV(5.0, 5.0)
    PlayCameraShake(100000.0, 2.0, 1.0, 1.1)
    Delay(5000, function()
        DrunkOn = false
		SetPostEffect("ImageEffects", "VignetteIntensity", 0.25)
		SetPostEffect("Chromatic", "Intensity", 0.0)
		SetPostEffect("Chromatic", "StartOffset", 0.0)
		SetPostEffect("MotionBlur", "Amount", 0.0)
		SetPostEffect("MotionWhiteBalanceBlur", "Temp", 6500)
		StopCameraShake(false)
    end)
end)

