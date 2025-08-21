-- Arsenal Game Script
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Settings
local ESPColor = Color3.fromRGB(255,0,0)
local ShowESP = true
local ShowHealth = true
local AimbotEnabled = false
local AimKey = Enum.KeyCode.RightShift

-- Create GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ArsenalGUI"
ScreenGui.Parent = game:GetService("CoreGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.fromOffset(250,150)
Frame.Position = UDim2.fromScale(0.8,0.1)
Frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
Frame.Parent = ScreenGui

local AimbotToggle = Instance.new("TextButton")
AimbotToggle.Size = UDim2.fromOffset(200,40)
AimbotToggle.Position = UDim2.fromScale(0.05,0.1)
AimbotToggle.Text = "Aimbot: OFF"
AimbotToggle.Parent = Frame

AimbotToggle.MouseButton1Click:Connect(function()
    AimbotEnabled = not AimbotEnabled
    AimbotToggle.Text = "Aimbot: "..(AimbotEnabled and "ON" or "OFF")
end)

-- ESP Function
local function createESP(player)
    if player == LocalPlayer then return end
    local box = Instance.new("BoxHandleAdornment")
    box.Adornee = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    box.Size = Vector3.new(2,4,1)
    box.Color3 = ESPColor
    box.AlwaysOnTop = true
    box.ZIndex = 10
    box.Parent = workspace

    local healthBar = Instance.new("BillboardGui")
    healthBar.Size = UDim2.new(0,50,0,5)
    healthBar.Adornee = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    healthBar.StudsOffset = Vector3.new(2,2,0)
    healthBar.AlwaysOnTop = true
    healthBar.Parent = player.Character or workspace

    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(1,0,1,0)
    bar.BackgroundColor3 = Color3.fromRGB(0,255,0)
    bar.Parent = healthBar
end

-- Run ESP
RunService.RenderStepped:Connect(function()
    if not ShowESP then return end
    for _,player in pairs(Players:GetPlayers()) do
        if player.Character and not player.Character:FindFirstChild("ESPBox") then
            createESP(player)
        end
    end
end)

-- Aimbot placeholder
local mouse = LocalPlayer:GetMouse()
mouse.KeyDown:Connect(function(key)
    if key == AimKey.Name:lower() then
        if AimbotEnabled then
            print("Aimbot triggered!") -- placeholder for aiming function
        end
    end
end)
