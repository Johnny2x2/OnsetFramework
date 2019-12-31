
function OnPackageStart()

    local res = LoadPak("chickplayer", "/chickplayer/", "../../../OnsetModding/Plugins/chickplayer/Content/")
    AddPlayerChat("Loading of chickplayer: "..tostring(res))
	
end
AddEvent("OnPackageStart", OnPackageStart)

PlayerSpawnedObjects= { }

AddEvent("OnPlayerSpawn", function()
    --local SkeletalMeshComponent = GetPlayerSkeletalMeshComponent(GetPlayerId(), "Body")
		--SkeletalMeshComponent:SetSkeletalMesh(USkeletalMesh.LoadFromAsset("/chickplayer/Chara_physics"))
end)



