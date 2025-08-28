-- NovaZLib UI Test

local NovaZLib = {}

function NovaZLib:CreateWindow(title, subtitle)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = game.CoreGui
    ScreenGui.Name = "NovaZLibUI"

    -- Main Frame
    local MainFrame = Instance.new("Frame")
    MainFrame.Parent = ScreenGui
    MainFrame.Size = UDim2.new(0, 400, 0, 300)
    MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    MainFrame.Active = true
    MainFrame.Draggable = true -- ✅ agora dá pra arrastar a janela

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 12)
    UICorner.Parent = MainFrame

    -- Title
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Parent = MainFrame
    TitleLabel.Size = UDim2.new(1, 0, 0, 40)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = title .. " | " .. subtitle
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextScaled = true
    TitleLabel.Font = Enum.Font.GothamBold

    -- Minimize Button
    local MinimizeButton = Instance.new("ImageButton")
    MinimizeButton.Parent = MainFrame
    MinimizeButton.Size = UDim2.new(0, 35, 0, 35)
    MinimizeButton.Position = UDim2.new(1, -45, 0, 5)
    MinimizeButton.BackgroundTransparency = 0
    MinimizeButton.Image = "rbxassetid://71014873973869" -- ícone
    MinimizeButton.AutoButtonColor = true

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(1, 0)
    Corner.Parent = MinimizeButton

    local minimized = false
    MinimizeButton.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            MainFrame:TweenSize(UDim2.new(0, 400, 0, 40), "Out", "Quad", 0.3, true)
        else
            MainFrame:TweenSize(UDim2.new(0, 400, 0, 300), "Out", "Quad", 0.3, true)
        end
    end)

    return MainFrame
end

return NovaZLib
