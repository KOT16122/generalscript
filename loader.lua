local HttpService = game:GetService("HttpService")

-- URL для API проверки ключа
local API_URL = "https://997b-87-117-51-159.ngrok-free.app/check-key"

-- Создание GUI
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local KeyBox = Instance.new("TextBox")
local CheckButton = Instance.new("TextButton")
local OutputLabel = Instance.new("TextLabel")

-- Настройка элементов GUI
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 300, 0, 200)
Frame.Position = UDim2.new(0.5, -150, 0.5, -100)
Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

KeyBox.Parent = Frame
KeyBox.Size = UDim2.new(1, 0, 0, 50)
KeyBox.Position = UDim2.new(0, 0, 0, 20)
KeyBox.PlaceholderText = "Введите ваш ключ"

CheckButton.Parent = Frame
CheckButton.Size = UDim2.new(1, 0, 0, 50)
CheckButton.Position = UDim2.new(0, 0, 0, 80)
CheckButton.Text = "Проверить ключ"

OutputLabel.Parent = Frame
OutputLabel.Size = UDim2.new(1, 0, 0, 50)
OutputLabel.Position = UDim2.new(0, 0, 0, 140)
OutputLabel.Text = ""

-- Функция для проверки ключа
local function checkKey(key)
    local success, response = pcall(function()
        return HttpService:PostAsync(API_URL, HttpService:JSONEncode({key = key}), Enum.HttpContentType.ApplicationJson)
    end)

    if success then
        local result = HttpService:JSONDecode(response)
        return result.status == "success"
    else
        return false
    end
end

-- Обработка нажатия кнопки
CheckButton.MouseButton1Click:Connect(function()
    local key = KeyBox.Text
    if checkKey(key) then
        OutputLabel.Text = "Ключ действителен! Загружаю скрипт..."
        -- Загрузка основного скрипта
        local mainScriptUrl = "https://raw.githubusercontent.com/KOT16122/generalscript/main/script.lua" -- Замените на фактический URL вашего основного скрипта
        loadstring(game:HttpGet(mainScriptUrl))()
    else
        OutputLabel.Text = "Недействительный ключ!"
    end
end)
