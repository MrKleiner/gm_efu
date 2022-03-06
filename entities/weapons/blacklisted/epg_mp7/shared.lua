SWEP.PrintName = "Machine Pistol 7D"

SWEP.Author = "Punker"
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.Instructions = "MP7"

SWEP.Category = "EP:Goverment"

SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.AdminOnly = false
SWEP.CSMuzzleFlashes = true

SWEP.IronSightsPos = Vector(-6.281, -5.039, 1.72)
SWEP.IronSightsAng = Vector(-1.339, 0.352, -8.183)

SWEP.ViewModelFOV = 57
SWEP.ViewModel = "models/weapons/c_smg1.mdl"
SWEP.WorldModel = "models/weapons/w_smg_mp5.mdl"
SWEP.ViewModelFlip = false
SWEP.ShowWorldModel = true
SWEP.ViewModelBoneMods = {
	["ValveBiped.base"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}


SWEP.VElements = {
	["element_name"] = { type = "Model", model = "models/auditor/insurgency_s/wpn_smg_mp7.mdl", bone = "ValveBiped.base", rel = "", pos = Vector(0.231, 0.375, -7.324), angle = Angle(89.156, -96.25, 5.82), size = Vector(1.31, 1.222, 1.133), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}




SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = true

SWEP.Slot = 2
SWEP.SlotPos = 1
 
SWEP.UseHands = true

SWEP.HoldType = "ar2" 

SWEP.FiresUnderwater = true

SWEP.DrawCrosshair = false

SWEP.DrawAmmo = false

SWEP.ReloadSound = ""

SWEP.Base = "weapon_base"

SWEP.Bipods = 0
SWEP.Sprint = 0
SWEP.SprintAngles = 0
SWEP.Reloading = 0
SWEP.ReloadingTimer = CurTime()
SWEP.Idle = 0
SWEP.IdleTimer = CurTime()
SWEP.Recoil = 0
SWEP.RecoilTimer = CurTime()
SWEP.RecoilDirection = 0

SWEP.Primary.Sound = Sound("weapons/firearms/mp7/mp7_shot1.wav") --8erre
SWEP.Primary.Damage = 75
SWEP.Primary.TakeAmmo = 1
SWEP.Primary.ClipSize = 26
SWEP.Primary.Ammo = "SMG1"
SWEP.Primary.DefaultClip = 78 --55
SWEP.Primary.Spread = 0.14
SWEP.Primary.SpreadSecondary = 0.001
SWEP.Primary.SpreadMovement = 1
SWEP.Primary.NumberofShots = 1
SWEP.Primary.Automatic = true
SWEP.Primary.Recoil = 0.12
SWEP.Primary.Delay = 0.07
SWEP.Primary.Force = 1

SWEP.Secondary.ClipSize = 0
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

function SWEP:Initialize()
util.PrecacheSound(self.Primary.Sound) 
util.PrecacheSound(self.ReloadSound) 
        self:SetWeaponHoldType("ar2")
end 

function SWEP:Deploy()
	self:SendWeaponAnim( ACT_VM_DRAW )
	self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() )

	return true
end 

function SWEP:PrimaryAttack()
if self.Sprint == 1 then return end
if self.Reloading == 1 then return end
if self.Weapon:Clip1() <= 0 and self.Weapon:Ammo1() <= 0 then
self.Weapon:EmitSound( "" )
self:SetNextPrimaryFire( CurTime() + 0.2 )
end
if self.FiresUnderwater == false and self.Owner:WaterLevel() == 3 then
self.Weapon:EmitSound( "" )
self:SetNextPrimaryFire( CurTime() + 0.2 )
end
if self.Weapon:Clip1() <= 0 then
self:Reload()
end
if self.Weapon:Clip1() <= 0 then return end
if self.FiresUnderwater == false and self.Owner:WaterLevel() == 3 then return end
local bullet = {}
bullet.Num = self.Primary.NumberofShots
bullet.Src = self.Owner:GetShootPos()
bullet.Dir = self.Owner:GetAimVector()
if self.Owner:GetVelocity():Length() < 100 then
if self.Bipods == 0 then
bullet.Spread = Vector( 1 * self.Primary.Spread, 1 * self.Primary.Spread, 0 )
end
if self.Bipods == 1 then
bullet.Spread = Vector( 1 * self.Primary.SpreadSecondary, 1 * self.Primary.SpreadSecondary, 0 )
end
end
if self.Owner:GetVelocity():Length() >= 100 then
bullet.Spread = Vector( 1 * self.Primary.SpreadMovement, 1 * self.Primary.SpreadMovement, 0 )
end
if !self.Owner:IsOnGround() then
bullet.Spread = Vector( 1 * self.Primary.SpreadMovement, 1 * self.Primary.SpreadMovement, 0 )
end
bullet.Tracer = 1
bullet.Force = self.Primary.Force
bullet.Damage = self.Primary.Damage
bullet.AmmoType = self.Primary.Ammo
self.Owner:FireBullets( bullet )
self:EmitSound( self.Primary.Sound )
self.Owner:MuzzleFlash()
if self.Bipods == 0 then
self.Recoil = 1
self.RecoilTimer = CurTime() + 0.1
self.RecoilDirection = math.Rand( -0.1, 0.1 )
end
self:TakePrimaryAmmo( self.Primary.TakeAmmo )
if self.Bipods == 0 then
if self.Weapon:Clip1() >= 8 then
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
end
if self.Weapon:Clip1() == 7 then
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK_8 )
end
if self.Weapon:Clip1() == 6 then
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK_7 )
end
if self.Weapon:Clip1() == 5 then
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK_6 )
end
if self.Weapon:Clip1() == 4 then
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK_5 )
end
if self.Weapon:Clip1() == 3 then
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK_4 )
end
if self.Weapon:Clip1() == 2 then
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK_3 )
end
if self.Weapon:Clip1() == 1 then
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK_2 )
end
if self.Weapon:Clip1() <= 0 then
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK_1 )
end
end
if self.Bipods == 1 then
if self.Weapon:Clip1() >= 8 then
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK_DEPLOYED )
end
if self.Weapon:Clip1() == 7 then
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK_DEPLOYED_8 )
end
if self.Weapon:Clip1() == 6 then
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK_DEPLOYED_7 )
end
if self.Weapon:Clip1() == 5 then
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK_DEPLOYED_6 )
end
if self.Weapon:Clip1() == 4 then
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK_DEPLOYED_5 )
end
if self.Weapon:Clip1() == 3 then
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK_DEPLOYED_4 )
end
if self.Weapon:Clip1() == 2 then
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK_DEPLOYED_3 )
end
if self.Weapon:Clip1() == 1 then
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK_DEPLOYED_2 )
end
if self.Weapon:Clip1() <= 0 then
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK_DEPLOYED_1 )
end
end
self.Owner:SetAnimation( PLAYER_ATTACK1 )
self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
self:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
self.Idle = 0
self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
self.Owner:SetEyeAngles( self.Owner:EyeAngles() + Angle( -2, 0, 0 ) )
end

function SWEP:Initialize()

	// other initialize code goes here

	if CLIENT then
		self:SetWeaponHoldType( self.HoldType )
		// Create a new table for every weapon instance
		self.VElements = table.FullCopy( self.VElements )
		self.WElements = table.FullCopy( self.WElements )
		self.ViewModelBoneMods = table.FullCopy( self.ViewModelBoneMods )

		self:CreateModels(self.VElements) // create viewmodels
		self:CreateModels(self.WElements) // create worldmodels
		
		// init view model bone build function
		if IsValid(self.Owner) then
			local vm = self.Owner:GetViewModel()
			if IsValid(vm) then
				self:ResetBonePositions(vm)
				
				// Init viewmodel visibility
				if (self.ShowViewModel == nil or self.ShowViewModel) then
					vm:SetColor(Color(255,255,255,255))
				else
					// we set the alpha to 1 instead of 0 because else ViewModelDrawn stops being called
					vm:SetColor(Color(255,255,255,1))
					// ^ stopped working in GMod 13 because you have to do Entity:SetRenderMode(1) for translucency to kick in
					// however for some reason the view model resets to render mode 0 every frame so we just apply a debug material to prevent it from drawing
					vm:SetMaterial("Debug/hsv")			
				end
			end
		end
		
	end

end

function SWEP:Holster()
	
	if CLIENT and IsValid(self.Owner) then
		local vm = self.Owner:GetViewModel()
		if IsValid(vm) then
			self:ResetBonePositions(vm)
		end
	end
	
	return true
end

function SWEP:OnRemove()
	self:Holster()
end

if CLIENT then

	SWEP.vRenderOrder = nil
	function SWEP:ViewModelDrawn()
		
		local vm = self.Owner:GetViewModel()
		if !IsValid(vm) then return end
		
		if (!self.VElements) then return end
		
		self:UpdateBonePositions(vm)

		if (!self.vRenderOrder) then
			
			// we build a render order because sprites need to be drawn after models
			self.vRenderOrder = {}

			for k, v in pairs( self.VElements ) do
				if (v.type == "Model") then
					table.insert(self.vRenderOrder, 1, k)
				elseif (v.type == "Sprite" or v.type == "Quad") then
					table.insert(self.vRenderOrder, k)
				end
			end
			
		end

		for k, name in ipairs( self.vRenderOrder ) do
		
			local v = self.VElements[name]
			if (!v) then self.vRenderOrder = nil break end
			if (v.hide) then continue end
			
			local model = v.modelEnt
			local sprite = v.spriteMaterial
			
			if (!v.bone) then continue end
			
			local pos, ang = self:GetBoneOrientation( self.VElements, v, vm )
			
			if (!pos) then continue end
			
			if (v.type == "Model" and IsValid(model)) then

				model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)

				model:SetAngles(ang)
				//model:SetModelScale(v.size)
				local matrix = Matrix()
				matrix:Scale(v.size)
				model:EnableMatrix( "RenderMultiply", matrix )
				
				if (v.material == "") then
					model:SetMaterial("")
				elseif (model:GetMaterial() != v.material) then
					model:SetMaterial( v.material )
				end
				
				if (v.skin and v.skin != model:GetSkin()) then
					model:SetSkin(v.skin)
				end
				
				if (v.bodygroup) then
					for k, v in pairs( v.bodygroup ) do
						if (model:GetBodygroup(k) != v) then
							model:SetBodygroup(k, v)
						end
					end
				end
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(true)
				end
				
				render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
				render.SetBlend(v.color.a/255)
				model:DrawModel()
				render.SetBlend(1)
				render.SetColorModulation(1, 1, 1)
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(false)
				end
				
			elseif (v.type == "Sprite" and sprite) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				render.SetMaterial(sprite)
				render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
				
			elseif (v.type == "Quad" and v.draw_func) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
				cam.Start3D2D(drawpos, ang, v.size)
					v.draw_func( self )
				cam.End3D2D()

			end
			
		end
		
	end

	SWEP.wRenderOrder = nil
	function SWEP:DrawWorldModel()
		
		if (self.ShowWorldModel == nil or self.ShowWorldModel) then
			self:DrawModel()
		end
		
		if (!self.WElements) then return end
		
		if (!self.wRenderOrder) then

			self.wRenderOrder = {}

			for k, v in pairs( self.WElements ) do
				if (v.type == "Model") then
					table.insert(self.wRenderOrder, 1, k)
				elseif (v.type == "Sprite" or v.type == "Quad") then
					table.insert(self.wRenderOrder, k)
				end
			end

		end
		
		if (IsValid(self.Owner)) then
			bone_ent = self.Owner
		else
			// when the weapon is dropped
			bone_ent = self
		end
		
		for k, name in pairs( self.wRenderOrder ) do
		
			local v = self.WElements[name]
			if (!v) then self.wRenderOrder = nil break end
			if (v.hide) then continue end
			
			local pos, ang
			
			if (v.bone) then
				pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent )
			else
				pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent, "ValveBiped.Bip01_R_Hand" )
			end
			
			if (!pos) then continue end
			
			local model = v.modelEnt
			local sprite = v.spriteMaterial
			
			if (v.type == "Model" and IsValid(model)) then

				model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)

				model:SetAngles(ang)
				//model:SetModelScale(v.size)
				local matrix = Matrix()
				matrix:Scale(v.size)
				model:EnableMatrix( "RenderMultiply", matrix )
				
				if (v.material == "") then
					model:SetMaterial("")
				elseif (model:GetMaterial() != v.material) then
					model:SetMaterial( v.material )
				end
				
				if (v.skin and v.skin != model:GetSkin()) then
					model:SetSkin(v.skin)
				end
				
				if (v.bodygroup) then
					for k, v in pairs( v.bodygroup ) do
						if (model:GetBodygroup(k) != v) then
							model:SetBodygroup(k, v)
						end
					end
				end
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(true)
				end
				
				render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
				render.SetBlend(v.color.a/255)
				model:DrawModel()
				render.SetBlend(1)
				render.SetColorModulation(1, 1, 1)
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(false)
				end
				
			elseif (v.type == "Sprite" and sprite) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				render.SetMaterial(sprite)
				render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
				
			elseif (v.type == "Quad" and v.draw_func) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
				cam.Start3D2D(drawpos, ang, v.size)
					v.draw_func( self )
				cam.End3D2D()

			end
			
		end
		
	end

	function SWEP:GetBoneOrientation( basetab, tab, ent, bone_override )
		
		local bone, pos, ang
		if (tab.rel and tab.rel != "") then
			
			local v = basetab[tab.rel]
			
			if (!v) then return end
			
			// Technically, if there exists an element with the same name as a bone
			// you can get in an infinite loop. Let's just hope nobody's that stupid.
			pos, ang = self:GetBoneOrientation( basetab, v, ent )
			
			if (!pos) then return end
			
			pos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
			ang:RotateAroundAxis(ang:Up(), v.angle.y)
			ang:RotateAroundAxis(ang:Right(), v.angle.p)
			ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
		else
		
			bone = ent:LookupBone(bone_override or tab.bone)

			if (!bone) then return end
			
			pos, ang = Vector(0,0,0), Angle(0,0,0)
			local m = ent:GetBoneMatrix(bone)
			if (m) then
				pos, ang = m:GetTranslation(), m:GetAngles()
			end
			
			if (IsValid(self.Owner) and self.Owner:IsPlayer() and 
				ent == self.Owner:GetViewModel() and self.ViewModelFlip) then
				ang.r = -ang.r // Fixes mirrored models
			end
		
		end
		
		return pos, ang
	end

	function SWEP:CreateModels( tab )

		if (!tab) then return end

		// Create the clientside models here because Garry says we can't do it in the render hook
		for k, v in pairs( tab ) do
			if (v.type == "Model" and v.model and v.model != "" and (!IsValid(v.modelEnt) or v.createdModel != v.model) and 
					string.find(v.model, ".mdl") and file.Exists (v.model, "GAME") ) then
				
				v.modelEnt = ClientsideModel(v.model, RENDER_GROUP_VIEW_MODEL_OPAQUE)
				if (IsValid(v.modelEnt)) then
					v.modelEnt:SetPos(self:GetPos())
					v.modelEnt:SetAngles(self:GetAngles())
					v.modelEnt:SetParent(self)
					v.modelEnt:SetNoDraw(true)
					v.createdModel = v.model
				else
					v.modelEnt = nil
				end
				
			elseif (v.type == "Sprite" and v.sprite and v.sprite != "" and (!v.spriteMaterial or v.createdSprite != v.sprite) 
				and file.Exists ("materials/"..v.sprite..".vmt", "GAME")) then
				
				local name = v.sprite.."-"
				local params = { ["$basetexture"] = v.sprite }
				// make sure we create a unique name based on the selected options
				local tocheck = { "nocull", "additive", "vertexalpha", "vertexcolor", "ignorez" }
				for i, j in pairs( tocheck ) do
					if (v[j]) then
						params["$"..j] = 1
						name = name.."1"
					else
						name = name.."0"
					end
				end

				v.createdSprite = v.sprite
				v.spriteMaterial = CreateMaterial(name,"UnlitGeneric",params)
				
			end
		end
		
	end
	
	local allbones
	local hasGarryFixedBoneScalingYet = false

	function SWEP:UpdateBonePositions(vm)
		
		if self.ViewModelBoneMods then
			
			if (!vm:GetBoneCount()) then return end
			
			// !! WORKAROUND !! //
			// We need to check all model names :/
			local loopthrough = self.ViewModelBoneMods
			if (!hasGarryFixedBoneScalingYet) then
				allbones = {}
				for i=0, vm:GetBoneCount() do
					local bonename = vm:GetBoneName(i)
					if (self.ViewModelBoneMods[bonename]) then 
						allbones[bonename] = self.ViewModelBoneMods[bonename]
					else
						allbones[bonename] = { 
							scale = Vector(1,1,1),
							pos = Vector(0,0,0),
							angle = Angle(0,0,0)
						}
					end
				end
				
				loopthrough = allbones
			end
			// !! ----------- !! //
			
			for k, v in pairs( loopthrough ) do
				local bone = vm:LookupBone(k)
				if (!bone) then continue end
				
				// !! WORKAROUND !! //
				local s = Vector(v.scale.x,v.scale.y,v.scale.z)
				local p = Vector(v.pos.x,v.pos.y,v.pos.z)
				local ms = Vector(1,1,1)
				if (!hasGarryFixedBoneScalingYet) then
					local cur = vm:GetBoneParent(bone)
					while(cur >= 0) do
						local pscale = loopthrough[vm:GetBoneName(cur)].scale
						ms = ms * pscale
						cur = vm:GetBoneParent(cur)
					end
				end
				
				s = s * ms
				// !! ----------- !! //
				
				if vm:GetManipulateBoneScale(bone) != s then
					vm:ManipulateBoneScale( bone, s )
				end
				if vm:GetManipulateBoneAngles(bone) != v.angle then
					vm:ManipulateBoneAngles( bone, v.angle )
				end
				if vm:GetManipulateBonePosition(bone) != p then
					vm:ManipulateBonePosition( bone, p )
				end
			end
		else
			self:ResetBonePositions(vm)
		end
		   
	end
	 
	function SWEP:ResetBonePositions(vm)
		
		if (!vm:GetBoneCount()) then return end
		for i=0, vm:GetBoneCount() do
			vm:ManipulateBoneScale( i, Vector(1, 1, 1) )
			vm:ManipulateBoneAngles( i, Angle(0, 0, 0) )
			vm:ManipulateBonePosition( i, Vector(0, 0, 0) )
		end
		
	end

	/**************************
		Global utility code
	**************************/

	// Fully copies the table, meaning all tables inside this table are copied too and so on (normal table.Copy copies only their reference).
	// Does not copy entities of course, only copies their reference.
	// WARNING: do not use on tables that contain themselves somewhere down the line or you'll get an infinite loop
	function table.FullCopy( tab )

		if (!tab) then return nil end
		
		local res = {}
		for k, v in pairs( tab ) do
			if (type(v) == "table") then
				res[k] = table.FullCopy(v) // recursion ho!
			elseif (type(v) == "Vector") then
				res[k] = Vector(v.x, v.y, v.z)
			elseif (type(v) == "Angle") then
				res[k] = Angle(v.p, v.y, v.r)
			else
				res[k] = v
			end
		end
		
		return res
		
	end
	
end



function SWEP:SecondaryAttack()
end

function SWEP:Reload()
self:EmitSound(Sound(self.ReloadSound)) 
        self.Weapon:DefaultReload( ACT_VM_RELOAD );
end

local IRONSIGHT_TIME = 0.25
/*---------------------------------------------------------
   Name: GetViewModelPosition
   Desc: Allows you to re-position the view model
---------------------------------------------------------*/
function SWEP:GetViewModelPosition( pos, ang )

	if ( !self.IronSightsPos ) then return pos, ang end

	local bIron = self.Weapon:GetNetworkedBool( "Ironsights" )
	
	if ( bIron != self.bLastIron ) then
	
		self.bLastIron = bIron 
		self.fIronTime = CurTime()
		
		if ( bIron ) then 
			self.SwayScale 	= 0.3
			self.BobScale 	= 0.1
		else 
			self.SwayScale 	= 1.0
			self.BobScale 	= 1.0
		end
	
	end
	
	local fIronTime = self.fIronTime or 0

	if ( !bIron && fIronTime < CurTime() - IRONSIGHT_TIME ) then 
		return pos, ang 
	end
	
	local Mul = 1.0
	
	if ( fIronTime > CurTime() - IRONSIGHT_TIME ) then
	
		Mul = math.Clamp( (CurTime() - fIronTime) / IRONSIGHT_TIME, 0, 1 )
		
		if (!bIron) then Mul = 1 - Mul end
	
	end

	local Offset	= self.IronSightsPos
	
	if ( self.IronSightsAng ) then
	
		ang = ang * 1
		ang:RotateAroundAxis( ang:Right(), 		self.IronSightsAng.x * Mul )
		ang:RotateAroundAxis( ang:Up(), 		self.IronSightsAng.y * Mul )
		ang:RotateAroundAxis( ang:Forward(), 	self.IronSightsAng.z * Mul )
	
	
	end
	
	local Right 	= ang:Right()
	local Up 		= ang:Up()
	local Forward 	= ang:Forward()
	
	

	pos = pos + Offset.x * Right * Mul
	pos = pos + Offset.y * Forward * Mul
	pos = pos + Offset.z * Up * Mul

	return pos, ang
	
end

SWEP.Primary.Cone = 0.02


/*---------------------------------------------------------
   Name: GetViewModelPosition
   Desc: Allows you to re-position the view model
---------------------------------------------------------*/
function SWEP:GetViewModelPosition( pos, ang )

	if ( !self.IronSightsPos ) then return pos, ang end

	local bIron = self.Weapon:GetNetworkedBool( "Ironsights" )
	
	
	local fIronTime = self.fIronTime or 0

	if ( !bIron && fIronTime < CurTime() - IRONSIGHT_TIME ) then 
		return pos, ang 
	end
	
	local Mul = 1.0
	
	if ( fIronTime > CurTime() - IRONSIGHT_TIME ) then
	
		Mul = math.Clamp( (CurTime() - fIronTime) / IRONSIGHT_TIME, 0, 1 )
		
		if (!bIron) then Mul = 1 - Mul end
	
	end

	local Offset	= self.IronSightsPos
	
	if ( self.IronSightsAng ) then
	
		ang = ang * 1
		ang:RotateAroundAxis( ang:Right(), 		self.IronSightsAng.x * Mul )
		ang:RotateAroundAxis( ang:Up(), 		self.IronSightsAng.y * Mul )
		ang:RotateAroundAxis( ang:Forward(), 	self.IronSightsAng.z * Mul )
	
	
	end
	
	local Right 	= ang:Right()
	local Up 		= ang:Up()
	local Forward 	= ang:Forward()
	
	

	pos = pos + Offset.x * Right * Mul
	pos = pos + Offset.y * Forward * Mul
	pos = pos + Offset.z * Up * Mul

	return pos, ang
	
end


/*---------------------------------------------------------
	SetIronsights
---------------------------------------------------------*/
function SWEP:SetIronsights( b )

	self.Weapon:SetNetworkedBool( "Ironsights", b )

end


SWEP.NextSecondaryAttack = 0
/*---------------------------------------------------------
	SecondaryAttack
---------------------------------------------------------*/
function SWEP:SecondaryAttack()

	if ( !self.IronSightsPos ) then return end
	if ( self.NextSecondaryAttack > CurTime() ) then return end
	
	bIronsights = !self.Weapon:GetNetworkedBool( "Ironsights", false )
	
	self:SetIronsights( bIronsights )
	

 if !self.Zoomed then 
self.Zoomed = true 
self.Zoomed = false
if SERVER then
self.Owner:SetFOV( 0, 0.3 ) 
end
end
if !self.Owner:IsOnGround() then return end
if self.Sprint == 1 then return end
if self.Reloading == 1 then return end
if self.Bipods == 0 then
if self.Weapon:Clip1() > 8 then
self.Weapon:SendWeaponAnim( ACT_VM_DEPLOY )
end
if self.Weapon:Clip1() == 8 then
self.Weapon:SendWeaponAnim( ACT_VM_DEPLOY_8 )
end
if self.Weapon:Clip1() == 7 then
self.Weapon:SendWeaponAnim( ACT_VM_DEPLOY_7 )
end
if self.Weapon:Clip1() == 6 then
self.Weapon:SendWeaponAnim( ACT_VM_DEPLOY_6 )
end
if self.Weapon:Clip1() == 5 then
self.Weapon:SendWeaponAnim( ACT_VM_DEPLOY_5 )
end
if self.Weapon:Clip1() == 4 then
self.Weapon:SendWeaponAnim( ACT_VM_DEPLOY_4 )
end
if self.Weapon:Clip1() == 3 then
self.Weapon:SendWeaponAnim( ACT_VM_DEPLOY_3 )
end
if self.Weapon:Clip1() == 2 then
self.Weapon:SendWeaponAnim( ACT_VM_DEPLOY_2 )
end
if self.Weapon:Clip1() <= 1 then
self.Weapon:SendWeaponAnim( ACT_VM_DEPLOY_EMPTY )
end
self:SetNextPrimaryFire( CurTime() + self.Owner:GetViewModel():SequenceDuration() )
self:SetNextSecondaryFire( CurTime() + self.Owner:GetViewModel():SequenceDuration() )
self.Bipods = 1
self.Idle = 0
self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
self.Weapon:SetNWString( "CrosshairAlpha", 255 )
self.Owner:SetWalkSpeed( 1 )
self.Owner:SetRunSpeed( 1 )
self.Owner:SetJumpPower( 0 )
else
if self.Bipods == 1 then
if self.Weapon:Clip1() > 8 then
self.Weapon:SendWeaponAnim( ACT_VM_UNDEPLOY )
end
if self.Weapon:Clip1() == 8 then
self.Weapon:SendWeaponAnim( ACT_VM_UNDEPLOY_8 )
end
if self.Weapon:Clip1() == 7 then
self.Weapon:SendWeaponAnim( ACT_VM_UNDEPLOY_7 )
end
if self.Weapon:Clip1() == 6 then
self.Weapon:SendWeaponAnim( ACT_VM_UNDEPLOY_6 )
end
if self.Weapon:Clip1() == 5 then
self.Weapon:SendWeaponAnim( ACT_VM_UNDEPLOY_5 )
end
if self.Weapon:Clip1() == 4 then
self.Weapon:SendWeaponAnim( ACT_VM_UNDEPLOY_4 )
end
if self.Weapon:Clip1() == 3 then
self.Weapon:SendWeaponAnim( ACT_VM_UNDEPLOY_3 )
end
if self.Weapon:Clip1() == 2 then
self.Weapon:SendWeaponAnim( ACT_VM_UNDEPLOY_2 )
end
if self.Weapon:Clip1() <= 1 then
self.Weapon:SendWeaponAnim( ACT_VM_UNDEPLOY_EMPTY )
end
self:SetNextPrimaryFire( CurTime() + self.Owner:GetViewModel():SequenceDuration() )
self:SetNextSecondaryFire( CurTime() + self.Owner:GetViewModel():SequenceDuration() )
self.Bipods = 0
self.Idle = 0
self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
self.Weapon:SetNWString( "CrosshairAlpha", 0 )
self.Owner:SetWalkSpeed( 200 )
self.Owner:SetRunSpeed( 400 )
self.Owner:SetJumpPower( 200 )
end
end
end

function SWEP:OnRestore()

	self.NextSecondaryAttack = 0
	self:SetIronsights( false )
	
end