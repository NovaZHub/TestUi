-- NovaZLib UI com Intro, Tabs e Minimize/Close
local TweenService = game:GetService("TweenService")

local NovaZLib = {}
NovaZLib.__index = NovaZLib

-- Criar Janela
function NovaZLib:CreateWindow(config)
    config = config or {}
    local window = setmetatable({}, NovaZLib)

    -- ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "NovaZHub_UI"
    ScreenGui.Parent = game:GetService("CoreGui")
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.ResetOnSpawn = false

    -- MainFrame
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.Size = UDim2.new(0, 450, 0, 300)
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    MainFrame.BackgroundTransparency = 1
    MainFrame.Visible = false

    local UICorner = Instance.new("UICorner", MainFrame)
    UICorner.CornerRadius = UDim.new(0, 8)

    -- Topbar
    local Topbar = Instance.new("Frame")
    Topbar.Name = "Topbar"
    Topbar.Parent = MainFrame
    Topbar.Size = UDim2.new(1, 0, 0, 35)
    Topbar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

    local TopCorner = Instance.new("UICorner", Topbar)
    TopCorner.CornerRadius = UDim.new(0, 8)

    local Title = Instance.new("TextLabel")
    Title.Parent = Topbar
    Title.Size = UDim2.new(1, -70, 1, 0)
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.Text = config.Title or "NovaZHub"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.BackgroundTransparency = 1
    Title.TextSize = 16

    -- Fechar
    local CloseButton = Instance.new("TextButton")
    CloseButton.Parent = Topbar
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(1, -35, 0, 3)
    CloseButton.Text = "X"
    CloseButton.TextSize = 16
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)

    local CloseCorner = Instance.new("UICorner", CloseButton)
    CloseCorner.CornerRadius = UDim.new(0, 6)

    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    -- Botão minimizar
    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Parent = Topbar
    MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
    MinimizeButton.Position = UDim2.new(1, -70, 0, 3)
    MinimizeButton.Text = "-"
    MinimizeButton.TextSize = 20
    MinimizeButton.Font = Enum.Font.GothamBold
    MinimizeButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)

    local MiniCorner = Instance.new("UICorner", MinimizeButton)
    MiniCorner.CornerRadius = UDim.new(0, 6)

    local minimized = false
    local fullSize = MainFrame.Size
    local minSize = UDim2.new(0, 450, 0, 35)

    MinimizeButton.MouseButton1Click:Connect(function()
        if minimized then
            TweenService:Create(MainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = fullSize,
                Position = UDim2.new(0.5, 0, 0.5, 0),
                BackgroundTransparency = 0
            }):Play()
        else
            TweenService:Create(MainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = minSize,
                Position = UDim2.new(0.5, 0, 0.5, -120),
                BackgroundTransparency = 0.4
            }):Play()
        end
        minimized = not minimized
    end)

    -- Conteúdo (Tabs)
    local TabHolder = Instance.new("Frame", MainFrame)
    TabHolder.Size = UDim2.new(1, -10, 1, -45)
    TabHolder.Position = UDim2.new(0, 5, 0, 40)
    TabHolder.BackgroundTransparency = 1

    window.ScreenGui = ScreenGui
    window.MainFrame = MainFrame
    window.TabHolder = TabHolder

    -- Intro animada
    MainFrame.Visible = true
    TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0
    }):Play()

    return window
end

-- Criar Tabs
function NovaZLib:CreateTab(name)
    local TabFrame = Instance.new("Frame", self.TabHolder)
    TabFrame.Size = UDim2.new(1, 0, 1, 0)
    TabFrame.BackgroundTransparency = 1

    local Label = Instance.new("TextLabel", TabFrame)
    Label.Text = name
    Label.Size = UDim2.new(1, 0, 0, 30)
    Label.BackgroundTransparency = 1
    Label.Font = Enum.Font.GothamBold
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 16

    return TabFrame
end

return NovaZLib
