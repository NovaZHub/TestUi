-- SuperLibraryMin.lua
-- Library completa com Minimizar

local SuperLib = {}

-- Serviços
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Armazena todas as janelas
SuperLib.Windows = {}

-- Criar janela
function SuperLib:CreateWindow(title)
    local window = Instance.new("ScreenGui")
    window.Name = title
    window.ResetOnSpawn = false
    window.Parent = PlayerGui

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 500, 0, 400)
    mainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    mainFrame.BorderSizePixel = 0
    mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    mainFrame.Parent = window

    -- Título
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0, 50)
    titleLabel.Position = UDim2.new(0, 0, 0, 0)
    titleLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 24
    titleLabel.Parent = mainFrame

    -- Botão Minimizar
    local minimizeButton = Instance.new("TextButton")
    minimizeButton.Size = UDim2.new(0, 30, 0, 30)
    minimizeButton.Position = UDim2.new(1, -35, 0, 10)
    minimizeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    minimizeButton.Text = "_"
    minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    minimizeButton.Font = Enum.Font.GothamBold
    minimizeButton.TextSize = 24
    minimizeButton.Parent = mainFrame

    local minimized = false
    local originalSize = mainFrame.Size
    local originalPos = mainFrame.Position

    minimizeButton.MouseButton1Click:Connect(function()
        if not minimized then
            mainFrame:TweenSize(UDim2.new(0, 200, 0, 50), "Out", "Quad", 0.3, true)
            mainFrame:TweenPosition(UDim2.new(0.5, -100, 0.5, -25), "Out", "Quad", 0.3, true)
            minimized = true
        else
            mainFrame:TweenSize(originalSize, "Out", "Quad", 0.3, true)
            mainFrame:TweenPosition(originalPos, "Out", "Quad", 0.3, true)
            minimized = false
        end
    end)

    -- Container de abas
    local tabContainer = Instance.new("Frame")
    tabContainer.Size = UDim2.new(1, 0, 1, -50)
    tabContainer.Position = UDim2.new(0, 0, 0, 50)
    tabContainer.BackgroundTransparency = 1
    tabContainer.Parent = mainFrame

    local windowData = {
        Gui = window,
        Frame = mainFrame,
        Tabs = {},
        TabContainer = tabContainer
    }

    table.insert(SuperLib.Windows, windowData)
    return windowData
end

-- Criar aba
function SuperLib:CreateTab(window, name)
    local tabFrame = Instance.new("Frame")
    tabFrame.Size = UDim2.new(1, 0, 1, 0)
    tabFrame.Position = UDim2.new(0, 0, 0, 0)
    tabFrame.BackgroundTransparency = 1
    tabFrame.Visible = true
    tabFrame.Parent = window.TabContainer

    local tabData = {
        Name = name,
        Frame = tabFrame,
        Buttons = {},
        Toggles = {},
        Sliders = {}
    }

    table.insert(window.Tabs, tabData)
    return tabData
end

-- Botão
function SuperLib:CreateButton(tab, name, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 200, 0, 40)
    button.Position = UDim2.new(0, 20, 0, 20 + (#tab.Buttons * 50))
    button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    button.Text = name
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 20
    button.Parent = tab.Frame

    button.MouseButton1Click:Connect(function()
        callback()
    end)

    table.insert(tab.Buttons, button)
    return button
end

-- Toggle
function SuperLib:CreateToggle(tab, name, default, callback)
    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(0, 200, 0, 40)
    toggle.Position = UDim2.new(0, 20, 0, 20 + (#tab.Toggles * 50))
    toggle.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    toggle.Text = name .. ": " .. (default and "ON" or "OFF")
    toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggle.Font = Enum.Font.GothamBold
    toggle.TextSize = 20
    toggle.Parent = tab.Frame

    local state = default

    toggle.MouseButton1Click:Connect(function()
        state = not state
        toggle.Text = name .. ": " .. (state and "ON" or "OFF")
        callback(state)
    end)

    table.insert(tab.Toggles, toggle)
    return toggle
end

-- Slider
function SuperLib:CreateSlider(tab, name, min, max, default, callback)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = UDim2.new(0, 200, 0, 40)
    sliderFrame.Position = UDim2.new(0, 20, 0, 20 + (#tab.Sliders * 50))
    sliderFrame.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    sliderFrame.Parent = tab.Frame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0.5, 0)
    label.Position = UDim2.new(0, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = name .. ": " .. default
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 18
    label.Parent = sliderFrame

    local sliderBar = Instance.new("Frame")
    sliderBar.Size = UDim2.new(1, 0, 0.5, 0)
    sliderBar.Position = UDim2.new(0, 0, 0.5, 0)
    sliderBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    sliderBar.Parent = sliderFrame

    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    sliderFill.Position = UDim2.new(0, 0, 0, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
    sliderFill.Parent = sliderBar

    local dragging = false

    sliderBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)

    sliderBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    RunService.RenderStepped:Connect(function()
        if dragging then
            local mouse = game.Players.LocalPlayer:GetMouse()
            local relativeX = math.clamp(mouse.X - sliderBar.AbsolutePosition.X, 0, sliderBar.AbsoluteSize.X)
            local value = min + (relativeX / sliderBar.AbsoluteSize.X) * (max - min)
            sliderFill.Size = UDim2.new(relativeX / sliderBar.AbsoluteSize.X, 0, 1, 0)
            label.Text = name .. ": " .. math.floor(value)
            callback(value)
        end
    end)

    table.insert(tab.Sliders, sliderFrame)
    return sliderFrame
end

return SuperLib
