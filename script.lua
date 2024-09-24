-- Получаем сервисы игры
local player = game:GetService("Players").LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

-- Функция для поиска всех дверей в игре
local function findDoors()
    local doors = {}
    for _, obj in pairs(game:GetDescendants()) do
        if obj:IsA("Model") and obj.Name == "Door" then
            table.insert(doors, obj)
        end
    end
    return doors
end

-- Функция для расчета расстояния до двери
local function calculateDistance(door)
    return (humanoidRootPart.Position - door.PrimaryPart.Position).Magnitude
end

-- Функция для нахождения правильной двери (в данном случае выбираем ближайшую)
local function findCorrectDoor(doors)
    local correctDoor = nil
    local minDistance = math.huge

    for _, door in pairs(doors) do
        local distance = calculateDistance(door)
        if distance < minDistance then
            minDistance = distance
            correctDoor = door
        end
    end

    return correctDoor, minDistance
end

-- Функция для отображения информации на экране
local function displayDoorInfo(door, distance)
    -- Очищаем предыдущие GUI объекты
    if player.PlayerGui:FindFirstChild("DoorInfo") then
        player.PlayerGui:FindFirstChild("DoorInfo"):Destroy()
    end

    -- Создаем экранный интерфейс
    local screenGui = Instance.new("ScreenGui", player.PlayerGui)
    screenGui.Name = "DoorInfo"

    local infoLabel = Instance.new("TextLabel", screenGui)
    infoLabel.Size = UDim2.new(0, 300, 0, 100)
    infoLabel.Position = UDim2.new(0.5, -150, 0.1, 0)
    infoLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    infoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    infoLabel.Font = Enum.Font.SourceSans
    infoLabel.TextSize = 24
    infoLabel.Text = "Правильная дверь: " .. door.Name .. "\nРасстояние: " .. math.floor(distance) .. " метров"
end

-- Основная логика
local doors = findDoors()
if #doors > 0 then
    local correctDoor, distance = findCorrectDoor(doors)
    if correctDoor then
        displayDoorInfo(correctDoor, distance)
    end
else
    warn("Двери не найдены!")
end
