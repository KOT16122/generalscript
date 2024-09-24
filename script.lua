-- Получаем локального игрока
local player = game:GetService("Players").LocalPlayer

-- Получаем персонажа игрока
local character = player.Character or player.CharacterAdded:Wait()

-- Изменяем скорость ходьбы
local humanoid = character:FindFirstChild("Humanoid")
if humanoid then
    humanoid.WalkSpeed = 100  -- Увеличиваем скорость ходьбы до 100
end

-- Выводим сообщение в консоль
print("Скорость игрока изменена на 100")