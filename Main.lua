
firesignal(game.ReplicatedStorage.Bricks.Caption.OnClientEvent, "Midnight's Crucifix Succesfully Loaded!")


_G.Uses = 5

local Uses = _G.Uses

--// haha define stuff

local tweensv = game:GetService("TweenService")
local Player = game.Players.LocalPlayer
local Character = Player.Character



local Functions = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Functions.lua"))()
local CustomShop = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Custom%20Shop%20Items/Source.lua"))()


-- Create your tool here





--// baller

local ToolFunctions = {
     OnClick = function() end,
     OnEquip = function() end,
     OnUnequipped = function() end,
}

local Tool_obj = game:GetObjects(getcustomasset("CrucifixEffects.rbxm"))[1]

local ToolHandle = Tool_obj:WaitForChild("Handle",5)

local Cooldown = false


for _,v in pairs(ToolHandle:GetDescendants()) do
	if v:IsA("Light") then v:Destroy() end
end




ToolHandle.Anchored = false


function MakeIdAnimation(animation)
	local animationobj = Instance.new("Animation",Character.Humanoid)
	animationobj.Name = "Animation_Stored_"..animation
	animationobj.AnimationId = "rbxassetid://"..animation

	
	local animationtrack = game.Players.LocalPlayer.Character.Humanoid.Animator:LoadAnimation(animationobj)
	animationtrack.Priority = "Action4"

	return animationtrack
end


function CreateSound(id)
	local sound = Instance.new("Sound",ToolHandle)
	sound.SoundId = "rbxassetid://"..id

	
	return sound
end


local ClickSound = CreateSound(6407958931)

local Equipped = false

local LatestRoom = game:GetService("ReplicatedStorage").GameData.LatestRoom


local HoldAnimation = MakeIdAnimation(10479585177)

--// Tool events

ToolFunctions.OnClick = function()
	
end

ToolFunctions.OnEquip = function()
	HoldAnimation:Play(.1)
	
	Equipped = true
	
	
	--make it so you can hell entities
	
	
spawn(function()
	repeat
	task.wait(.5)
		local thing,_D = entity_check()
	
		if thing and not thing:GetAttribute("BeingSentToBrazil") and _D < 50 and Equipped then
			
			
			--CAMERA SHAKE
			
			local CameraShaker = require(game.ReplicatedStorage.CameraShaker)
			local camara = game.Workspace.CurrentCamera
			local camShake = CameraShaker.new(Enum.RenderPriority.Camera.Value, function(shakeCf)
				camara.CFrame = camara.CFrame * shakeCf
			end)
			camShake:Start()
			camShake:ShakeOnce(10,30,0.7,0.5)
			
			local Haw = ToolHandle:Clone()
			Haw.Parent = workspace
			
			Haw.Name = "CrucifixUsed"
			Haw.Anchored = true
			Haw.CanCollide = false
			Haw.CFrame = ToolHandle.CFrame
			
			Haw.Chain.Enabled = true
			
			Haw.Chain.CurveSize0 = 0
			Haw.Chain.CurveSize1 = 0
			
			Haw.Chain.Width1 = 0
			
			tweensv:Create(Haw.Chain, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				CurveSize1 = 2, CurveSize0 = -1, Width1 = .2,
			}):Play()
			
			tweensv:Create(Haw.Point2, TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				WorldPosition = thing.PrimaryPart.Position,
			}):Play()
			
			
			spawn(function()
				task.wait(2)
				
				tweensv:Create(Haw.Chain, TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					CurveSize1 = 0, CurveSize0 = 0, Width1 = 0, Width0 = 0,
				}):Play()
				
				tweensv:Create(Haw.Point2, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					WorldPosition = Haw.Point1.WorldPosition,
				}):Play()
				
				task.wait(3)
				
				Haw.Anchored = false
				Haw.CanCollide = true
				
				game:GetService("Debris"):AddItem(Haw,5)
			end)
			
			if Uses == 1 then
				Equipped = false
				Tool_obj:Destroy()
			else
				Tool_obj.Parent = Player.Backpack
				Equipped = false
				Uses -= 1
			end
			
			thing:SetAttribute("StopMovement",true)
			thing:SetAttribute("BeingSentToBrazil",true)
			
			hell(thing)
		end
	until Equipped == false
end)
	
	
	
	
	
	
	
	
	HoldAnimation:AdjustSpeed(0)
end

ToolFunctions.OnUnequipped = function()
	Equipped = false
	
	HoldAnimation:AdjustSpeed(1)
    HoldAnimation:Stop(.5)
end




Tool_obj.Equipped:Connect(function()
	ToolFunctions.OnEquip()
end)

Tool_obj.Activated:Connect(function()
	ToolFunctions.OnClick()
end)

Tool_obj.Unequipped:Connect(function()
	ToolFunctions.OnUnequipped()
end)

function entity_check()
	local closestDistance, closestObject = math.huge, nil
		for _, part in ipairs(workspace:GetDescendants()) do
			if part:IsA("Model") then
				local part1 = part:GetAttribute("IsCustomEntity")
				if part1 then
					local distance = game.Players.LocalPlayer:DistanceFromCharacter(part.PrimaryPart.Position)
						if distance < closestDistance then
						closestDistance = distance
						closestObject = part
					end
					
				end
			end
		end
	return closestObject,closestDistance
end

function hell(entity)
	local primary = entity.PrimaryPart
	
	task.wait(2)
	
	tweensv:Create(primary, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Position = primary.Position + Vector3.new(0,5,0),
	}):Play()
	
	task.wait(1)
	
	tweensv:Create(primary, TweenInfo.new(5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
		Position = primary.Position - Vector3.new(0,200,0),
	}):Play()
	
	
	
	task.wait(5)
	
	entity:Destroy()
end





Tool_obj.Parent = Character

-- Create custom shop item
CustomShop.CreateItem(Tool_obj, {
    Title = "Midnight's Crucifix",
    Desc = "Originated From God Its Self.",
    Image = "rbxassetid://11451973143",
    Price = "amogus",
    Stack = 1,
})
