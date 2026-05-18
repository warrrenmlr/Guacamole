--//Fisch V2
local RunService = game:GetService("RunService")
local ReGui = loadstring(game:HttpGet('https://raw.githubusercontent.com/depthso/Dear-ReGui/refs/heads/main/ReGui.lua'))()
ReGui:DefineTheme("Pisces", {
	TitleAlign = Enum.TextXAlignment.Center,
	TextDisabled = Color3.fromRGB(59, 83, 94),
	Text = Color3.fromRGB(180, 193, 200),
	
	FrameBg = Color3.fromRGB(20, 23, 25),
	FrameBgTransparency = 0.4,
	FrameBgActive = Color3.fromRGB(59, 83, 94),
	FrameBgTransparencyActive = 0.4,
	
	CheckMark = Color3.fromRGB(84, 114, 148),
	SliderGrab = Color3.fromRGB(84, 114, 148),
	ButtonsBg = Color3.fromRGB(84, 114, 148),
	CollapsingHeaderBg = Color3.fromRGB(84, 114, 148),
	CollapsingHeaderText = Color3.fromRGB(180, 193, 200),
	RadioButtonHoveredBg = Color3.fromRGB(84, 114, 148),
	
	WindowBg = Color3.fromRGB(30, 32, 35),
	TitleBarBg = Color3.fromRGB(30, 32, 35),
	TitleBarBgActive = Color3.fromRGB(45, 47, 50),
	
	Border = Color3.fromRGB(45, 47, 50),
	ResizeGrab = Color3.fromRGB(45, 47, 50),
	RegionBgTransparency = 1,
})
--// Tabs
local Window = ReGui:Window({
	Title = "Pisces BETA",
	Theme = "Pisces",
	NoClose = true,
	Size = UDim2.new(0, 600, 0, 400),
}):Center()
local ModalWindow = Window:PopupModal({
	Title = "Key System (teehee)",
	AutoSize = "Y"
})
ModalWindow:Label({
	Text = "Please enter the key from the discord. Click the button below to join.",
	TextWrapped = true
})
Key = ModalWindow:InputText({
    Label = " ",
    Value = ""
})
ModalWindow:Button({
    Text = "Check Key",
    Callback = function()
        if Key:GetValue() == "TesterKey" or Key:GetValue() == "YBGDon" then
            ModalWindow:ClosePopup()
        else
            Key:SetLabel("Wrong key!")
            wait(2)
            Key:SetLabel(" ")
        end
    end
})
ModalWindow:Separator()
DiscordButton = ModalWindow:Button({
    Text = "Discord",
    Callback = function()
        local textToCopy = "discord.gg/NVsvWfxv3K"
        setclipboard(textToCopy)
        DiscordButton.Text = "Copied!"
        wait(2)
        DiscordButton.Text = "Discord"
    end
})
Idfk34 = ModalWindow:Label({
    Text = " "
})
local Group = Window:List({
	UiPadding = 2,
	HorizontalFlex = Enum.UIFlexAlignment.Fill,
})
local TabsBar = Group:List({
	Border = true,
	UiPadding = 5,
	BorderColor = Window:GetThemeKey("Border"),
	BorderThickness = 1,
	HorizontalFlex = Enum.UIFlexAlignment.Fill,
	HorizontalAlignment = Enum.HorizontalAlignment.Center,
	AutomaticSize = Enum.AutomaticSize.None,
	FlexMode = Enum.UIFlexMode.None,
	Size = UDim2.new(0, 40, 1, 0),
	CornerRadius = UDim.new(0, 5)
})
local TabSelector = Group:TabSelector({
	NoTabsBar = true,
	Size = UDim2.fromScale(0.5, 1)
})
local function CreateTab(Name: string, Icon)
	local Tab = TabSelector:CreateTab({
		Name = Name
	})

	local List = Tab:List({
		HorizontalFlex = Enum.UIFlexAlignment.Fill,
		UiPadding = 1,
		Spacing = 10
	})

	local Button = TabsBar:Image({
		Image = Icon,
		Ratio = 1,
		RatioAxis = Enum.DominantAxis.Width,
		Size = UDim2.fromScale(1, 1),
		Callback = function(self)
			TabSelector:SetActiveTab(Tab)
		end,
	})

	ReGui:SetItemTooltip(Button, function(Canvas)
		Canvas:Label({
			Text = Name
		})
	end)

	return List
end
local function CreateRegion(Parent, Title)
	local Region = Parent:Region({
		Border = true,
		BorderColor = Window:GetThemeKey("Border"),
		BorderThickness = 1,
		CornerRadius = UDim.new(0, 5)
	})

	Region:Label({
		Text = Title
	})

	return Region
end

--// Regions n shit
local General = CreateTab("General", "rbxassetid://16211812161") --change to a better icon
local Char = CreateTab("Character", "rbxassetid://18854794412") -- icon is fine
local Settings = CreateTab("Settings", "rbxassetid://9743465390") -- fix icon
local Dev = CreateTab("Dev", "rbxassetid://4728059725") --bueno?

local FishingSection = CreateRegion(General, "Fishing")
local ConfigSection = CreateRegion(General, "Configs")
local CharSection = CreateRegion(Char, "Character")
local TPSection = CreateRegion(Char, "Teleports")
local SettingsSection = CreateRegion(Settings, "Settings")
local DevSection = CreateRegion(Dev, "Dev Stuff")
local DevelopmentSection = CreateRegion(Dev, "In Development")

--//Defining
local RunService = game:GetService("RunService")
local GuiService = cloneref(game:GetService('GuiService'))
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local playerGui = LocalPlayer:WaitForChild("PlayerGui")
local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Camera = Workspace.CurrentCamera
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")
local vim = game:GetService('VirtualInputManager')
local camera = workspace.CurrentCamera
local viewport = camera.ViewportSize
local midX, midY = viewport.X / 2, viewport.Y / 2
local VirtualUser = cloneref(game:GetService("VirtualUser"))

--//WindowSettings
local GuiToggleKey = Enum.KeyCode.Quote
local guiVisible = true
local GuiRoot = Window.Parent
UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == GuiToggleKey then
        guiVisible = not guiVisible
        GuiRoot.Enabled = guiVisible
    end
end)
SettingsSection:Button({
    Text = "Unload Script",
    Callback = function()
        if AutoCastRS then AutoCastRS:Disconnect() end
        if AutoReelRS then AutoReelRS:Disconnect() end
        if AutoShakeRS then AutoShakeRS:Disconnect() end
        if AutoStarfallRS then AutoStarfallRS:Disconnect() end
        if WalkspeedRS then WalkspeedRS:Disconnect() end
        if NoClipCheck.Value == true then clip() end
        if AntiAfkConnection then AntiAfkConnection:Disconnect() end
        DisableOxygenPeak.Value = false
        DisableOxygenWater.Value = false
        DisableTemp = false
        --should be it.
        Window:Close()
    end
})
SettingsSection:Keybind({
    Label = "Toggle Gui Keybind",
    Value = Enum.KeyCode.Quote,
    OnKeybindSet = function(self, KeyID)
        GuiToggleKey = KeyID
    end
})

--//Helper Funcs 
FindChild = function(parent, child)
    return parent:FindFirstChild(child)
end
FindChildOfClass = function(parent, classname)
    return parent:FindFirstChildOfClass(classname)
end
FindRod = function()
    if FindChildOfClass(getchar(), 'Tool') and FindChild(FindChildOfClass(getchar(), 'Tool'), 'values') then
        return FindChildOfClass(getchar(), 'Tool')
    else
        return nil
    end
end
getchar = function()
    return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end
gethrp = function()
    return getchar():WaitForChild('HumanoidRootPart')
end
getShakeButtonPosX = function()
    return LocalPlayer.PlayerGui['shakeui']['safezone']['button'].AbsolutePosition --Change this to wtv.
end
getShakeButtonPosY = function()
    return LocalPlayer.PlayerGui['shakeui']['safezone']['button'].AbsolutePosition --Change this to wtv.
end
--//Fishing Section
ConfigSection:Label({
    Text = "Instant may be detected",
})
ConfigSection:Label({
    Text = "Use at your own risk"
})
--checks or smth.
local function isReelUI()
    local ReelUI = LocalPlayer.PlayerGui:FindFirstChild("reel")
    if ReelUI then return true else return false end
end
local function isShakeUI()
    local ShakeUI = LocalPlayer.PlayerGui:FindFirstChild("shakeui")
    if ShakeUI then return true else return false end
end

FishingSection:Separator({
    Text = "Individual Toggles"
})
--Casting 
local CastCooldown = 1.5
local LastCast = 0
AutoCastActive = false
AutoCastMode = "Normal"
CastCheckbox = FishingSection:Checkbox({
    Value = false,
    Label = "Auto Cast",
    Callback = function(self, Value: boolean)
        if Value then
            AutoCastActive = true
            AutoCastCombo = ConfigSection:Combo({
                Label = "Cast Config",
                Items = {"Normal", "Instant"},
                Selected = AutoCastMode,
                Callback = function(self, ComboValue: string)
                    AutoCastMode = ComboValue
                end
            })
        else
            AutoCastActive = false
            if AutoCastCombo then
                AutoCastCombo:Destroy()
                AutoCastCombo = nil
            end
        end
    end
})
AutoCastRS = RunService.Heartbeat:Connect(function()
    if AutoCastActive then
        local rod = FindRod()
        if AutoCastMode == "Normal" then
            if rod then
                local now = tick()
                if now - LastCast < CastCooldown then return end
                if isReelUI() or isShakeUI() then return end
                LastCast = now
                vim:SendMouseButtonEvent(midX, midY, 0, true, game, 0)
                wait(0.2)
                vim:SendMouseButtonEvent(midX, midY, 0, false, game, 0)
            end
        elseif AutoCastMode == "Instant" then --This should work for now
            if rod then
                local lureValue = rod['values']['lure'].Value

                if lureValue <= .001 then
                    rod.events.cast:FireServer(100, 1)
                end
            end
        end
    end
end)
--Find the fuckass casting ui
--Shaking
AutoShakeActive = false
ShakeCheckbox = FishingSection:Checkbox({
    Value = false,
    Label = "Auto Shake",
    Callback = function(self, Value: boolean)
        if Value then
            AutoShakeActive = true
            AutoShakeCombo = ConfigSection:Combo({
                Label = "Shake Config",
                Items = {"Navigation", "Mouse -- Patched"},
                Selected = "Navigation",
                Callback = function(self, ComboValue: string)
                    AutoShakeMode = ComboValue
                end
            })
        else
            AutoShakeActive = false
            if AutoShakeCombo then
                AutoShakeCombo:Destroy()
                AutoShakeCombo = nil
            end
        end
    end
})
AutoShakeRS = RunService.Heartbeat:Connect(function()
    if AutoShakeActive then
        if FindChild(LocalPlayer.PlayerGui, 'shakeui') and FindChild(LocalPlayer.PlayerGui['shakeui'], 'safezone') and FindChild(LocalPlayer.PlayerGui['shakeui']['safezone'], 'button') then
            if AutoShakeMode == "Navigation" then
                GuiService.SelectedObject = LocalPlayer.PlayerGui['shakeui']['safezone']['button']
                if GuiService.SelectedObject == LocalPlayer.PlayerGui['shakeui']['safezone']['button'] then
                    game:GetService('VirtualInputManager'):SendKeyEvent(true, Enum.KeyCode.Return, false, game)
                    game:GetService('VirtualInputManager'):SendKeyEvent(false, Enum.KeyCode.Return, false, game)
                end
            elseif AutoShakeMode == "Mouse -- Patched" then
                --vim:SendMouseButtonEvent(midX, midY, 0, true, game, 0) --Change midX midY to the pos of the button using a function. 
                --wait(0.2)
                --vim:SendMouseButtonEvent(midX, midY, 0, false, game, 0)
            end
        end
    end
end)
--make a mouse version, using vim at the button's pos
--Reeling
AutoReelActive = false
AutoReelMode = "Clamp"
ReelCheckbox = FishingSection:Checkbox({
    Value = false,
    Label = "Auto Reel",
    Callback = function(self, Value: boolean)
        if Value then
            AutoReelActive = true
            AutoReelCombo = ConfigSection:Combo({
                Label = "Reel Config",
                Items = {"Clamp", "Instant"},
                Selected = AutoReelMode,
                Callback = function(self, ComboValue: string)
                    AutoReelMode = ComboValue
                end
            })
        else
            AutoReelActive = false
            if AutoReelCombo and AutoReelText then
                AutoReelCombo:Destroy()
                AutoReelCombo = nil
            end
        end
    end
})
AutoReelRS = RunService.Heartbeat:Connect(function()
    if AutoReelActive then
        if AutoReelMode == "Clamp" then
            local ReelUI = LocalPlayer.PlayerGui:FindFirstChild("reel")
            if not ReelUI then return end
    
            local Bar = ReelUI:FindFirstChild("bar")
            if not Bar then return end
    
            local PlayerBar = Bar:FindFirstChild("playerbar")
            local TargetBar = Bar:FindFirstChild("fish")
            if not PlayerBar or not TargetBar then return end

            local AbsoluteBarSize = PlayerBar.Size.X.Scale / 2
            local BarOffsetX = 0 + (AbsoluteBarSize)
            local BarOffsetZ = 1 - (AbsoluteBarSize)
            local unfiltered = PlayerBar.Position:Lerp(TargetBar.Position, 0.7)
            local clampedX = math.clamp(unfiltered.X.Scale, BarOffsetX, BarOffsetZ)
            local newPos = UDim2.new(clampedX, 0, unfiltered.Y.Scale, 0)
    
            PlayerBar.Position = newPos
        elseif AutoReelMode == "Instant" then
            local ReelUI = LocalPlayer.PlayerGui:FindFirstChild("reel")
            if not ReelUI then return end

            local Bar = ReelUI:FindFirstChild("bar")
            if not Bar then return end

            local PlayerBar = Bar:FindFirstChild("playerbar")
            local TargetBar = Bar:FindFirstChild("fish")
            if not PlayerBar or not TargetBar then return end

            local args = {100, true}
            game:GetService("ReplicatedStorage"):WaitForChild("events"):WaitForChild("reelfinished "):FireServer(unpack(args))
        end
    end
end)
FishingSection:Separator({
    Text = "Master Switch"
})
FishingSection:Checkbox({
    Label = "Auto Farm",
    Value = false,
    Callback = function(self, Value: boolean)
        if Value then
            CastCheckbox:SetValue(true)
            ShakeCheckbox:SetValue(true)    
            ReelCheckbox:SetValue(true)
        else
            CastCheckbox:SetValue(false)
            ShakeCheckbox:SetValue(false)
            ReelCheckbox:SetValue(false)
        end
    end
})

--//Character
CharSection:Separator({
    Text = "Character Mods"
})
WalkspeedValue = 16
CharSection:Checkbox({
    Label = "Walk Speed",
    Value = false,
    Callback = function(self, Value: boolean)
        if Value then
            WalkspeedActive = true
        else
            humanoid.WalkSpeed = 16
            WalkspeedActive = false
        end
    end
})
WalkspeedSlider = CharSection:SliderInt({
    Label = "Walk Speed Value",
    Min = 16,
    Max = 100,
    Value = 16,
    Callback = function(self, SliderValue: number)
        WalkspeedValue = SliderValue
    end
})
WalkspeedRS = RunService.Heartbeat:Connect(function()
    if WalkspeedActive then
        humanoid.WalkSpeed = WalkspeedValue
    end
end)
loadstring(game:HttpGet('https://raw.githubusercontent.com/warrrenmlr/Guacamole/main/NoClip.lua'))()
NoClipCheck = CharSection:Checkbox({
    Label = "Noclip",
    Value = false,
    Callback = function(self, Value: boolean)
        if Value then
            noclip()
        else
            clip()
        end
    end
})
Anti_afk = false
CharSection:Checkbox({
    Label = "Anti-afk",
    Value = false,
    Callback = function(self, Value: boolean)
        if Value then
            Anti_afk = true
        else
            Anti_afk = false
        end
    end
})
AntiAfkConnection = game:GetService("Players").LocalPlayer.Idled:connect(function()
    if not Anti_afk then return end
    VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)
CharSection:Label({
    Text = " "
})
CharSection:Separator({
    Text = "Selling"
})
CharSection:Button({
    Text = "Sell All",
    Callback = function()
        savedCFrame = rootPart.CFrame
        rootPart.CFrame = CFrame.new(379, 135, 233)
        local args = {
            {
                voice = 12,
                idle = workspace:WaitForChild("world"):WaitForChild("npcs"):WaitForChild("Marc Merchant"):WaitForChild("description"):WaitForChild("idle"),
                npc = workspace:WaitForChild("world"):WaitForChild("npcs"):WaitForChild("Marc Merchant")
            }
        }
        game:GetService("ReplicatedStorage"):WaitForChild("events"):WaitForChild("SellAll"):InvokeServer(unpack(args))
        rootPart.CFrame = savedCFrame
    end
})
--This can be improved to be able to sell from anywhere, figure out how. 
CharSection:Label({
    Text = " "
})
CharSection:Separator({
    Text = "Character Checks"
})
DisableOxygenWater = CharSection:Checkbox({
    Label = "Disable Oxygen/Water",
    Value = false,
    Callback = function(self, Value: boolean)
        if Value then
            game.Players.LocalPlayer.Character.Resources.oxygen.Disabled = true
        else
            game.Players.LocalPlayer.Character.Resources.oxygen.Enabled = true
        end
    end
})
DisableOxygenPeak = CharSection:Checkbox({
    Label = "Disable Oxygen/Peak",
    Value = false,
    Callback = function(self, Value: boolean)
        if Value then
            game.Players.LocalPlayer.Character.Resources["oxygen(peaks)"].Disabled = true
        else
            game.Players.LocalPlayer.Character.Resources["oxygen(peaks)"].Enabled = true
        end
    end
})
DisableTemp = CharSection:Checkbox({
    Label = "Disable Temperature",
    Value = false,
    Callback = function(self, Value: boolean)
        if Value then
            local char = getchar()
            char:SetAttribute("Glimmerfin_Suit", 3)
        else 
            local char = getchar()
            char:SetAttribute("Glimmerfin_Suit", nil)
        end
    end
})
CharSection:Separator()
CharSection:Checkbox({
    Label = "Disable All",
    Value = false,
    Callback = function(self, Value: boolean)
        if Value then
            DisableOxygenWater:SetValue(true)
            DisableOxygenPeak:SetValue(true)
            DisableTemp:SetValue(true)
        else
            DisableOxygenWater:SetValue(false)
            DisableOxygenPeak:SetValue(false)
            DisableTemp:SetValue(false)
        end
    end
})

--//Teleports (YAY)

--gooning
local IslandSelected = "None"
local RodSelected = "None"
local TotemSelected = "None"

TPSection:Separator({
    Text = "Islands"
})
TPSection:Button({
    Text = "Teleport",
    Callback = function()
        rootPart = gethrp()
        if IslandSelected == "Moosewood" then rootPart.CFrame = CFrame.new(379, 134.500519, 233, -0.0087489672, -7.38644559e-08, 0.999961734, 8.76254873e-08, 1, 7.46339452e-08, -0.999961734, 8.8275101e-08, -0.0087489672)
        elseif IslandSelected == "Roslit" then rootPart.CFrame = CFrame.new(-1472, 132.525513, 707, -0.63675338, 1.03534902e-07, -0.77106756, 4.58455922e-08, 1, 9.64151212e-08, 0.77106756, 2.60426045e-08, -0.63675338)
        elseif IslandSelected == "Forsaken" then rootPart.CFrame = CFrame.new(-2491, 133.250015, 1561, -0.0897718072, 5.20187236e-08, -0.995962381, 4.56286315e-08, 1, 4.81168385e-08, 0.995962381, -4.11248635e-08, -0.0897718072)
        elseif IslandSelected == "Sunstone" then rootPart.CFrame = CFrame.new(-934.683289, 131.078827, -1114.61316, -0.930418491, -1.44911478e-08, 0.366498947, -1.0210246e-08, 1, 1.36189913e-08, -0.366498947, 8.92931684e-09, -0.930418491)
        elseif IslandSelected == "Statue of Sovereignty" then rootPart.CFrame = CFrame.new(25.0759411, 159.014709, -1037.81238, -0.998026907, -9.55964907e-08, -0.0627873242, -9.36928757e-08, 1, -3.32628041e-08, 0.0627873242, -2.73144494e-08, -0.998026907)
        elseif IslandSelected == "Terrapin" then rootPart.CFrame = CFrame.new(-214.197174, 142.048325, 1959.00488, -0.601257265, -4.02501037e-08, -0.799055517, 3.06568815e-08, 1, -7.34401766e-08, 0.799055517, -6.86529873e-08, -0.601257265)
        elseif IslandSelected == "Grand Reef" then rootPart.CFrame = CFrame.new(-3521.14624, 133.599274, 556.894836, 0.121795133, -4.11392236e-08, -0.992555261, -1.61436269e-08, 1, -4.34287557e-08, 0.992555261, 2.13128537e-08, 0.121795133)
        elseif IslandSelected == "Depths" then rootPart.CFrame = CFrame.new(948.953979, -711.557678, 1261.69958, 0.182334363, -2.2499961e-08, 0.983236611, 8.08773422e-08, 1, 7.88543009e-09, -0.983236611, 7.80837794e-08, 0.182334363)
        elseif IslandSelected == "Vents" then rootPart.CFrame = CFrame.new(-3183.45728, -2039.26697, 4041.78955, -0.521103561, -3.29611964e-08, -0.853493452, -7.75835218e-08, 1, 8.74974937e-09, 0.853493452, 7.07765508e-08, -0.521103561)
        elseif IslandSelected == "Veil of the Forsaken" then rootPart.CFrame = CFrame.new(-2516.62598, -11222.9072, 6916.00684, -0.318201721, 2.7339027e-08, -0.948023021, 1.35029419e-08, 1, 2.43057041e-08, 0.948023021, -5.06698239e-09, -0.318201721)
        elseif IslandSelected == "Calm Zone" then rootPart.CFrame = CFrame.new(-4325.91309, -11183.8809, 3675.59863, 0.99972415, -5.00215052e-08, 0.0234867744, 5.10816811e-08, 1, -4.4539437e-08, -0.0234867744, 4.57268925e-08, 0.99972415)
        elseif IslandSelected == "Kraken Pool" then rootPart.CFrame = CFrame.new(-4261, -1000.55194, 2020, -0.975134373, 5.13557161e-08, 0.221614376, 3.66724144e-08, 1, -7.03708025e-08, -0.221614376, -6.04938535e-08, -0.975134373)
        elseif IslandSelected == "Ancient Isles" then rootPart.CFrame = CFrame.new(6040.07373, 197.256866, 328.324249, -0.116590187, 1.17312155e-07, 0.993180096, 5.7717596e-08, 1, -1.11342189e-07, -0.993180096, 4.43425634e-08, -0.116590187)
        elseif IslandSelected == "Luminescent Cavern" then rootPart.CFrame = CFrame.new(-1036.55151, -335.656372, -4259.98096, -0.585558355, -4.2280206e-09, -0.810630262, -2.1990024e-08, 1, 1.06687619e-08, 0.810630262, 2.40729605e-08, -0.585558355)
        elseif IslandSelected == "Crimson Cavern" then rootPart.CFrame = CFrame.new(-1029.89001, -366.06134, -4820.80127, 0.412652045, 2.71868696e-08, 0.910888731, -7.90949315e-08, 1, 5.98516037e-09, -0.910888731, -7.45164712e-08, 0.412652045)
        elseif IslandSelected == "Snowburrow" then rootPart.CFrame = CFrame.new(2760.78296, 97.9428635, 2603.76758, -0.997252762, 8.7182606e-08, -0.0740736872, 8.09470464e-08, 1, 8.7182606e-08, 0.0740736872, 8.09470464e-08, -0.997252762)
        elseif IslandSelected == "Abyssal Zenith" then rootPart.CFrame = CFrame.new(-13569.0381, -11050.1885, 119.314453, 0.0540816896, 6.4094003e-08, 0.998536527, 7.12953323e-08, 1, -6.8049367e-08, -0.998536527, 7.48712168e-08, 0.0540816896)
        elseif IslandSelected == "Challengers Deep" then rootPart.CFrame = CFrame.new(720.557068, -3360.5, -1579.25745, 0.819586158, -7.00291991e-10, -0.572955966, -4.85594853e-09, 1, -8.16844636e-09, 0.572955966, 9.47698986e-09, 0.819586158)
        elseif IslandSelected == "Carrot Garden" then rootPart.CFrame = CFrame.new(3729.50049, -1127.98987, -1065.89844, 0.762654722, 1.07652355e-07, 0.646805823, -1.15787479e-07, 1, -2.99108116e-08, -0.646805823, -5.20803916e-08, 0.762654722)
        elseif IslandSelected == "Desolate Deep" then rootPart.CFrame = CFrame.new(-1627.25146, -231.073059, -2895.55884, 0.88377732, 3.31547128e-08, 0.467907727, -5.91852611e-09, 1, -5.96785483e-08, -0.467907727, 4.99732202e-08, 0.88377732)
        elseif IslandSelected == "Mushgrove" then rootPart.CFrame = CFrame.new(2658.37427, 132.500839, -748.650391, -0.880901337, 1.93214582e-08, 0.473299891, 4.66938808e-08, 1, 4.60833469e-08, -0.473299891, 6.26950936e-08, -0.880901337)
        elseif IslandSelected == "Castaway Cliffs" then rootPart.CFrame = CFrame.new(587.313232, 161.909912, -1872.35388, -0.527726173, 2.23494308e-08, -0.849414527, -5.25887884e-08, 1, 5.89840532e-08, 0.849414527, 7.57971108e-08, -0.527726173)
        elseif IslandSelected == "Cyrogenic Canal" then rootPart.CFrame = CFrame.new(20049.5312, 513.028137, 5424.70215, 0.433577508, 1.01997486e-07, -0.901116312, -7.42102344e-08, 1, 7.74834561e-08, 0.901116312, 3.32769652e-08, 0.433577508)
        elseif IslandSelected == "Frigid Cavern" then rootPart.CFrame = CFrame.new(19914.9316, 437.396027, 5571.72412, -0.860729158, -6.00912315e-08, 0.509063184, -1.34855274e-08, 1, 9.52413188e-08, -0.509063184, 7.51119913e-08, -0.860729158)
        elseif IslandSelected == "Glacial Grotto" then rootPart.CFrame = CFrame.new(20036.3086, 883.186401, 5639.41504, 0.798626423, -5.32845092e-08, -0.601827085, 4.65283456e-08, 1, -2.67946465e-08, 0.601827085, -6.60310473e-09, 0.798626423)
        elseif IslandSelected == "Overgrowth Caves" then rootPart.CFrame = CFrame.new(20298.8828, 271.444397, 5512.57031, -0.990273714, -7.93321888e-08, -0.139132828, -7.94836836e-08, 1, -4.46755122e-09, 0.139132828, 6.63469146e-09, -0.990273714)
        elseif IslandSelected == "Snowcap" then rootPart.CFrame = CFrame.new(2684.09937, 152.555817, 2402.44312, 0.719941974, 8.96485908e-09, -0.694034278, 8.1777614e-08, 1, 9.77473249e-08, 0.694034278, -1.27128871e-07, 0.719941974)
        elseif IslandSelected == "Vertigo" then rootPart.CFrame = CFrame.new(-107.755943, -731.934021, 1206.59448, -0.760893345, -6.35032416e-10, 0.648876965, 1.70968644e-08, 1, 2.10269793e-08, -0.648876965, 2.70930496e-08, -0.760893345)
        elseif IslandSelected == "Treasure Island" then rootPart.CFrame = CFrame.new(8324.10156, 166.000092, -17263.0586, 0.196686223, 8.05922795e-08, -0.980466485, 5.055022e-08, 1, 9.23385031e-08, 0.980466485, -6.77245069e-08, 0.196686223)
        end
        --Finish the Islands, check the "Zones" folder. If it is a smaller area, ie; Brine Pool, Zeus/Poseiden, add to the other areas
    end
})
TPSection:Combo({
    Label = "Select Island",
    Items = {"Abyssal Zenith", "Ancient Isles", "Calm Zone", "Carrot Garden", "Castaway Cliffs", "Challengers Deep", "Crimson Cavern", "Cyrogenic Canal", "Depths", "Desolate Deep", "Forsaken", "Frigid Cavern", "Glacial Grotto", "Grand Reef", "Kraken Pool", "Luminescent Cavern", "Moosewood", "Mushgrove", "Overgrowth Caves", "Roslit", "Snowburrow", "Snowcap", "Statue of Sovereignty", "Sunstone", "Terrapin", "Treasure Island", "Veil of the Forsaken", "Vents", "Vertigo"},
    Selected = " ",
    Callback = function(self, ComboValue: string)
        IslandSelected = ComboValue
    end
})
TPSection:Separator({
    Text = "Other Areas"
})
TPSection:Button({
    Text = "Teleport",
    Callback = function()
        rootPart = gethrp()
        if AreaSelected == "Enchant Altar" then rootPart.CFrame = CFrame.new(1310.24133, -802.427002, -87.5914993, -0.985269368, 3.25473373e-08, -0.171009466, 4.85704383e-08, 1, -8.95133354e-08, 0.171009466, -9.65007558e-08, -0.985269368)
        elseif AreaSelected == "Heaven's Rod Crystals" then rootPart.CFrame = CFrame.new(19925, 1138, 5359)
        elseif AreaSelected == "Poseiden's Rod Room" then rootPart.CFrame = CFrame.new(-4032.06201, -558.227417, 931.784973, -0.0960001573, -7.7896587e-09, -0.995381296, 1.65489951e-08, 1, -9.42188105e-09, 0.995381296, -1.73770633e-08, -0.0960001573)
        elseif AreaSelected == "Zeus' Rod Room" then rootPart.CFrame = CFrame.new(-4300.58643, -628.023682, 2689.39844, -0.999980271, 1.35182923e-08, 0.00628608232, 1.34919e-08, 1, -4.24093516e-09, -0.00628608232, -4.1560404e-09, -0.999980271)
        elseif AreaSelected == "RoRed" then rootPart.CFrame = CFrame.new(-1921.97266, 262.816711, 114.130188, -0.999969184, 2.99711935e-08, 0.00784904789, 2.96775493e-08, 1, -3.75277054e-08, -0.00784904789, -3.72936064e-08, -0.999969184)
        elseif AreaSelected == "Brine Pool" then rootPart.CFrame = CFrame.new(-1778.18701, -142.693146, -3379.70044, -0.999359667, -1.45283501e-08, 0.0357799828, -1.6112061e-08, 1, -4.39741719e-08, -0.0357799828, -4.45225048e-08, -0.999359667)
        elseif AreaSelected == "Blue Moon" then rootPart.CFrame = CFrame.new(2744.06348, 131.499985, 2514.32104, -0.0497323647, 7.55791802e-08, 0.998762608, -7.36654684e-08, 1, -7.93409143e-08, -0.998762608, -7.75201201e-08, -0.0497323647)
        end
    end
})
TPSection:Combo({
    Label = "Select Area",
    Items = {"Blue Moon", "Brine Pool", "Enchant Altar", "Heaven's Rod Crystals", "Poseiden's Rod Room", "RoRed", "Zeus' Rod Room"},
    Selected = " ",
    Callback = function(self, ComboValue: string)
        AreaSelected = ComboValue
    end
})
TPSection:Separator({
    Text = "Rods"
})
TPSection:Button({
    Text = "Teleport",
    Callback = function()
        rootPart = gethrp()
        if RodSelected == "Arctic" then rootPart.CFrame = CFrame.new(19579, 132.670105, 5302.99951, -0.989157617, 2.74707581e-08, 0.146857932, 3.0056956e-08, 1, 1.53911337e-08, -0.146857932, 1.96383585e-08, -0.989157617)
        elseif RodSelected == "Trident" then rootPart.CFrame = CFrame.new(-1484.0968, -225.779587, -2203.46899, -0.999359787, -6.51367458e-08, 0.0357769504, -6.34668069e-08, 1, 4.78121862e-08, -0.0357769504, 4.55109266e-08, -0.999359787)
        elseif RodSelected == "Depthseeker" then rootPart.CFrame = CFrame.new(-4461.50049, -605.662903, 1871.19141, -0.741979539, -2.26010695e-08, 0.670422494, -3.49336808e-08, 1, -4.95062213e-09, -0.670422494, -2.70935878e-08, -0.741979539)
        elseif RodSelected == "Champions" then rootPart.CFrame = CFrame.new(-4271.09277, -603.40332, 1839.91272, 0.0706048757, 1.27019879e-08, 0.997504354, 1.78159087e-08, 1, -1.39948035e-08, -0.997504354, 1.87595468e-08, 0.0706048757)
        elseif RodSelected == "Abyssal Specter" then rootPart.CFrame = CFrame.new(-3802.74048, -566.771729, 1863.5957, -0.976860702, 3.87108656e-08, 0.21387656, 6.197034e-08, 1, 1.02047281e-07, -0.21387656, 1.12939979e-07, -0.976860702)
        elseif RodSelected == "Tempest" then rootPart.CFrame = CFrame.new(-4930.92334, -595.247437, 1851.2168, -0.836759686, -2.18231158e-08, -0.547570288, -1.14491505e-09, 1, -3.81048757e-08, 0.547570288, -3.12577022e-08, -0.836759686)
        elseif RodSelected == "Zeus" then rootPart.CFrame = CFrame.new(-4276.65381, -627.110046, 2661.02954, -0.516671538, -4.2293653e-09, -0.856183708, -2.78619279e-08, 1, 1.18737367e-08, 0.856183708, 2.99897494e-08, -0.516671538)
        elseif RodSelected == "Heavens" then rootPart.CFrame = CFrame.new(20027.0742, -467.665955, 7112.38916, -0.995963216, 9.28933486e-10, 0.0897620246, 3.86838472e-09, 1, 3.25731904e-08, -0.0897620246, 3.27889325e-08, -0.995963216)
        elseif RodSelected == "Steady" then rootPart.CFrame = CFrame.new(-1496.32764, 140.200256, 759.762634, 0.051527448, 2.6940004e-08, 0.998671591, -7.14333481e-09, 1, -2.66072711e-08, -0.998671591, -5.76284043e-09, 0.051527448)
        elseif RodSelected == "EPR" then rootPart.CFrame = CFrame.new(-4358.51416, -11172.835, 3713.92456, -0.97176069, 8.63758842e-09, 0.235968664, 9.074685e-09, 1, 7.66345376e-10, -0.235968664, 2.8860454e-09, -0.97176069)
        elseif RodSelected == "Kraken" then rootPart.CFrame = CFrame.new(-4410.27832, -996.260437, 2054.57886, 0.0296807699, 5.77681298e-08, 0.999559402, 6.71119438e-10, 1, -5.78135193e-08, -0.999559402, 2.38677367e-09, 0.0296807699)
        elseif RodSelected == "Long" then rootPart.CFrame = CFrame.new(479.632507, 174.5, 145.371094, -0.785418391, -1.01368208e-07, -0.618965268, -7.83254563e-08, 1, -6.43815667e-08, 0.618965268, -2.08572848e-09, -0.785418391)
        elseif RodSelected == "Scarlet Spincaster" then rootPart.CFrame = CFrame.new(-1034.39404, -268.949249, -4939.58545, -0.106924728, -7.889847e-09, -0.994267106, 1.90019467e-08, 1, -9.97883287e-09, 0.994267106, -1.99599945e-08, -0.106924728)
        elseif RodSelected == "Ruinous Oath" then rootPart.CFrame = CFrame.new(-1044.85022, -340.546356, -4880.63184, 0.975933552, -6.3142636e-08, -0.218068153, 4.21573887e-08, 1, -1.00885096e-07, 0.218068153, 8.92639704e-08, 0.975933552)
        elseif RodSelected == "Luminescent Oath" then rootPart.CFrame = CFrame.new(-1138.76074, -331.440369, -4320.37061, -0.880930841, 6.39723963e-09, -0.473245084, 6.09781958e-09, 1, 2.16691687e-09, 0.473245084, -9.76859149e-10, -0.880930841)
        elseif RodSelected == "The Boom Ball" then rootPart.CFrame = CFrame.new(-1300.66016, -902.91394, -3479.41626, -0.0524000153, -9.83699948e-08, -0.998626173, 1.78932016e-08, 1, -9.94442217e-08, 0.998626173, -2.30794992e-08, -0.0524000153)
        elseif RodSelected == "Wicked Fang" then rootPart.CFrame = CFrame.new(-1066.26892, -309.776855, -4971.12598, 0.969451904, 6.59864208e-09, 0.245281473, -1.91474676e-08, 1, 4.87762364e-08, -0.245281473, -5.19827346e-08, 0.969451904)
        elseif RodSelected == "Cerulean Fang" then rootPart.CFrame = CFrame.new(-931.566772, -335.256805, -4175.03613, 0.789057672, 4.03119538e-09, -0.614319086, -5.27717781e-09, 1, -2.16177853e-10, 0.614319086, 3.41244788e-09, 0.789057672)
        elseif RodSelected == "Carbon" then rootPart.CFrame = CFrame.new(448.864288, 150.500015, 227.262787, 0.691453934, 2.8477313e-08, -0.722420573, -4.48060398e-08, 1, -3.46612339e-09, 0.722420573, 3.47654669e-08, 0.691453934)
        elseif RodSelected == "Plastic" then rootPart.CFrame = CFrame.new(451.604126, 150.515289, 233.62764, 0.834320724, -1.81552871e-08, -0.551279366, -3.84692953e-08, 1, -9.11534528e-08, 0.551279366, 9.72585426e-08, 0.834320724)
        elseif RodSelected == "Training" then rootPart.CFrame = CFrame.new(457.239868, 150.525452, 235.265793, 0.999934673, -3.18575277e-09, -0.0114286672, 3.32141914e-09, 1, 1.18517329e-08, 0.0114286672, -1.18889183e-08, 0.999934673)
        elseif RodSelected == "Flimsy" then rootPart.CFrame = CFrame.new(469.770264, 150.527557, 233.775757, 0.971735597, -4.98373502e-08, -0.236071765, 3.63464601e-08, 1, -6.14991009e-08, 0.236071765, 5.11804927e-08, 0.971735597)
        elseif RodSelected == "Lucky" then rootPart.CFrame = CFrame.new(447.897522, 150.500015, 225.595215, 0.848549366, -1.45751606e-08, 0.529116213, 1.86923241e-08, 1, -2.43084353e-09, -0.529116213, 1.19531016e-08, 0.848549366)
        elseif RodSelected == "Fast" then rootPart.CFrame = CFrame.new(447.657318, 150.500015, 224.194946, 0.992124438, 3.08115808e-08, 0.125256166, -4.20297965e-08, 1, 8.69195134e-08, -0.125256166, -9.14994658e-08, 0.992124438)
        elseif RodSelected == "Rapid" then rootPart.CFrame = CFrame.new(-1497.0387, 141.259079, 756.069153, -0.241872042, -5.90435301e-09, 0.970308185, -2.70652496e-08, 1, -6.61618649e-10, -0.970308185, -2.64216595e-08, -0.241872042)
        elseif RodSelected == "Scurvy" then rootPart.CFrame = CFrame.new(-2823.63013, 214.428162, 1512.35596, -0.0278894193, -6.06409358e-08, 0.99961102, 3.26394591e-08, 1, 6.15751858e-08, -0.99961102, 3.43440583e-08, -0.0278894193)
        elseif RodSelected == "Leviathan's Fang" then rootPart.CFrame = CFrame.new(-2296.8501, -11186.4043, 7130.15527, -0.997687042, -9.32708466e-10, 0.0679748952, -2.01626826e-09, 1, -1.58719793e-08, -0.0679748952, -1.59723239e-08, -0.997687042)
        elseif RodSelected == "Volcanic" then rootPart.CFrame = CFrame.new(-3181.58716, -2036.87378, 4024.04224, 0.601813734, -8.68091554e-09, -0.798636496, 2.92980502e-08, 1, 1.1207919e-08, 0.798636496, -3.01435712e-08, 0.601813734)
        elseif RodSelected == "ROTZ" then rootPart.CFrame = CFrame.new(-13630.9619, -11035.2109, 352.763855, -0.648131251, 4.62506335e-08, -0.761528671, -2.72810254e-08, 1, 8.39526066e-08, 0.761528671, 7.5187593e-08, -0.648131251)
        elseif RodSelected == "Challenger's" then rootPart.CFrame = CFrame.new(741.868164, -3354.94165, -1532.92053, -0.731869161, -2.5035872e-08, 0.681445122, -8.98398334e-09, 1, 2.70906195e-08, -0.681445122, 1.37046978e-08, -0.731869161)
        elseif RodSelected == "Poseiden" then rootPart.CFrame = CFrame.new(-4079.56885, -558.227356, 895.156006, -0.0164855104, -1.15397674e-08, 0.999864101, -5.73075702e-08, 1, 1.05964633e-08, -0.999864101, -5.71250958e-08, -0.0164855104)
        elseif RodSelected == "Craftable Rods" then rootPart.CFrame = CFrame.new(-3160.99707, -745.914001, 1685.14954, 0.999777436, -6.8997843e-09, -0.0210958682, 7.14184623e-09, 1, 1.13990319e-08, 0.0210958682, -1.15471588e-08, 0.999777436)
        elseif RodSelected == "Avalanche" then rootPart.CFrame = CFrame.new(19774.4609, 415.437103, 5415.60889, -0.625305474, -1.43438399e-08, 0.78038007, -7.79397595e-08, 1, -4.40712427e-08, -0.78038007, -8.83806237e-08, -0.625305474)
        elseif RodSelected == "Summit" then rootPart.CFrame = CFrame.new(20212.6895, 736.668823, 5707.71533, -0.560651481, -2.9132103e-08, 0.828051865, -9.69513394e-08, 1, -3.04616314e-08, -0.828051865, -9.73590986e-08, -0.560651481)
        elseif RodSelected == "Crystalized" then rootPart.CFrame = CFrame.new(19239.5781, 398.932648, 6032.2959, -0.998535097, -4.35129586e-08, 0.0541079156, -4.40874643e-08, 1, -9.42412548e-09, -0.0541079156, -1.17958008e-08, -0.998535097)
        elseif RodSelected == "ROTEO" then rootPart.CFrame = CFrame.new(2233.50073, -804.182312, 1032.38574, -0.996195793, -1.04444027e-07, -0.0871431604, -1.06290585e-07, 1, 1.65499365e-08, 0.0871431604, 2.57494754e-08, -0.996195793)
        elseif RodSelected == "Pheonix" then rootPart.CFrame = CFrame.new(5964.7041, 269.624573, 852.240784, -0.0175237078, -9.24005228e-09, -0.999846458, -6.64772182e-10, 1, -9.22982046e-09, 0.999846458, 5.0292942e-10, -0.0175237078)
        elseif RodSelected == "Kings" then rootPart.CFrame = CFrame.new(1381.28271, -807.047363, -305.408264, -0.639446318, 3.93287962e-08, 0.768835783, -2.0611207e-08, 1, -6.82961954e-08, -0.768835783, -5.95183849e-08, -0.639446318)
        elseif RodSelected == "Magnet" then rootPart.CFrame = CFrame.new(-238.999817, 141.848328, 1954.75354, -0.761560857, -1.35216238e-08, 0.648093462, -2.32623538e-08, 1, -6.47140164e-09, -0.648093462, -2.00045456e-08, -0.761560857)
        elseif RodSelected == "Wildflower" then rootPart.CFrame = CFrame.new(-220.479355, 141.848312, 1976.64124, -0.866460383, -1.20656818e-10, 0.499245852, -1.47499102e-09, 1, -2.31822539e-09, -0.499245852, -2.74503353e-09, -0.866460383)
        elseif RodSelected == "Stone" then rootPart.CFrame = CFrame.new(5496.95703, 143.496613, -315.895569, 0.0679773539, -3.77499312e-08, -0.997686863, 1.82503779e-09, 1, -3.77131073e-08, 0.997686863, 7.42820971e-10, 0.0679773539)
        elseif RodSelected == "Nocturnal" then rootPart.CFrame = CFrame.new(-144.072006, -515.299377, 1143.04382, 0.999722838, -2.04469259e-08, -0.0235419087, 2.01836539e-08, 1, -1.14207319e-08, 0.0235419087, 1.09424052e-08, 0.999722838)
        elseif RodSelected == "Aurora" then rootPart.CFrame = CFrame.new(-144.428192, -515.174377, 1133.78638, 0.974366844, -5.32533946e-08, 0.224965021, 4.66459014e-08, 1, 3.46861739e-08, -0.224965021, -2.3303361e-08, 0.974366844)
        elseif RodSelected == "Carrot" then rootPart.CFrame = CFrame.new(3723.27979, -1127.98987, -1065.00085, -0.996272504, -2.25826344e-08, 0.0862619877, -2.34490614e-08, 1, -9.03086761e-09, -0.0862619877, -1.1019968e-08, -0.996272504)
        elseif RodSelected == "Reinforced" then rootPart.CFrame = CFrame.new(-991.821594, -244.642151, -2692.99951, -0.0645503178, 6.72309e-08, -0.997914433, -8.64982042e-08, 1, 7.29665643e-08, 0.997914433, 9.10278217e-08, -0.0645503178)
        elseif RodSelected == "Brick" then rootPart.CFrame = CFrame.new(-32097.2246, 9997.24805, -23306.2734, 0.7797876, -6.1561396e-09, -0.626044214, -6.53081589e-09, 1, -1.79680431e-08, 0.626044214, 1.80998363e-08, 0.7797876)
        elseif RodSelected == "Magma" then rootPart.CFrame = CFrame.new(-1848.02527, 165.711136, 158.822266, -0.99967885, 4.95751955e-08, 0.0253426619, 4.91362364e-08, 1, -1.79437532e-08, -0.0253426619, -1.66927467e-08, -0.99967885)
        elseif RodSelected == "Rainbow Cluster" then rootPart.CFrame = CFrame.new(498.705353, -656.193848, -1744.03955, -0.999954402, 2.24328126e-10, 0.00954915211, -1.53593138e-10, 1, -3.95756885e-08, -0.00954915211, -3.9575351e-08, -0.999954402)
        elseif RodSelected == "Fungal" then rootPart.CFrame = CFrame.new(2594.86353, 132.539398, -726.013062, 0.59479332, -1.13717419e-07, -0.803878665, 3.92910806e-08, 1, -1.12389287e-07, 0.803878665, 3.52631346e-08, 0.59479332)
        elseif RodSelected == "ROTD" then rootPart.CFrame = CFrame.new(1704.56421, -902.527039, 1441.06213, -0.990758717, 4.38834613e-09, -0.135636285, 3.44347106e-09, 1, 7.20085547e-09, 0.135636285, 6.66725075e-09, -0.990758717)
        elseif RodSelected == "Destiny" then rootPart.CFrame = CFrame.new(985.152527, 131.320236, -1232.38232, -0.212983295, -3.48601792e-09, 0.977055848, 3.64859929e-08, 1, 1.1521271e-08, -0.977055848, 3.81026908e-08, -0.212983295)
        end
        --Need to add:Great Dreamer, Destiny, GROO.
    end
})
TPSection:Combo({
    Label = "Select Rod",
    Items = {"Abyssal Specter", "Arctic", "Aurora", "Avalanche", "Brick", "Carbon", "Carrot", "Cerulean Fang", "Challenger's", "Champions", "Craftable Rods", "Crystalized", "Depthseeker", "Destiny", "EPR", "Fast", "Flimsy", "Fungal", "Heavens", "Kings", "Kraken", "Leviathan's Fang", "Long", "Lucky", "Luminescent Oath", "Magma", "Magnet", "Nocturnal", "Phoenix", "Plastic", "Poseiden", "Rainbow Cluster", "Rapid", "Reinforced", "ROTD", "ROTEO", "ROTZ", "Ruinous Oath", "Scarlet Spincaster", "Scurvy", "Steady", "Stone", "Summit", "Tempest", "The Boom Ball", "Training", "Trident", "Volcanic", "Wicked Fang", "Wildflower", "Zeus"},
    Selected = " ",
    Callback = function(self, ComboValue: string)
        RodSelected = ComboValue
    end
})
TPSection:Separator({
    Text = "Items"
})
TPSection:Button({
    Text = "Teleport",
    Callback = function()
        rootPart = gethrp()
        if ItemSelected == "Advanced Glider" then rootPart.CFrame = CFrame.new(19940.7266, 1142.63428, 5551.15186, 0.988652289, 5.75821666e-08, 0.150222018, -5.89922138e-08, 1, 4.93016872e-09, -0.150222018, -1.37361518e-08, 0.988652289)
        elseif ItemSelected == "Glider" then rootPart.CFrame = CFrame.new(-1706.81238, 148.075653, 741.478149, 0.324767053, 4.65092391e-08, 0.945794046, 1.56686966e-08, 1, -5.45551266e-08, -0.945794046, 3.25370664e-08, 0.324767053)
        elseif ItemSelected == "Advanced Oxygen Tank" then rootPart.CFrame = CFrame.new(19949.7812, 1142.63428, 5544.86963, 0.966190517, 9.62017097e-08, 0.257829219, -9.23895769e-08, 1, -2.69006648e-08, -0.257829219, 2.17043361e-09, 0.966190517)
        elseif ItemSelected == "Intermediate Oxygen Tank" then rootPart.CFrame = CFrame.new(20217.5488, 736.668823, 5712.43115, -0.714436889, -1.00999458e-08, 0.699699938, -2.86929769e-09, 1, 1.15049517e-08, -0.699699938, 6.21191409e-09, -0.714436889)
        elseif ItemSelected == "Beginner Oxygen Tank" then rootPart.CFrame = CFrame.new(19778.5449, 415.437073, 5382.16016, -0.536020398, -5.07272802e-08, -0.844205022, 2.87305664e-08, 1, -7.8331027e-08, 0.844205022, -6.62415189e-08, -0.536020398)
        elseif ItemSelected == "Winter Cloak" then rootPart.CFrame = CFrame.new(19955.3887, 1142.63428, 5578.19727, -0.506656468, 4.6569248e-08, 0.862148046, 9.91168179e-08, 1, 4.23236557e-09, -0.862148046, 8.75977264e-08, -0.506656468)
        elseif ItemSelected == "Pickaxe" then rootPart.CFrame = CFrame.new(19776.8008, 415.437073, 5390.58594, -0.0985863879, -1.85099616e-08, -0.995128512, 6.70807481e-08, 1, -2.52461962e-08, 0.995128512, -6.92428941e-08, -0.0985863879)
        elseif ItemSelected == "Basic Diving Gear" then rootPart.CFrame = CFrame.new(374.541077, 134.456268, 247.726517, -0.170942634, -8.78970319e-09, 0.985280991, -6.85648516e-08, 1, -2.97473823e-09, -0.985280991, -6.80641534e-08, -0.170942634)
        elseif ItemSelected == "Advanced Diving Gear" then rootPart.CFrame = CFrame.new(-976.31665, -244.915085, -2690.77002, -0.892838955, -2.89606228e-09, 0.450376064, 1.26280204e-08, 1, 3.14644844e-08, -0.450376064, 3.37800756e-08, -0.892838955)
        elseif ItemSelected == "Flippers" then rootPart.CFrame = CFrame.new(-964.27948, -244.915131, -2701.38721, -0.946086526, 2.69355667e-08, -0.323914051, 1.06061036e-08, 1, 5.21782688e-08, 0.323914051, 4.5929692e-08, -0.946086526)
        elseif ItemSelected == "Super Flippers" then rootPart.CFrame = CFrame.new(-969.258057, -244.915085, -2699.62427, -0.941472232, -5.07502627e-08, -0.337090522, -4.08105798e-08, 1, -3.65724695e-08, 0.337090522, -2.06751025e-08, -0.941472232)
        elseif ItemSelected == "Tidebreaker" then rootPart.CFrame = CFrame.new(-1642.45862, -213.679443, -2851.07104, -0.468707204, 1.99005061e-08, -0.883353591, -1.88931004e-08, 1, 3.25530323e-08, 0.883353591, 3.19471276e-08, -0.468707204)
        elseif ItemSelected == "GPS" then rootPart.CFrame = CFrame.new(513.657104, 150.639252, 283.542175, -0.354338259, 3.31152172e-08, -0.935117304, 7.2016082e-10, 1, 3.51400153e-08, 0.935117304, 1.17780177e-08, -0.354338259)
        elseif ItemSelected == "Fish Radar" then rootPart.CFrame = CFrame.new(370.079926, 135.771698, 269.825195, -0.666514277, -6.81351082e-08, 0.74549228, -8.75686634e-10, 1, 9.06132129e-08, -0.74549228, 5.97421845e-08, -0.666514277)
        elseif ItemSelected == "Bait Crate" then rootPart.CFrame = CFrame.new(-1471.05981, 133.223862, 676.856018, 0.920824766, -2.26401795e-08, -0.389976621, 2.10392663e-08, 1, -8.3766647e-09, 0.389976621, -4.91381213e-10, 0.920824766)
        elseif ItemSelected == "Crab Cage" then rootPart.CFrame = CFrame.new(-1486.51648, 133.330093, 644.473328, 0.928140819, -1.75622112e-08, -0.372229308, 3.83835008e-08, 1, 4.85267542e-08, 0.372229308, -5.93271245e-08, 0.928140819)
        elseif ItemSelected == "Quality Bait Crate" then rootPart.CFrame = CFrame.new(-171.42099, 143.056229, 1922.8363, 0.74609834, -1.08392024e-08, 0.665835798, 8.87490259e-08, 1, -8.31680964e-08, -0.665835798, 1.21143856e-07, 0.74609834)
        end
    end
})
TPSection:Combo({
    Label = "Select Item",
    Items = {"Advanced Diving Gear", "Advanced Glider", "Advanced Oxygen Tank", "Bait Crate", "Basic Diving Gear", "Beginner Oxygen Tank", "Crab Cage", "Fish Radar", "Flippers", "Glider", "GPS", "Intermediate Oxygen Tank", "Pickaxe", "Quality Bait Crate", "Super Flippers", "Tidebreaker", "Winter Cloak"},
    Selected = "",
    Callback = function(self, ComboValue: string)
        ItemSelected = ComboValue
    end
})
TPSection:Separator({
    Text = "Totems"
})
TPSection:Button({
    Text = "Teleport",
    Callback = function()
        rootPart = gethrp()
        if TotemSelected == "Poseiden's Wrath" then rootPart.CFrame = CFrame.new(-3956.20801, -554.226868, 858.55719, 0.890935183, -1.85526492e-08, -0.454130471, -1.91369125e-08, 1, -7.83968446e-08, 0.454130471, 7.85371626e-08, 0.890935183)
        elseif TotemSelected == "Zeus' Storm" then rootPart.CFrame = CFrame.new(-4321.24414, -627.374756, 2682.8103, -0.632578552, 4.1859284e-08, 0.774496198, -1.22382611e-08, 1, -6.4042851e-08, -0.774496198, -4.99906214e-08, -0.632578552)
        elseif TotemSelected == "Blizzard" then rootPart.CFrame = CFrame.new(20144.0059, 742.952759, 5805.18555, 0.18735832, 1.34725608e-08, -0.982291639, 1.01557923e-07, 1, 3.30861845e-08, 0.982291639, -1.0595847e-07, 0.18735832)
        elseif TotemSelected == "Eclipse" then rootPart.CFrame = CFrame.new(5963.3623, 269.624573, 844.255981, 0.832969427, 4.00547115e-08, -0.553318977, -3.30790542e-08, 1, 2.25925216e-08, 0.553318977, -5.15611609e-10, 0.832969427)
        elseif TotemSelected == "Sundial" then rootPart.CFrame = CFrame.new(-1147.21411, 134.499985, -1073.51892, 0.838228881, 1.15413691e-07, 0.545318544, -6.53714309e-08, 1, -1.11159743e-07, -0.545318544, 5.75290535e-08, 0.838228881)
        elseif TotemSelected == "Meteor" then rootPart.CFrame = CFrame.new(-1951.95959, 275.35672, 231.425751, -0.024437597, -2.59491042e-08, -0.999701381, -1.12400429e-07, 1, -2.32092408e-08, 0.999701381, 1.11799679e-07, -0.024437597)
        elseif TotemSelected == "Tempest" then rootPart.CFrame = CFrame.new(33.7899475, 132.500015, 1942.93164, -0.605302036, 2.81888318e-10, -0.795995891, 3.45127091e-08, 1, -2.58904898e-08, 0.795995891, -4.31435403e-08, -0.605302036)
        elseif TotemSelected == "Aurora" then rootPart.CFrame = CFrame.new(-1810.39685, -136.927933, -3282.90698, -0.623881578, -6.49835883e-08, 0.781518877, -1.31892754e-08, 1, 7.26214608e-08, -0.781518877, 3.49995268e-08, -0.623881578)
        elseif TotemSelected == "Windset" then rootPart.CFrame = CFrame.new(2846.61206, 177.986038, 2704.24487, 0.29226321, 4.21565112e-08, -0.956337929, 1.00734546e-07, 1, 7.48663282e-08, 0.956337929, -1.18216946e-07, 0.29226321)
        elseif TotemSelected == "Smokescreen" then rootPart.CFrame = CFrame.new(2793.70874, 139.758942, -626.790161, 0.763318419, 1.46739225e-08, 0.646022379, -2.46154883e-08, 1, 6.37057473e-09, -0.646022379, -2.07649347e-08, 0.763318419)
        elseif TotemSelected == "Avalanche" then rootPart.CFrame = CFrame.new(19715.0039, 467.630585, 6058.90625, 0.191792861, 3.19824274e-08, 0.981435418, -7.77385534e-09, 1, -3.10682289e-08, -0.981435418, -1.67087244e-09, 0.191792861)
        end
    end
})
TPSection:Combo({
    Label = "Select Totem",
    Items = {"Avalanche", "Aurora", "Blizzard", "Eclipse", "Meteor", "Poseiden's Wrath", "Smokescreen", "Sundial", "Tempest", "Windset", "Zeus' Storm"},
    Selected = " ",
    Callback = function(self, ComboValue: string)
        TotemSelected = ComboValue
    end
})


--//Feet
CoordText = " "
DevSection:Button({
    Text = "Get Coords",
    Callback = function()
        CoordText = rootPart.CFrame
        if CoordTextBox then
            CoordTextBox:Destroy()
            CoordCopy:Destroy()
        end
        CoordTextBox = DevSection:InputText({
            Label = "Character Coords",
            Value = tostring(CoordText),
        })
        CoordCopy = DevSection:Button({
            Text = "Copy Coords",
            Callback = function()
                setclipboard(tostring(CoordText))
                CoordsCopied = DevSection:Label({
                    Text = "Coords Copied!"
                })
                wait(2)
                CoordsCopied:Destroy()
            end
        })
    end 
})

--//Teting
AutoStarfall = false
DevelopmentSection:Checkbox({
    Label = "Auto Starfall",
    Value = false,
    Callback = function(self, Value: boolean)
        if Value then
            AutoStarfall = true
        else
            AutoStarfall = false
        end
    end
})
AutoStarfallRS = RunService.Heartbeat:Connect(function()
    local child = workspace:FindFirstChild("StarCrater")
    if AutoStarfall and child then
        if isReelUI() or isShakeUI() then return end
        if FindRod() then
            vim.SendKeyEvent(true, Enum.KeyCode.One, false, game)
            wait(0.1)
            vim.SendKeyEvent(false, Enum.KeyCode.One, false, game)
        end
        wait(0.5)
        rootPart.CFrame = child:GetPivot()
        vim:SendKeyEvent(true, Enum.KeyCode.E, false, game)
        wait(0.1)
        vim:SendKeyEvent(false, Enum.KeyCode.E, false, game)
        wait(0.5)
    end
end)
