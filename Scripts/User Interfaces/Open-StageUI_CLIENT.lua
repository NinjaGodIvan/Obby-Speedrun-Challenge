--Button
button = script.Parent
--Main Stage UI component
Main = button.Parent:FindFirstChild('Main')
--Player
player = game.Players.LocalPlayer
--Debouncer
debounce = false
--ReplicatedStorage
ReplicatedStorage = game.ReplicatedStorage
--Client to Client Communications Event
CLIENT_CLIENT = ReplicatedStorage:FindFirstChild('Client to Client')

--Automatically closes Stage UI when the player starts the obby
ReplicatedStorage:FindFirstChild('Auto Close Stage UI').OnClientEvent:Connect(function()
	Main.Visible = false
end)

--Opens or closes the UI
button.MouseButton1Click:Connect(function()
	
	if debounce then return end
	
	debounce = true
	
	if player['Is Performing Obby'].Value then --Player tries to open Stages UI while doing the obby
		
		--Tells server to communicate with other client to play sound effect (See 'Play Sound Effect' LocalScript for code)
		CLIENT_CLIENT:FireServer('Play Sound Effect', 'Error Sound')	
		--Gets server to communicate with other client to create message 
		CLIENT_CLIENT:FireServer('Display Message', {
			message = 'Unable to open Stages menu because you are currently doing the obby.',
			color = Color3.fromRGB(194, 0, 4),
			duration = 5
		})
		
	else
		CLIENT_CLIENT:FireServer('Play Sound Effect', 'Button Clicked')	
		if not Main.Visible then
			Main.Visible = true
		else
			Main.Visible = false
		end
	end
	
	debounce = false
end)