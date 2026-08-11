local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local flying = false
local speed = 50
local flyConnection

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "FlyGUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.fromOffset(240, 190)
frame.Position = UDim2.new(0.5, -120, 0.5, -95)
frame.Parent = gui

local flyButton = Instance.new("TextButton")
flyButton.Size = UDim2.fromOffset(200, 45)
flyButton.Position = UDim2.fromOffset(20, 15)
flyButton.Text = "FLY: OFF"
flyButton.Parent = frame

local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.fromOffset(200, 30)
speedLabel.Position = UDim2.fromOffset(20, 65)
speedLabel.Text = "Speed: " .. speed
speedLabel.Parent = frame

local plusButton = Instance.new("TextButton")
plusButton.Size = UDim2.fromOffset(95, 45)
plusButton.Position = UDim2.fromOffset(20, 105)
plusButton.Text = "Speed +"
plusButton.Parent = frame

local minusButton = Instance.new("TextButton")
minusButton.Size = UDim2.fromOffset(95, 45)
minusButton.Position = UDim2.fromOffset(125, 105)
minusButton.Text = "Speed -"
minusButton.Parent = frame

-- Fly
local function toggleFly()
    flying = not flying
    flyButton.Text = flying and "FLY: ON" or "FLY: OFF"

    if flyConnection then
        flyConnection:Disconnect()
        flyConnection = nil
    end

    if flying then
        flyConnection = RunService.RenderStepped:Connect(function()
            local character = player.Character
            local root = character and character:FindFirstChild("HumanoidRootPart")

            if root then
                local camera = workspace.CurrentCamera
                root.AssemblyLinearVelocity =
                    camera.CFrame.LookVector * speed
            end
        end)
    end
end

-- Nút Fly
flyButton.MouseButton1Click:Connect(toggleFly)

-- Tăng Speed
plusButton.MouseButton1Click:Connect(function()
    speed += 10
    speedLabel.Text = "Speed: " .. speed
end)

-- Giảm Speed
minusButton.MouseButton1Click:Connect(function()
    speed = math.max(10, speed - 10)
    speedLabel.Text = "Speed: " .. speed
end)
