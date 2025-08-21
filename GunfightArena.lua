-- Gunfight Arena Game Script
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local ESPColor = Color3.fromRGB(255,0,255)
local ShowESP = true
local ShowHealth = true
local AimbotEnabled = false
local AimKey = Enum.KeyCode.RightShift

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GunfightArenaGUI"
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

local function createESP(player)
    if player == LocalPlayer then return end
    if not player.Character then return end
    local root = player.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    if root:FindFirstChild("ESPBox") then return end

    local box = Instance.new("BoxHandleAdornment")
    box.Name = "ESPBox"
    box.Adornee = root
    box.Size = Vector3.new(2,4,1)
    box.Color3 = ESPColor
    box.AlwaysOnTop = true
    box.ZIndex = 10
    box.Parent = root

    local healthBar = Instance.new("BillboardGui")
    healthBar.Name = "HealthBar"
    healthBar.Size = UDim2.new(0,10,0,40)
    healthBar.Adornee = root
    healthBar.StudsOffset = Vector3.new(2,0,0)
    healthBar.AlwaysOnTop = true
    healthBar.Parent = root

    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(1,0,1,0)
    bar.BackgroundColor3 = Color3.fromRGB(0,255,0)
    bar.Parent = healthBar
end

RunService.RenderStepped:Connect(function()
    if not ShowESP then return end
    for _,player in pairs(Players:GetPlayers()) do
        createESP(player)
    end
end)

local mouse = LocalPlayer:GetMouse()
mouse.KeyDown:Connect(function(key)
    if key == AimKey.Name:lower() and AimbotEnabled then
        print("Aimbot triggered on Gunfight Arena!")
    end
end)
