local httpService = game:GetService("HttpService")
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Замените на ваш URL для проверки ключа
local KEY_CHECK_URL = "https://997b-87-117-51-159.ngrok-free.app/check-key"
local MAIN_SCRIPT_URL = "https://raw.githubusercontent.com/KOT16122/generalscript/main/script.lua"  -- Замените на URL основного скрипта

-- Создание GUI
local screenGui = Instance.new("ScreenGui", playerGui)
local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0.5, 0, 0.5, 0)
frame.Position = UDim2.new(0.25, 0, 0.25, 0)
frame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)

local keyInput = Instance.new("TextBox", frame)
keyInput.Size = UDim2.new(0.8, 0, 0.2, 0)
keyInput.Position = UDim2.new(0.1, 0, 0.2, 0)
keyInput.BackgroundColor3 = Color3.new(1, 1, 1)
keyInput.PlaceholderText = "Введите ваш ключ"

local checkButton = Instance.new("TextButton", frame)
checkButton.Size = UDim2.new(0.5, 0, 0.2, 0)
checkButton.Position = UDim2.new(0.25, 0, 0.5, 0)
checkButton.BackgroundColor3 = Color3.new(0, 0.5, 0)
checkButton.Text = "Проверить ключ"

-- Функция для проверки ключа
local function checkKey(key)
    local success, response = pcall(function()
        return httpService:PostAsync(KEY_CHECK_URL, httpService:JSONEncode({key = key}), Enum.HttpContentType.ApplicationJson)
    end)

    if success then
        local data = httpService:JSONDecode(response)
        return data.status == "success"
    else
        warn("Ошибка при проверке ключа: " .. tostring(response))
        return false
    end
end

-- Функция для загрузки основного скрипта
local function loadMainScript()
    local success, response = pcall(function()
        return httpService:GetAsync(MAIN_SCRIPT_URL)
    end)

    if success then
        loadstring(response)()  -- Выполняет основной скрипт
    else
        warn("Ошибка при загрузке основного скрипта: " .. tostring(response))
    end
end

-- Обработчик события нажатия кнопки
checkButton.MouseButton1Click:Connect(function()
    local userKey = keyInput.Text
    if checkKey(userKey) then
        print("Ключ действителен. Загружаю основной скрипт...")
        loadMainScript()
    else
        print("Недействительный ключ. Доступ к скрипту запрещен.")
    end
end)
