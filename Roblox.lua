-- AMB Loader GUI
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Main GUI
local AMBLoader = Instance.new("ScreenGui")
AMBLoader.Name = "AMB Loader"
AMBLoader.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
AMBLoader.Parent = game:GetService("CoreGui")
AMBLoader.ResetOnSpawn = false
AMBLoader.DisplayOrder = 999999
AMBLoader.IgnoreGuiInset = true

-- Main Frame
local frame = Instance.new("Frame")
frame.Name = "Frame"
frame.BackgroundColor3 = Color3.fromRGB(17, 18, 20)
frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
frame.BorderSizePixel = 0
frame.Position = UDim2.fromScale(0.0883, 0.11)
frame.Size = UDim2.fromOffset(878, 524)
frame.Parent = AMBLoader

-- Rounded corners
local uICorner = Instance.new("UICorner")
uICorner.CornerRadius = UDim.new(0, 25)
uICorner.Parent = frame

-- Draggable functionality
do
    local dragging = false
    local dragInput, mousePos, framePos

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            mousePos = input.Position
            framePos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            frame.Position = UDim2.new(
                framePos.X.Scale,
                framePos.X.Offset + delta.X,
                framePos.Y.Scale,
                framePos.Y.Offset + delta.Y
            )
        end
    end)
end

-- GUI Toggle with RightShift
local guiVisible = true
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.RightShift then
        guiVisible = not guiVisible
        frame.Visible = guiVisible
    end
end)

-- Logo
local logo = Instance.new("ImageLabel")
logo.Name = "Logo"
logo.BackgroundTransparency = 1
logo.BorderSizePixel = 0
logo.Image = "rbxassetid://92661965333918"
logo.Position = UDim2.fromScale(0.755, 0.2)
logo.AnchorPoint = Vector2.new(0.5, 0.5)
logo.Size = UDim2.fromOffset(175, 175)
logo.Parent = frame

-- Helper to create game buttons
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

-- Game Buttons
local arsenal = createGameButton("Arsenal", UDim2.fromScale(0.03, 0.0415))
local planks = createGameButton("Planks", UDim2.fromScale(0.03, 0.188))
local rivals = createGameButton("Rivals", UDim2.fromScale(0.0289, 0.34))
local counterblox = createGameButton("Counterblox", UDim2.fromScale(0.0277, 0.489))
local gunfightArena = createGameButton("Gunfight Arena", UDim2.fromScale(0.03, 0.65))
local universal = createGameButton("Universal", UDim2.fromScale(0.0289, 0.806))

-- Selected Script
local selectedOption = nil
local function selectScript(btn, name)
    selectedOption = name
end

-- Connect buttons to selection
for _, btn in pairs({arsenal, planks, rivals, counterblox, gunfightArena, universal}) do
    btn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            selectScript(btn, btn.Name)
        end
    end)
end

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

-- Discord Label
local discordLabel = Instance.new("TextLabel")
discordLabel.BackgroundTransparency = 1
discordLabel.Size = UDim2.fromOffset(300, 30)
discordLabel.Position = UDim2.fromScale(0.6, 0.95)
discordLabel.Text = "Join our school Discord: discord.gg/qhr"
discordLabel.TextColor3 = Color3.fromRGB(255,255,255)
discordLabel.TextSize = 20
discordLabel.Font = Enum.Font.Nunito
discordLabel.Parent = frame

-- Load Button Logic (replace with your own GitHub URLs)
loadbtn.MouseButton1Click:Connect(function()
    if selectedOption then
        if selectedOption == "Arsenal" then
            loadstring(game:HttpGet("YOUR_RAW_GITHUB_URL_HERE"))()
        elseif selectedOption == "Planks" then
            loadstring(game:HttpGet("YOUR_RAW_GITHUB_URL_HERE"))()
        elseif selectedOption == "Rivals" then
            loadstring(game:HttpGet("YOUR_RAW_GITHUB_URL_HERE"))()
        elseif selectedOption == "Counterblox" then
            loadstring(game:HttpGet("YOUR_RAW_GITHUB_URL_HERE"))()
        elseif selectedOption == "Gunfight Arena" then
            loadstring(game:HttpGet("YOUR_RAW_GITHUB_URL_HERE"))()
        elseif selectedOption == "Universal" then
            loadstring(game:HttpGet("YOUR_RAW_GITHUB_URL_HERE"))()
        end
    else
        warn("Please select a script!")
    end
end)
