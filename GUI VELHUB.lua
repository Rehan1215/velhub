--// VELHUB MOBILE TEMPLATE
--// Optimized for Phone
--// By ChatGPT for Rehan

local VelHub = {}

function VelHub:Create()

    local Players = game:GetService("Players")
    local TweenService = game:GetService("TweenService")
    local UIS = game:GetService("UserInputService")

    local player = Players.LocalPlayer
    local PlayerGui = player:WaitForChild("PlayerGui")

    if PlayerGui:FindFirstChild("VelHubMobile") then
        PlayerGui.VelHubMobile:Destroy()
    end

    -- SCREEN GUI
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "VelHubMobile"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = PlayerGui

    -- CLICK SOUND
    local ClickSound = Instance.new("Sound")
    ClickSound.SoundId = "rbxassetid://9118823102"
    ClickSound.Volume = 1
    ClickSound.Parent = ScreenGui

    local function click()
        ClickSound:Play()
    end

    -- MAIN FRAME (Responsive)
    local Main = Instance.new("Frame")
    Main.Size = UDim2.new(0.9,0,0.8,0)
    Main.Position = UDim2.new(0.05,0,0.1,0)
    Main.BackgroundColor3 = Color3.fromRGB(15,15,20)
    Main.BorderSizePixel = 0
    Main.Parent = ScreenGui
    Main.Active = true
    Main.Draggable = true

    Instance.new("UICorner", Main).CornerRadius = UDim.new(0,20)

    -- SHADOW EFFECT
    local UIStroke = Instance.new("UIStroke", Main)
    UIStroke.Color = Color3.fromRGB(0,170,255)
    UIStroke.Thickness = 1.5

    -- TOP BAR
    local TopBar = Instance.new("Frame")
    TopBar.Size = UDim2.new(1,0,0,50)
    TopBar.BackgroundColor3 = Color3.fromRGB(20,20,30)
    TopBar.BorderSizePixel = 0
    TopBar.Parent = Main

    Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0,20)

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1,0,1,0)
    Title.BackgroundTransparency = 1
    Title.Text = "VELHUB MOBILE"
    Title.Font = Enum.Font.GothamBold
    Title.TextScaled = true
    Title.TextColor3 = Color3.fromRGB(0,170,255)
    Title.Parent = TopBar

    -- SIDEBAR BUTTON (OPEN)
    local MenuBtn = Instance.new("TextButton")
    MenuBtn.Size = UDim2.new(0,45,0,45)
    MenuBtn.Position = UDim2.new(0,5,0,2)
    MenuBtn.Text = "≡"
    MenuBtn.Font = Enum.Font.GothamBold
    MenuBtn.TextScaled = true
    MenuBtn.BackgroundColor3 = Color3.fromRGB(0,170,255)
    MenuBtn.TextColor3 = Color3.new(1,1,1)
    MenuBtn.Parent = TopBar

    Instance.new("UICorner", MenuBtn).CornerRadius = UDim.new(1,0)

    -- SIDEBAR
    local Sidebar = Instance.new("Frame")
    Sidebar.Size = UDim2.new(0.5,0,1,0)
    Sidebar.Position = UDim2.new(-0.5,0,0,0)
    Sidebar.BackgroundColor3 = Color3.fromRGB(18,18,25)
    Sidebar.BorderSizePixel = 0
    Sidebar.Parent = Main

    Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0,20)

    local Layout = Instance.new("UIListLayout", Sidebar)
    Layout.Padding = UDim.new(0,10)

    -- CONTENT
    local Content = Instance.new("Frame")
    Content.Size = UDim2.new(1,0,1,-50)
    Content.Position = UDim2.new(0,0,0,50)
    Content.BackgroundTransparency = 1
    Content.Parent = Main

    -- SIDEBAR TOGGLE
    local opened = false

    MenuBtn.MouseButton1Click:Connect(function()
        click()
        opened = not opened
        TweenService:Create(Sidebar,TweenInfo.new(0.4,Enum.EasingStyle.Quad),
            {Position = opened and UDim2.new(0,0,0,0) or UDim2.new(-0.5,0,0,0)}
        ):Play()
    end)

    -- TAB SYSTEM
    local Tabs = {}

    local function createTab(name)
        local Btn = Instance.new("TextButton")
        Btn.Size = UDim2.new(1,-20,0,45)
        Btn.Position = UDim2.new(0,10,0,0)
        Btn.Text = name
        Btn.Font = Enum.Font.Gotham
        Btn.TextScaled = true
        Btn.BackgroundColor3 = Color3.fromRGB(25,25,35)
        Btn.TextColor3 = Color3.new(1,1,1)
        Btn.Parent = Sidebar

        Instance.new("UICorner", Btn).CornerRadius = UDim.new(0,12)

        local Page = Instance.new("Frame")
        Page.Size = UDim2.new(1,0,1,0)
        Page.BackgroundTransparency = 1
        Page.Visible = false
        Page.Parent = Content

        Tabs[name] = Page

        Btn.MouseButton1Click:Connect(function()
            click()
            for _,v in pairs(Tabs) do
                v.Visible = false
            end
            Page.Visible = true
        end)

        return Page
    end

    local Home = createTab("Home")
    local Settings = createTab("Settings")
    Tabs["Home"].Visible = true

    -- TOGGLE COMPONENT
    local function createToggle(parent,text,posY)
        local Btn = Instance.new("TextButton")
        Btn.Size = UDim2.new(0.8,0,0,50)
        Btn.Position = UDim2.new(0.1,0,0,posY)
        Btn.BackgroundColor3 = Color3.fromRGB(30,30,40)
        Btn.Text = text.." : OFF"
        Btn.Font = Enum.Font.Gotham
        Btn.TextScaled = true
        Btn.TextColor3 = Color3.new(1,1,1)
        Btn.Parent = parent

        Instance.new("UICorner",Btn).CornerRadius = UDim.new(0,15)

        local state = false
        Btn.MouseButton1Click:Connect(function()
            click()
            state = not state
            Btn.Text = text.." : "..(state and "ON" or "OFF")
            Btn.BackgroundColor3 = state and Color3.fromRGB(0,170,255)
                or Color3.fromRGB(30,30,40)
        end)
    end

    createToggle(Home,"Blue Mode",40)

    -- SLIDER COMPONENT
    local function createSlider(parent,text,posY)
        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.new(0.8,0,0,80)
        Frame.Position = UDim2.new(0.1,0,0,posY)
        Frame.BackgroundTransparency = 1
        Frame.Parent = parent

        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1,0,0,30)
        Label.BackgroundTransparency = 1
        Label.Text = text.." : 0"
        Label.Font = Enum.Font.Gotham
        Label.TextScaled = true
        Label.TextColor3 = Color3.new(1,1,1)
        Label.Parent = Frame

        local Bar = Instance.new("Frame")
        Bar.Size = UDim2.new(1,0,0,10)
        Bar.Position = UDim2.new(0,0,0,50)
        Bar.BackgroundColor3 = Color3.fromRGB(40,40,50)
        Bar.Parent = Frame

        Instance.new("UICorner",Bar).CornerRadius = UDim.new(1,0)

        local Fill = Instance.new("Frame")
        Fill.Size = UDim2.new(0,0,1,0)
        Fill.BackgroundColor3 = Color3.fromRGB(0,170,255)
        Fill.Parent = Bar

        Instance.new("UICorner",Fill).CornerRadius = UDim.new(1,0)

        local dragging = false

        Bar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1
                or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                click()
            end
        end)

        UIS.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1
                or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)

        UIS.InputChanged:Connect(function(input)
            if dragging then
                local size = math.clamp(
                    (input.Position.X - Bar.AbsolutePosition.X) / Bar.AbsoluteSize.X,
                    0,1
                )
                Fill.Size = UDim2.new(size,0,1,0)
                Label.Text = text.." : "..math.floor(size*100)
            end
        end)
    end

    createSlider(Settings,"Volume",50)

end

return VelHub
