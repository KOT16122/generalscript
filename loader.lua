-- Создание GUI
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextBox = Instance.new("TextBox")
local TextButton = Instance.new("TextButton")
local StatusLabel = Instance.new("TextLabel")

-- Настройки GUI
ScreenGui.Parent = game.CoreGui
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0.5, 0, 0.5, 0)
Frame.Position = UDim2.new(0.25, 0, 0.25, 0)

TextBox.Parent = Frame
TextBox.Size = UDim2.new(1, 0, 0.2, 0)
TextBox.PlaceholderText = "Введите ключ"

TextButton.Parent = Frame
TextButton.Size = UDim2.new(1, 0, 0.2, 0)
TextButton.Position = UDim2.new(0, 0, 0.25, 0)
TextButton.Text = "Проверить ключ"

StatusLabel.Parent = Frame
StatusLabel.Size = UDim2.new(1, 0, 0.2, 0)
StatusLabel.Position = UDim2.new(0, 0, 0.5, 0)
StatusLabel.Text = ""

-- Функция для проверки ключа
local function checkKey(key)
    local HttpService = game:GetService("HttpService")
    local url = "https://f6b1-87-117-51-159.ngrok-free.app/check-key"  -- Замените на ваш URL
    local data = HttpService:JSONEncode({key = key})

    local response = HttpService:PostAsync(url, data, Enum.HttpContentType.ApplicationJson)
    return HttpService:JSONDecode(response)
end

-- Обработчик нажатия кнопки
TextButton.MouseButton1Click:Connect(function()
    local key = TextBox.Text
    StatusLabel.Text = "Проверка ключа..."

    local result = checkKey(key)

    if result.status == "success" then
        StatusLabel.Text = "Ключ действителен! Загружаем скрипт..."
        
        -- Здесь вставьте код скрипта, который нужно загрузить
        local scriptToLoad = "https://raw.githubusercontent.com/ваш_скрипт/main.lua"  -- Замените на URL вашего скрипта
        loadstring(game:HttpGet(scriptToLoad))()
    else
        StatusLabel.Text = "Неверный ключ."
    end
end)
