local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local roles

game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "Wyatt's MM2 ESP",
	Text = "Hey! Hope you enjoy the script!"
})

function CreateHighlight()
	for _, player in pairs(Players:GetChildren()) do
		if player ~= LP and player.Character and not player.Character:FindFirstChild("Highlight") then
			Instance.new("Highlight", player.Character)
		end
	end
end


local ColorLookup = {
    Sheriff = Color3.fromRGB(0, 0, 225),
    Murder = Color3.fromRGB(225, 0, 0),
    Hero = Color3.fromRGB(255, 250, 0),
    Default = Color3.fromRGB(0, 225, 0)
}

function UpdateHighlights()
    for _, player in pairs(Players:GetChildren()) do
        if player ~= LP and player.Character and player.Character:FindFirstChild("Highlight") then
            local Highlight = player.Character:FindFirstChild("Highlight")
            UpdateHighlightColor(Highlight, player)
        end
    end
end

function UpdateHighlightColor(Highlight, player)
    if player.Name == Sheriff and IsAlive(player) then
        Highlight.FillColor = ColorLookup.Sheriff
    elseif player.Name == Murder and IsAlive(player) then
        Highlight.FillColor = ColorLookup.Murder
    elseif player.Name == Hero and IsAlive(player) and not IsAlive(game.Players[Sheriff]) then
        Highlight.FillColor = ColorLookup.Hero
    else
        Highlight.FillColor = ColorLookup.Default
    end
end

function IsAlive(Player)
	for _, is in pairs(roles) do
		if Player.Name == _ then
			if is.Killed or is.Dead then
				return false
			else
				return true
			end
		end
	end
end

RunService.RenderStepped:connect(function()
	roles = ReplicatedStorage:FindFirstChild("GetPlayerData", true):InvokeServer()
	for _, playerInfo in pairs(roles) do
		if playerInfo.Role == "Murderer" then
			Murder = _
		elseif playerInfo.Role == 'Sheriff' then
			Sheriff = _
		elseif playerInfo.Role == 'Hero' then
			Hero = _
		end
	end
	CreateHighlight()
	UpdateHighlights()
end)