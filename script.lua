local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- Функция для выделения двери зеленым цветом
local function highlightDoor(door)
    local highlight = Instance.new("Highlight")  -- Создаем новый объект Highlight
    highlight.Adornee = door  -- Указываем, на что будет действовать Highlight
    highlight.FillColor = Color3.new(0, 1, 0)  -- Зеленый цвет
    highlight.FillTransparency = 0.5  -- Прозрачность
    highlight.Parent = door  -- Добавляем Highlight к двери
end

-- Функция для поиска и выделения всех дверей
local function findDoors()
    while true do
        for _, obj in pairs(workspace:GetChildren()) do
            if obj:IsA("Part") and obj.Name == "Door" then
                highlightDoor(obj)  -- Выделяем дверь
            end
        end
        wait(1)  -- Пауза между проверками
    end
end

-- Запускаем поиск дверей
findDoors()
