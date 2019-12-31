function CreateExplodingBarrel(player)
    local x, y, z = GetPlayerLocation(player) 
    ExplodingBarrel = CreateObject(501, x, y, z)
    SetObjectPropertyValue(ExplodingBarrel, "Explosive", true, true)
    SetObjectPropertyValue(ExplodingBarrel, "HITS", 3, true)
end
AddCommand("explosive", CreateExplodingBarrel)

AddEvent("OnPlayerWeaponShot", function(player, weapon, hittype, hitid) 
    if hittype == HIT_OBJECT then
        if GetObjectPropertyValue(hitid, "Explosive") ~= nil then
            if GetObjectPropertyValue(hitid, "Explosive") == true then
                if GetObjectPropertyValue(hitid,"HITS") == 0 then
                    local x, y, z = GetObjectLocation(hitid)
                    DestroyObject(hitid)
                    CreateExplosion(9, x, y, z, true, 1500.0, 1000000.0)   
                else
                    local val = GetObjectPropertyValue(hitid,"HITS")
                    val = val - 1
                    SetObjectPropertyValue(hitid, "HITS", val, true)                   
                end
            end
        end
    end                 
	print("OnPlayerWeaponShot --> player = "..player.. "  - weapon = " ..weapon.. " - hittype = " ..hittype.. " - hitid = " ..hitid)
end)

