local Open = false
local web_ui = CreateWebUI(0, 0, 0, 0, 4, 32);

LoadWebFile(web_ui, "http://asset/helpmenu/index.html");
SetWebAlignment(web_ui, 0.0, 0.0);
SetWebAnchors(web_ui, 0.0, 0.0, 1.0, 1.0);
SetWebVisibility(web_ui, WEB_HIDDEN)

function SetUIhidden(ui, visable)
	if visable == true then
		SetWebVisibility(ui, WEB_VISIBLE)
	else
		SetWebVisibility(web_ui, WEB_HIDDEN)
	end
end

AddRemoteEvent("openmenuremote", function()
	Open = not Open 
	SetUIhidden(web_ui, Open)
end)