
--[[
    GROWBLOX ULTIMATE HUB
    Version 1.0.0
    GUI Framework for Roblox Studio
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local old = playerGui:FindFirstChild("GrowbloxHub")
if old then old:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "GrowbloxHub"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local Theme = {
    Background = Color3.fromRGB(15, 16, 25),
    Sidebar = Color3.fromRGB(22, 23, 35),
    Card = Color3.fromRGB(30, 31, 46),
    Purple = Color3.fromRGB(139, 92, 246),
    White = Color3.fromRGB(245, 245, 255),
    Muted = Color3.fromRGB(150, 150, 170),
    Green = Color3.fromRGB(65, 200, 135)
}

local function create(class, props, parent)
    local obj = Instance.new(class)
    for key, value in pairs(props) do
        obj[key] = value
    end
    obj.Parent = parent
    return obj
end

local function round(obj, radius)
    create("UICorner", {
        CornerRadius = UDim.new(0, radius)
    }, obj)
end

local function tween(obj, properties)
    TweenService:Create(
        obj,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad),
        properties
    ):Play()
end

-- MAIN WINDOW

local main = create("Frame", {
    Name = "Main",
    Size = UDim2.fromOffset(700, 450),
    Position = UDim2.new(0.5, -350, 0.5, -225),
    BackgroundColor3 = Theme.Background,
    BorderSizePixel = 0
}, gui)

round(main, 14)

create("UIStroke", {
    Color = Color3.fromRGB(75, 65, 110),
    Thickness = 1
}, main)

-- TOP BAR

local top = create("Frame", {
    Size = UDim2.new(1, 0, 0, 65),
    BackgroundColor3 = Theme.Sidebar,
    BorderSizePixel = 0
}, main)

round(top, 14)

create("TextLabel", {
    Position = UDim2.fromOffset(20, 8),
    Size = UDim2.fromOffset(350, 28),
    BackgroundTransparency = 1,
    Text = "✦ GROWBLOX ULTIMATE",
    TextColor3 = Theme.White,
    TextSize = 20,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left
}, top)

create("TextLabel", {
    Position = UDim2.fromOffset(22, 36),
    Size = UDim2.fromOffset(250, 18),
    BackgroundTransparency = 1,
    Text = "PREMIUM INTERFACE  •  V1.0",
    TextColor3 = Theme.Muted,
    TextSize = 10,
    Font = Enum.Font.Gotham
}, top)

local close = create("TextButton", {
    Position = UDim2.new(1, -48, 0, 17),
    Size = UDim2.fromOffset(30, 30),
    Text = "×",
    TextSize = 21,
    Font = Enum.Font.GothamBold,
    TextColor3 = Theme.White,
    BackgroundColor3 = Color3.fromRGB(180, 65, 80),
    BorderSizePixel = 0
}, top)

round(close, 8)

close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- MINIMIZE

local minimize = create("TextButton", {
    Position = UDim2.new(1, -87, 0, 17),
    Size = UDim2.fromOffset(30, 30),
    Text = "−",
    TextSize = 20,
    Font = Enum.Font.GothamBold,
    TextColor3 = Theme.White,
    BackgroundColor3 = Theme.Card,
    BorderSizePixel = 0
}, top)

round(minimize, 8)

local minimized = false

minimize.MouseButton1Click:Connect(function()
    minimized = not minimized

    for _, item in ipairs(main:GetChildren()) do
        if item ~= top and item:IsA("GuiObject") then
            item.Visible = not minimized
        end
    end

    tween(main, {
        Size = minimized
            and UDim2.fromOffset(700, 65)
            or UDim2.fromOffset(700, 450)
    })
end)

-- SIDEBAR

local sidebar = create("Frame", {
    Position = UDim2.fromOffset(12, 77),
    Size = UDim2.new(0, 155, 1, -89),
    BackgroundColor3 = Theme.Sidebar,
    BorderSizePixel = 0
}, main)

round(sidebar, 10)

create("UIPadding", {
    PaddingTop = UDim.new(0, 12),
    PaddingLeft = UDim.new(0, 9),
    PaddingRight = UDim.new(0, 9)
}, sidebar)

create("UIListLayout", {
    Padding = UDim.new(0, 8),
    SortOrder = Enum.SortOrder.LayoutOrder
}, sidebar)

-- CONTENT

local content = create("Frame", {
    Position = UDim2.fromOffset(179, 77),
    Size = UDim2.new(1, -191, 1, -89),
    BackgroundColor3 = Theme.Sidebar,
    BorderSizePixel = 0
}, main)

round(content, 10)

local function clearContent()
    for _, child in ipairs(content:GetChildren()) do
        child:Destroy()
    end
end

local function heading(title, subtitle)
    create("TextLabel", {
        Position = UDim2.fromOffset(20, 15),
        Size = UDim2.new(1, -40, 0, 30),
        BackgroundTransparency = 1,
        Text = title,
        TextColor3 = Theme.White,
        TextSize = 22,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left
    }, content)

    create("TextLabel", {
        Position = UDim2.fromOffset(21, 46),
        Size = UDim2.new(1, -40, 0, 22),
        BackgroundTransparency = 1,
        Text = subtitle,
        TextColor3 = Theme.Muted,
        TextSize = 11,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left
    }, content)
end

local function notification(message)
    local box = create("TextLabel", {
        Position = UDim2.new(1, -260, 1, -65),
        Size = UDim2.fromOffset(240, 42),
        BackgroundColor3 = Theme.Card,
        Text = message,
        TextColor3 = Theme.White,
        TextSize = 12,
        Font = Enum.Font.GothamBold,
        BorderSizePixel = 0
    }, gui)

    round(box, 9)

    task.delay(2, function()
        if box.Parent then
            box:Destroy()
        end
    end)
end

local function toggle(title, description, y)
    local card = create("Frame", {
        Position = UDim2.fromOffset(18, y),
        Size = UDim2.new(1, -36, 0, 65),
        BackgroundColor3 = Theme.Card,
        BorderSizePixel = 0
    }, content)

    round(card, 9)

    create("TextLabel", {
        Position = UDim2.fromOffset(13, 8),
        Size = UDim2.new(1, -110, 0, 22),
        BackgroundTransparency = 1,
        Text = title,
        TextColor3 = Theme.White,
        TextSize = 13,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left
    }, card)

    create("TextLabel", {
        Position = UDim2.fromOffset(13, 32),
        Size = UDim2.new(1, -110, 0, 20),
        BackgroundTransparency = 1,
        Text = description,
        TextColor3 = Theme.Muted,
        TextSize = 10,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left
    }, card)

    local enabled = false

    local button = create("TextButton", {
        Position = UDim2.new(1, -78, 0.5, -14),
        Size = UDim2.fromOffset(65, 28),
        BackgroundColor3 = Color3.fromRGB(65, 65, 80),
        Text = "OFF",
        TextColor3 = Theme.White,
        TextSize = 11,
        Font = Enum.Font.GothamBold,
        BorderSizePixel = 0
    }, card)

    round(button, 7)

    button.MouseButton1Click:Connect(function()
        enabled = not enabled

        tween(button, {
            BackgroundColor3 = enabled
                and Theme.Purple
                or Color3.fromRGB(65, 65, 80)
        })

        button.Text = enabled and "ON" or "OFF"

        notification(
            title .. (enabled and " Enabled" or " Disabled")
        )
    end)
end

local function itemCard(title, description, y)
    local card = create("Frame", {
        Position = UDim2.fromOffset(18, y),
        Size = UDim2.new(1, -36, 0, 65),
        BackgroundColor3 = Theme.Card,
        BorderSizePixel = 0
    }, content)

    round(card, 9)

    create("TextLabel", {
        Position = UDim2.fromOffset(13, 9),
        Size = UDim2.new(1, -25, 0, 23),
        BackgroundTransparency = 1,
        Text = title,
        TextColor3 = Theme.White,
        TextSize = 13,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left
    }, card)

    create("TextLabel", {
        Position = UDim2.fromOffset(13, 34),
        Size = UDim2.new(1, -25, 0, 18),
        BackgroundTransparency = 1,
        Text = description,
        TextColor3 = Theme.Muted,
        TextSize = 10,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left
    }, card)
end

-- MENU CONTENT

local function render(tab)
    clearContent()

    if tab == "Farm" then
        heading("Farm Control", "Farming interface settings")
        toggle("Auto Farm", "Demo toggle", 85)
        toggle("Auto Plant", "Demo toggle", 158)
        toggle("Auto Harvest", "Demo toggle", 231)

    elseif tab == "Auto DF" then
        heading("Auto DF", "Automation interface settings")
        toggle("Auto DF", "Demo toggle", 85)
        toggle("DF Notification", "Notification setting", 158)

    elseif tab == "World" then
        heading("World Manager", "World management interface")
        itemCard("Clear World", "Reserved for authorized world management", 85)
        itemCard("World Information", "World details interface", 158)

    elseif tab == "Items" then
        heading("Item Manager", "Item information interface")
        itemCard("Item Database", "Display item information", 85)
        itemCard("Inventory", "Inventory interface placeholder", 158)
        itemCard("Item Details", "Item detail interface", 231)

    elseif tab == "Collect" then
        heading("Collect Manager", "Collection interface settings")
        toggle("Auto Collect", "Demo toggle", 85)
        toggle("Collect Lock", "Demo toggle", 158)
        toggle("Collection Alert", "Demo toggle", 231)

    elseif tab == "Settings" then
        heading("Settings", "Customize your interface")
        itemCard("Theme", "Dark Purple", 85)
        itemCard("Version", "Ultimate Hub v1.0.0", 158)
        itemCard("Developer", "Growblox Hub Project", 231)
    end
end

-- NAVIGATION

local tabs = {
    "Farm",
    "Auto DF",
    "World",
    "Items",
    "Collect",
    "Settings"
}

for index, name in ipairs(tabs) do
    local button = create("TextButton", {
        Size = UDim2.new(1, 0, 0, 42),
        BackgroundColor3 = Theme.Card,
        Text = "  " .. name,
        TextColor3 = Theme.White,
        TextSize = 12,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        BorderSizePixel = 0,
        LayoutOrder = index
    }, sidebar)

    round(button, 8)

    button.MouseButton1Click:Connect(function()
        for _, other in ipairs(sidebar:GetChildren()) do
            if other:IsA("TextButton") then
                tween(other, {
                    BackgroundColor3 = Theme.Card
                })
            end
        end

        tween(button, {
            BackgroundColor3 = Theme.Purple
        })

        render(name)
    end)
end

render("Farm")
sidebar:FindFirstChild("Farm").BackgroundColor3 = Theme.Purple

print("Growblox Ultimate Hub V1.0 Loaded")
