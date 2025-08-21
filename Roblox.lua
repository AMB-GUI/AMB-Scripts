loadstring(game:HttpGet("https://raw.githubusercontent.com/AMB-GUI/AMB-Scripts/refs/heads/main/Games/Roblox.lua"))()

local AMBLoader = Instance.new("ScreenGui")
AMBLoader.Name = "AMB Loader"
AMBLoader.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
AMBLoader.Parent = game:GetService("CoreGui")
AMBLoader.ResetOnSpawn = false
AMBLoader.DisplayOrder = 999999
AMBLoader.IgnoreGuiInset = true

local frame = Instance.new("Frame")
frame.Name = "Frame"
frame.BackgroundColor3 = Color3.fromRGB(17, 18, 20)
frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
frame.BorderSizePixel = 0
frame.Position = UDim2.fromScale(0.0883, 0.11)
frame.Size = UDim2.fromOffset(878, 524)
frame.Parent = AMBLoader

-- Draggable
frame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		local dragStart = input.Position
		local frameStart = frame.Position

		local connection
		connection = game:GetService("UserInputService").InputChanged:Connect(function(inputChanged)
			if inputChanged.UserInputType == Enum.UserInputType.MouseMovement then
				local delta = inputChanged.Position - dragStart
				frame.Position = UDim2.new(
					frameStart.X.Scale,
					frameStart.X.Offset + delta.X,
					frameStart.Y.Scale,
					frameStart.Y.Offset + delta.Y
				)
			end
		end)

		local endConnection
		endConnection = game:GetService("UserInputService").InputEnded:Connect(function(inputEnded)
			if inputEnded.UserInputType == Enum.UserInputType.MouseButton1 then
				connection:Disconnect()
				endConnection:Disconnect()
			end
		end)
	end
end)

local uICorner = Instance.new("UICorner")
uICorner.CornerRadius = UDim.new(0, 25)
uICorner.Parent = frame

local logo = Instance.new("ImageLabel")
logo.Name = "Logo"
logo.BackgroundTransparency = 1
logo.BorderSizePixel = 0
logo.Image = "rbxassetid://92661965333918"
logo.Position = UDim2.fromScale(0.755, 0.2)
logo.AnchorPoint = Vector2.new(0.5, 0.5)
logo.Size = UDim2.fromOffset(175, 175)
logo.Parent = frame

-- Game Buttons
local function createGameButton(name, pos)
	local btn = Instance.new("Frame")
	btn.Name = name
	btn.BackgroundColor3 = Color3.fromRGB(17, 18, 20)
	btn.BackgroundTransparency = 0.9
	btn.BorderColor3 = Color3.fromRGB(0, 0, 0)
	btn.BorderSizePixel = 0
	btn.Position = pos
	btn.Size = UDim2.fromOffset(330, 65)
	btn.Parent = frame

	local stroke = Instance.new("UIStroke")
	stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	stroke.Color = Color3.fromRGB(26, 29, 37)
	stroke.Thickness = 1.9
	stroke.Parent = btn

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 25)
	corner.Parent = btn

	local label = Instance.new("TextLabel")
	label.BackgroundTransparency = 1
	label.Size = UDim2.fromOffset(197, 58)
	label.Position = UDim2.fromScale(0.2, 0.0462)
	label.Text = name
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.TextSize = 62
	label.TextWrapped = true
	label.Font = Enum.Font.Nunito
	label.Parent = btn

	return btn
end

local arsenal = createGameButton("Arsenal", UDim2.fromScale(0.03, 0.0415))
local planks = createGameButton("Planks", UDim2.fromScale(0.03, 0.188))
local rivals = createGameButton("Rivals", UDim2.fromScale(0.0289, 0.34))
local counterblox = createGameButton("Counterblox", UDim2.fromScale(0.0277, 0.489))
local gunfightArena = createGameButton("Gunfight Arena", UDim2.fromScale(0.03, 0.65))
local universal = createGameButton("Universal", UDim2.fromScale(0.0289, 0.806))

local selectedOption = nil

local textLabel6 = Instance.new("TextLabel")
textLabel6.Parent = frame
textLabel6.BackgroundTransparency = 1
textLabel6.Position = UDim2.fromScale(0.645, 0.447)
textLabel6.Size = UDim2.fromOffset(200, 50)
textLabel6.Text = "No Script Selected"
textLabel6.TextColor3 = Color3.fromRGB(255, 255, 255)
textLabel6.TextSize = 34

-- Discord
local discordLabel = Instance.new("TextLabel")
discordLabel.BackgroundTransparency = 1
discordLabel.Size = UDim2.fromOffset(300, 30)
discordLabel.Position = UDim2.fromScale(0.6, 0.95)
discordLabel.Text = "Join our school Discord: discord.gg/qhr"
discordLabel.TextColor3 = Color3.fromRGB(255,255,255)
discordLabel.TextSize = 20
discordLabel.Font = Enum.Font.Nunito
discordLabel.Parent = frame

-- Load Button
local loadbtn = Instance.new("TextButton")
loadbtn.Name = "Loadbtn"
loadbtn.BackgroundColor3 = Color3.fromRGB(27, 29, 37)
loadbtn.BorderSizePixel = 0
loadbtn.Position = UDim2.fromScale(0.527, 0.656)
loadbtn.Size = UDim2.fromOffset(405, 62)
loadbtn.Text = "Load"
loadbtn.TextColor3 = Color3.fromRGB(255, 255, 255)
loadbtn.TextScaled = true
loadbtn.Font = Enum.Font.Nunito
loadbtn.Parent = frame

local uICorner2 = Instance.new("UICorner")
uICorner2.CornerRadius = UDim.new(0, 25)
uICorner2.Parent = loadbtn

-- Close Button
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
closeButton.BackgroundTransparency = 1
closeButton.BorderSizePixel = 0
closeButton.Position = UDim2.fromScale(0.949, 0.0172)
closeButton.Size = UDim2.fromOffset(44, 41)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(58, 67, 98)
closeButton.TextScaled = true
closeButton.Font = Enum.Font.FredokaOne
closeButton.Parent = frame

closeButton.MouseButton1Click:Connect(function()
	AMBLoader:Destroy()
end)

-- Button Selection Logic
local function selectScript(scriptFrame, scriptName)
	selectedOption = scriptName
	textLabel6.Text = scriptName
end

arsenal.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		selectScript(arsenal, "Arsenal")
	end
end)

planks.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		selectScript(planks, "Planks")
	end
end)

rivals.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		selectScript(rivals, "Rivals")
	end
end)

counterblox.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		selectScript(counterblox, "Counterblox")
	end
end)

gunfightArena.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		selectScript(gunfightArena, "Gunfight Arena")
	end
end)

universal.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		selectScript(universal, "Universal")
	end
end)

-- Load scripts based on selection
loadbtn.MouseButton1Click:Connect(function()
	if selectedOption then
		if selectedOption == "Arsenal" then
			loadstring(game:HttpGet("https://raw.githubusercontent.com/AMB-GUI/AMB-Scripts/refs/heads/main/Games/AMB Arsenal.lua"))()
		elseif selectedOption == "Planks" then
			loadstring(game:HttpGet("https://raw.githubusercontent.com/AMB-GUI/AMB-Scripts/refs/heads/main/Games/AMB Planks.lua"))()
		elseif selectedOption == "Rivals" then
			loadstring(game:HttpGet("https://raw.githubusercontent.com/AMB-GUI/AMB-Scripts/refs/heads/main/Games/AMB Rivals.lua"))()
		elseif selectedOption == "Counterblox" then
			loadstring(game:HttpGet("https://raw.githubusercontent.com/AMB-GUI/AMB-Scripts/refs/heads/main/Games/AMB Counterblox.lua"))()
		elseif selectedOption == "Gunfight Arena" then
			loadstring(game:HttpGet("https://raw.githubusercontent.com/AMB-GUI/AMB-Scripts/refs/heads/main/Games/AMB Gunfight Arena.lua"))()
		elseif selectedOption == "Universal" then
			loadstring(game:HttpGet("https://raw.githubusercontent.com/AMB-GUI/AMB-Scripts/refs/heads/main/Games/AMB Universal.lua"))()
		end
	else
		textLabel6.Text = "Please select a script!"
		wait(2)
		textLabel6.Text = "No Script Selected"
	end
end)
