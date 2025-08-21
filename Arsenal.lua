-- AMB Arsenal Script
local gameName = "Aresnal"

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- Settings
local ESPColor = Color3.fromRGB(140, 155, 208)
local AimbotKey = Enum.KeyCode.E
local ShowESP = true
local ShowHealthBars = true

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AMB_Arsenal_GUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = game:GetService("CoreGui")

-- Main Frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 350, 0, 400)
frame.Position = UDim2.new(0.02,0,0.2,0)
frame.BackgroundColor3 = Color3.fromRGB(17,18,20)
frame.BorderSizePixel = 0
frame.Parent = screenGui

local uicorner = Instance.new("UICorner")
uicorner.CornerRadius = UDim.new(0,25)
uicorner.Parent = frame

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,50)
title.BackgroundTransparency = 1
title.Text = "AMB Arsenal"
title.Font = Enum.Font.FredokaOne
title.TextColor3 = Color3.fromRGB(255,255,255)
title.TextScaled = true
title.Parent = frame

-- Toggle GUI key
local guiVisible = true
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.RightShift then
        guiVisible = not guiVisible
        frame.Visible = guiVisible
    end
end)

-- ESP Setup
local function createESPBox(player)
    local box = Instance.new("BoxHandleAdornment")
    box.Name = "ESPBox"
    box.Adornee = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    box.AlwaysOnTop = true
    box.ZIndex = 10
    box.Size = Vector3.new(4,6,1)
    box.Color3 = ESPColor
    box.Transparency = 0.5
    box.Parent = workspace
    return box
end

local function createHealthBar(player)
    local hb = Instance.new("BillboardGui")
    hb.Size = UDim2.new(0,60,0,10)
    hb.StudsOffset = Vector3.new(0,3,0)
    hb.Adornee = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    hb.AlwaysOnTop = true
    hb.Parent = player.Character and player.Character:FindFirstChild("HumanoidRootPart") or workspace

    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(1,0,1,0)
    bar.BackgroundColor3 = Color3.fromRGB(255,0,0)
    bar.BorderSizePixel = 0
    bar.Parent = hb

    return {Gui = hb, Bar = bar}
end

-- Track ESP and HealthBars
local ESPs = {}
local HealthBars = {}

RunService.RenderStepped:Connect(function()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            if ShowESP then
                if not ESPs[player] then
                    ESPs[player] = createESPBox(player)
                end
            else
                if ESPs[player] then
                    ESPs[player]:Destroy()
                    ESPs[player] = nil
                end
            end

            if ShowHealthBars then
                if not HealthBars[player] then
                    HealthBars[player] = createHealthBar(player)
                end
                local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                if humanoid and HealthBars[player] then
                    HealthBars[player].Bar.Size = UDim2.new(humanoid.Health/humanoid.MaxHealth,0,1,0)
                end
            else
                if HealthBars[player] then
                    HealthBars[player].Gui:Destroy()
                    HealthBars[player] = nil
                end
            end
        end
    end
end)

-- Aimbot
local aimbotEnabled = false
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == AimbotKey then
        aimbotEnabled = not aimbotEnabled
    end
end)

RunService.RenderStepped:Connect(function()
    if aimbotEnabled then
        local closestDist = math.huge
        local target
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local dist = (player.Character.HumanoidRootPart.Position - workspace.CurrentCamera.CFrame.Position).Magnitude
                if dist < closestDist then
                    closestDist = dist
                    target = player
                end
            end
        end
        if target and target.Character then
            workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, target.Character.HumanoidRootPart.Position)
        end
    end
end)

-- Color GUI
local function changeColor(newColor)
    ESPColor = newColor
    for _, box in pairs(ESPs) do
        box.Color3 = newColor
    end
end

