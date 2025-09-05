-- NovaZLib
local NovaZLib = {}
NovaZLib.Tabs = {}

-- Criar janela principal
function NovaZLib:CreateWindow(config)
    local Window = {
        Name = config.Name or "NovaZLib",
        Tabs = {}
    }
    print("Janela criada:", Window.Name)
    self.Window = Window
    return Window
end

-- Criar aba
function NovaZLib:CreateTab(window, name)
    local Tab = {
        Name = name,
        Elements = {}
    }
    table.insert(window.Tabs, Tab)
    self.Tabs[name] = Tab
    print("Aba criada:", name)
    return Tab
end

-- Criar botão
function NovaZLib:CreateButton(tab, name, callback)
    local Button = {
        Name = name,
        Callback = callback
    }
    table.insert(tab.Elements, Button)
    print("Botão criado:", name)
end

-- Criar toggle
function NovaZLib:CreateToggle(tab, name, default, callback)
    local Toggle = {
        Name = name,
        Value = default,
        Callback = callback
    }
    table.insert(tab.Elements, Toggle)
    print("Toggle criado:", name)
end

return NovaZLibfunction SuperLib:CreateButton(tab, name, callback)
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
