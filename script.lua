local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local flying = false
local flySpeed = 50

local ScreenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
local flyButton = Instance.new("TextButton")

-- Настройка кнопки
flyButton.Size = UDim2.new(0, 200, 0, 100) -- Размер кнопки
flyButton.Position = UDim2.new(0.5, -100, 0.5, -50) -- Позиция кнопки (центр)
flyButton.Text = "Fly" -- Текст на кнопке
flyButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255) -- Цвет фона
flyButton.TextColor3 = Color3.fromRGB(255, 255, 255) -- Цвет текста
flyButton.Parent = ScreenGui -- Добавляем кнопку в GUI

local bodyVelocity = Instance.new("BodyVelocity")
bodyVelocity.Velocity = Vector3.new(0, 0, 0)
bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)

local function startFlying()
    flying = true
    bodyVelocity.Parent = character.HumanoidRootPart

    while flying do
        local camera = workspace.CurrentCamera
        local direction = camera.CFrame.LookVector
        bodyVelocity.Velocity = (direction * flySpeed) + Vector3.new(0, 20, 0)
        wait(0.1)
    end
    bodyVelocity.Parent = nil
end

local function stopFlying()
    flying = false
end

-- Обработчик нажатия на кнопку
flyButton.MouseButton1Click:Connect(function()
    if not flying then
        startFlying()
        flyButton.Text = "Stop Flying" -- Изменяем текст на кнопке
    else
        stopFlying()
        flyButton.Text = "Fly" -- Возвращаем текст на кнопке
    end
end)
