local Open = false
local web_ui = CreateWebUI(0, 0, 0, 0, 4, 32);

LoadWebFile(web_ui, "http://asset/openmap/index.html");
SetWebAlignment(web_ui, 0.0, 0.0);
SetWebAnchors(web_ui, 0.0, 0.0, 1.0, 1.0);
SetWebVisibility(web_ui, WEB_HIDDEN)

function OnKeyPress(key)
	if key == "M" then
		if Open == false then
			SetWebVisibility(web_ui, WEB_VISIBLE)
		Open = true
	else
		SetWebVisibility(web_ui, WEB_HIDDEN)
		Open = false
		end
			
	end
end
AddEvent("OnKeyPress", OnKeyPress)