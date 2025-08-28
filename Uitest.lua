-- NovaZ UI Library
local TweenService = game:GetService("TweenService")

local NovaZLib = {}

function NovaZLib:CreateWindow(title, subtitle)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = game:GetService("CoreGui")
    ScreenGui.Name = "NovaZUI"

    local MainFrame = Instance.new("Frame")
    MainFrame.Parent = ScreenGui
    MainFrame.Size = UDim2.new(0, 400, 0, 300)
    MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 12)
    UICorner.Parent = MainFrame

    local TitleBar = Instance.new("Frame")
    TitleBar.Parent = MainFrame
    TitleBar.Size = UDim2.new(1, 0, 0, 40)
    TitleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Parent = TitleBar
    TitleLabel.Size = UDim2.new(1, -50, 1, 0)
    TitleLabel.Position = UDim2.new(0, 10, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = title .. " - " .. subtitle
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextSize = 16
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

    local Window = {}
    Window.MainFrame = MainFrame
    Window.TitleBar = TitleBar

    -- Função de minimizar
    function Window:AddMinimizeButton(config)
        local btn = Instance.new("ImageButton")
        btn.Name = "MinimizeButton"
        btn.Parent = TitleBar
        btn.Size = UDim2.new(0, 30, 0, 30)
        btn.Position = UDim2.new(1, -35, 0.5, -15)
        btn.BackgroundTransparency = config.Button.BackgroundTransparency or 1
        btn.Image = config.Button.Image or "rbxassetid://7072724538"

        local corner = Instance.new("UICorner")
        corner.CornerRadius = config.Corner.CornerRadius or UDim.new(0, 8)
        corner.Parent = btn

        local minimized = false
        btn.MouseButton1Click:Connect(function()
            minimized = not minimized
            local goal = {}
            if minimized then
                goal.Size = UDim2.new(0, MainFrame.Size.X.Offset, 0, 40)
            else
                goal.Size = UDim2.new(0, MainFrame.Size.X.Offset, 0, 300)
            end
            TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), goal):Play()
        end)
    end

    return Window
end

return NovaZLib
