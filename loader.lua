-- Убедитесь, что у вас включен HTTPService
local HttpService = game:GetService("HttpService")

-- Создание GUI
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextBox = Instance.new("TextBox")
local CheckButton = Instance.new("TextButton")
local MessageLabel = Instance.new("TextLabel")

-- Настройка Frame
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 300, 0, 200)
Frame.Position = UDim2.new(0.5, -150, 0.5, -100)
Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

-- Настройка TextBox
TextBox.Parent = Frame
TextBox.Size = UDim2.new(1, 0, 0, 50)
TextBox.Position = UDim2.new(0, 0, 0, 20)
TextBox.PlaceholderText = "Введите ваш ключ"

-- Настройка CheckButton
CheckButton.Parent = Frame
CheckButton.Size = UDim2.new(1, 0, 0, 50)
CheckButton.Position = UDim2.new(0, 0, 0, 80)
CheckButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
CheckButton.Text = "Проверить ключ"

-- Настройка MessageLabel
MessageLabel.Parent = Frame
MessageLabel.Size = UDim2.new(1, 0, 0, 50)
MessageLabel.Position = UDim2.new(0, 0, 0, 140)
MessageLabel.Text = ""
MessageLabel.TextColor3 = Color3.fromRGB(255, 0, 0)

-- Функция для проверки ключа
local function checkKey(key)
    local url = "http://192.168.0.10:3000/check?key=" .. HttpService:UrlEncode(key)
    local response = HttpService:GetAsync(url)

    local success, data = pcall(function()
        return HttpService:JSONDecode(response)
    end)

    if success and data.valid then
        MessageLabel.Text = "Ключ действителен!"
        -- Выполняем скрипт при успешной проверке ключа
        loadstring(game:HttpGet("https://raw.githubusercontent.com/KOT16122/generalscript/main/script.lua"))()
    else
        MessageLabel.Text = "Неверный ключ или ключ уже использован."
    end
end

-- Обработчик нажатия кнопки
CheckButton.MouseButton1Click:Connect(function()
    local key = TextBox.Text
    if key and key ~= "" then
        checkKey(key)
    else
        MessageLabel.Text = "Введите ключ!"
    end
end)

-- Добавление GUI в игру
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
