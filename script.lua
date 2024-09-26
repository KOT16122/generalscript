local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local flying = false
local speed = 50

local bodyVelocity = Instance.new("BodyVelocity")
bodyVelocity.Velocity = Vector3.new(0, 0, 0)
bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)

local function fly()
    flying = true
    bodyVelocity.Parent = character.HumanoidRootPart

    while flying do
        local camera = workspace.CurrentCamera
        local direction = camera.CFrame.LookVector

        bodyVelocity.Velocity = direction * speed + Vector3.new(0, 20, 0)
        wait(0.1)
    end

    bodyVelocity.Parent = nil
end

local function stopFlying()
    flying = false
end

-- Привязываем функции к клавишам
game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.F then
        if not flying then
            fly()
        else
            stopFlying()
        end
    end
end)
