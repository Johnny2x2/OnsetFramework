
markerinside = 0
markeroutside = 0

AddEvent("OnPackageStart", function()
    markerinside = CreatePickup(334, 216569.641, 175567.078, 1305.324)
    markeroutside = CreatePickup(334, 216569.641, 175710.734, 1305.324)
end)

AddEvent("OnPlayerPickupHit", function(player, pickup)
    
    if pickup == markerinside then
        local x, y, z = GetPickupLocation(markeroutside)
        SetPlayerLocation(player, x, y+200, z)
    end
    if pickup == markeroutside then
        local x, y, z = GetPickupLocation(markerinside)
        SetPlayerLocation(player, x, y-200, z)
    end
end)
