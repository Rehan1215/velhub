	Btn.Text = name
	Btn.BackgroundColor3 = Color3.fromRGB(30,35,55)
	Btn.TextColor3 = Color3.new(1,1,1)
	Btn.Font = Enum.Font.GothamBold
	Btn.TextSize = 14
	Instance.new("UICorner", Btn).CornerRadius = UDim.new(0,12)
	
	local Page = Instance.new("Frame", ContentArea)
	Page.Size = UDim2.new(1,0,1,0)
	Page.Visible = false
	Page.BackgroundTransparency = 1
	
	Tabs[Btn] = Page
	
	Btn.MouseButton1Click:Connect(function()
		for b,p in pairs(Tabs) do
			p.Visible = false
			TweenService:Create(b, TweenInfo.new(0.2), {
				BackgroundColor3 = Color3.fromRGB(30,35,55)
			}):Play()
		end
		
		Page.Visible = true
		Page.BackgroundTransparency = 1
		TweenService:Create(Page, TweenInfo.new(0.3), {
			BackgroundTransparency = 0
		}):Play()
		
		TweenService:Create(Btn, TweenInfo.new(0.2), {
			BackgroundColor3 = Color3.fromRGB(60,80,150)
		}):Play()
	end)
	
	return Page
end

-- CREATE TABS
local GeneralTab = CreateTab("General")
local AdvancedTab = CreateTab("Advanced")
local VisualTab = CreateTab("Visual")

-- AUTO OPEN FIRST TAB
for b,p in pairs(Tabs) do
	p.Visible = true
	TweenService:Create(b, TweenInfo.new(0.2), {
		BackgroundColor3 = Color3.fromRGB(60,80,150)
	}):Play()
	break
end

-- CARD CREATOR
local function CreateCard(parent, titleText, height)
	local Card = Instance.new("Frame", parent)
	Card.Size = UDim2.new(1,0,0,height or 100)
	Card.BackgroundColor3 = Color3.fromRGB(30,35,55)
	Instance.new("UICorner", Card).CornerRadius = UDim.new(0,16)
	
	local Stroke = Instance.new("UIStroke", Card)
	Stroke.Color = Color3.fromRGB(70,90,160)
	
	local Label = Instance.new("TextLabel", Card)
	Label.Position = UDim2.new(0,15,0,10)
	Label.Size = UDim2.new(1,-30,0,25)
	Label.BackgroundTransparency = 1
	Label.Text = titleText
	Label.TextColor3 = Color3.fromRGB(200,210,255)
	Label.Font = Enum.Font.GothamBold
	Label.TextSize = 15
	Label.TextXAlignment = Enum.TextXAlignment.Left
	
	return Card
end

-- SLIDER CREATOR
local function CreateSlider(parent)
	local Bar = Instance.new("Frame", parent)
	Bar.Position = UDim2.new(0,20,0,50)
	Bar.Size = UDim2.new(1,-40,0,8)
	Bar.BackgroundColor3 = Color3.fromRGB(60,60,80)
	Instance.new("UICorner", Bar).CornerRadius = UDim.new(1,0)
	
	local Fill = Instance.new("Frame", Bar)
	Fill.Size = UDim2.new(0.5,0,1,0)
	Fill.BackgroundColor3 = Color3.fromRGB(0,170,200)
	Instance.new("UICorner", Fill).CornerRadius = UDim.new(1,0)
	
	local ValueLabel = Instance.new("TextLabel", parent)
	ValueLabel.Position = UDim2.new(0,20,0,65)
	ValueLabel.Size = UDim2.new(1,-40,0,20)
	ValueLabel.BackgroundTransparency = 1
	ValueLabel.Text = "Value: 50%"
	ValueLabel.TextColor3 = Color3.new(1,1,1)
	ValueLabel.Font = Enum.Font.Gotham
	ValueLabel.TextSize = 13
	
	Bar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			local connection
			connection = RunService.RenderStepped:Connect(function()
				local mouse = game.Players.LocalPlayer:GetMouse()
				local percent = math.clamp((mouse.X - Bar.AbsolutePosition.X)/Bar.AbsoluteSize.X,0,1)
				Fill.Size = UDim2.new(percent,0,1,0)
				ValueLabel.Text = "Value: "..math.floor(percent*100).."%"
			end)
			
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					connection:Disconnect()
				end
			end)
		end
	end)
end

-- ADD CONTENT
local Layout1 = Instance.new("UIListLayout", GeneralTab)
Layout1.Padding = UDim.new(0,20)

local CardA = CreateCard(GeneralTab, "Main Setting", 110)
CreateSlider(CardA)

local CardB = CreateCard(GeneralTab, "Secondary Setting", 110)
CreateSlider(CardB)

local Layout2 = Instance.new("UIListLayout", AdvancedTab)
Layout2.Padding = UDim.new(0,20)

local CardC = CreateCard(AdvancedTab, "Advanced Control", 110)
CreateSlider(CardC)

local Layout3 = Instance.new("UIListLayout", VisualTab)
Layout3.Padding = UDim.new(0,20)

local CardD = CreateCard(VisualTab, "Visual Effect", 110)
CreateSlider(CardD)

-- CLOSE BUTTON
local Close = Instance.new("TextButton", Main)
Close.Size = UDim2.new(0,40,0,40)
Close.Position = UDim2.new(1,-50,0,10)
Close.Text = "X"
Close.Font = Enum.Font.GothamBold
Close.TextSize = 18
Close.TextColor3 = Color3.new(1,1,1)
Close.BackgroundColor3 = Color3.fromRGB(180,60,60)
Instance.new("UICorner", Close).CornerRadius = UDim.new(1,0)

Close.MouseButton1Click:Connect(function()
	TweenService:Create(Main, TweenInfo.new(0.3), {
		BackgroundTransparency = 1
	}):Play()
	task.wait(0.3)
	ScreenGui:Destroy()
end)
