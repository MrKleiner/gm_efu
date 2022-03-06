SWEP.PrintName = "12.7mm M82 Barret"
    
SWEP.Author = "Punker" --1850 23072020 fight against bigcity again FSF with MASON btw firsr awm rifle snipongdii
SWEP.Contact = ""
SWEP.Purpose = "12.7"
SWEP.Instructions = ""

SWEP.Category = "EP:Goverment"

SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.AdminOnly = false
SWEP.CSMuzzleFlashes = true

SWEP.ViewModelFOV = 54
SWEP.ViewModel = "models/weapons/cstrike/c_snip_sg550.mdl"
SWEP.WorldModel = "models/weapons/w_snip_sg550.mdl"
SWEP.ViewModelFlip = false
SWEP.ShowWorldModel = true
SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_R_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-2.852, 0, 0) },
	["ValveBiped.Bip01_L_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0.725, 0, 0) },
	["v_weapon.sg550_Parent"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}

SWEP.VElements = {
	["element_name"] = { type = "Model", model = "models/weapons/w_gdcm822.mdl", bone = "v_weapon.sg550_Parent", rel = "", pos = Vector(0.082, -1.242, -13.176), angle = Angle(88.039, -90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["element_name"] = { type = "Model", model = "models/weapons/w_gdcm822.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(13.185, 0.563, 0), angle = Angle(180, 0, 0), size = Vector(1.277, 1.277, 1.277), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}



SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = true

SWEP.Slot = 3
SWEP.SlotPos = 1
 
SWEP.UseHands = true

SWEP.HoldType = "ar2" 

SWEP.FiresUnderwater = false

SWEP.DrawCrosshair = true

SWEP.DrawAmmo = true

SWEP.ReloadSound = ""

SWEP.Base = "weapon_base"

SWEP.Scope = 0
SWEP.ShotTimer = CurTime()
SWEP.Reloading = 0
SWEP.ReloadingTimer = CurTime()
SWEP.Recoil = 0
SWEP.Idle = 0
SWEP.IdleTimer = CurTime()
SWEP.WalkSpeed = 168
SWEP.RunSpeed = 336

SWEP.Primary.Sound = Sound("weapons/firearms/svd/svd_Shot2.wav") 
SWEP.Primary.ClipSize = 5
SWEP.Primary.DefaultClip = 10
SWEP.Primary.MaxAmmo = 15
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "AR2"
SWEP.Primary.Damage = 300
SWEP.Primary.TakeAmmo = 1
SWEP.Primary.NumberofShots = 1
SWEP.Primary.Spread = 0.0808
SWEP.Primary.SpreadMin = 0.0808
SWEP.Primary.SpreadMax = 0.14
SWEP.Primary.SpreadKick = 0.0808
SWEP.Primary.SpreadMove = 0.273
SWEP.Primary.SpreadAir = 0.546
SWEP.Primary.SpreadMinAlt = 0.0002
SWEP.Primary.SpreadKickAlt = 0.002
SWEP.Primary.SpreadRecoveryTime = 0.34539
SWEP.Primary.SpreadRecoveryTimer = CurTime()
SWEP.Primary.Delay = 2
SWEP.Primary.Force = 3

SWEP.Secondary.Sound = Sound( "Default.Zoom" )
SWEP.Secondary.ClipSize = 0
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Delay = 0.25

function SWEP:Initialize()
        self:SetWeaponHoldType("ar2")
end 

function SWEP:Deploy()
	self:SendWeaponAnim( ACT_VM_DRAW )
	self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() )

	return true
end 


--[[function SWEP:DrawHUD()
local x = ScrW() / 2
local y = ScrH() / 2
if CLIENT then
surface.SetDrawColor( 255, 255, 255, self.Weapon:GetNWString( "ScopeAlpha", 0 ) )
surface.SetTexture( surface.GetTextureID( "sprites/scopes/scope_k43_ll" ) )
surface.DrawTexturedRect( x - ScrH() / 1.5, y - 0, ScrH() / 1.5, ScrH() / 2 )
surface.SetTexture( surface.GetTextureID( "sprites/scopes/scope_k43_lr" ) )
surface.DrawTexturedRect( x - 0, y - 0, ScrH() / 1.5, ScrH() / 2 )
surface.SetTexture( surface.GetTextureID( "sprites/scopes/scope_k43_ul" ) )
surface.DrawTexturedRect( x - ScrH() / 1.5, y - ScrH() / 2, ScrH() / 1.5, ScrH() / 2 )
surface.SetTexture( surface.GetTextureID( "sprites/scopes/scope_k43_ur" ) )
surface.DrawTexturedRect( x - 0, y - ScrH() / 2, ScrH() / 1.5, ScrH() / 2 )
surface.SetTexture( surface.GetTextureID( "sprites/scopes/black" ) )
surface.DrawTexturedRect( x - ScrW() / 2, y - ScrH() / 2, ScrW() / 2 - ScrH() / 2, ScrH() )
surface.SetTexture( surface.GetTextureID( "sprites/scopes/black" ) )
surface.DrawTexturedRect( x - -ScrH() / 2, y - ScrH() / 2, ScrW() / 2 - ScrH() / 2, ScrH() )
end
end]]


function SWEP:DrawHUD()
if CLIENT then
surface.SetDrawColor( 255, 255, 255, self.Weapon:GetNWInt( "ScopeAlpha", 0 ) )
surface.SetTexture( surface.GetTextureID( "overlays/scope_lens" ) )
surface.DrawTexturedRect( ( ScrW() - ScrH() ) / 2, 0, ScrH(), ScrH() )
surface.SetTexture( surface.GetTextureID( "sprites/scope_arc" ) )
surface.DrawTexturedRectRotated( ScrW() / 2 - ScrH() / 4, ScrH() / 4 * 3, ScrH() / 2, ScrH() / 2, -90 )
surface.SetTexture( surface.GetTextureID( "sprites/scope_arc" ) )
surface.DrawTexturedRect( ScrW() / 2, ScrH() / 2, ScrH() / 2, ScrH() / 2 )
surface.SetTexture( surface.GetTextureID( "sprites/scope_arc" ) )
surface.DrawTexturedRectRotated( ScrW() / 2 - ScrH() / 4, ScrH() / 4, ScrH() / 2, ScrH() / 2, 180 )
surface.SetTexture( surface.GetTextureID( "sprites/scope_arc" ) )
surface.DrawTexturedRectRotated( ScrW() / 2 + ScrH() / 4, ScrH() / 4, ScrH() / 2, ScrH() / 2, 90 )
surface.SetDrawColor( 0, 0, 0, self.Weapon:GetNWInt( "ScopeAlpha", 0 ) )
surface.DrawRect( 0, 0, ( ScrW() - ScrH() ) / 2 + 1, ScrH() )
surface.DrawRect( ( ScrW() + ScrH() ) / 2 - 1, 0, ( ScrW() - ScrH() ) / 2 + 1, ScrH() )
surface.DrawLine( 0, ScrH() / 2, ScrW(), ScrH() / 2 )
surface.DrawLine( ScrW() / 2, 0, ScrW() / 2, ScrH() )
end
end

function SWEP:AdjustMouseSensitivity()
return self.Weapon:GetNWInt( "MouseSensitivity", 1 )
end


function SWEP:PrimaryAttack()
if ( self.Weapon:Clip1() <= 0 and self.Weapon:Ammo1() <= 0 ) || ( self.FiresUnderwater == false and self.Owner:WaterLevel() == 3 ) then
if SERVER then
self.Owner:EmitSound( "Default.ClipEmpty_Rifle" )
end
self:SetNextPrimaryFire( CurTime() + 0.15 )
end
if self.Weapon:Clip1() <= 0 then
self:Reload()
end
if self.Weapon:Clip1() <= 0 || ( self.FiresUnderwater == false and self.Owner:WaterLevel() == 3 ) then return end
local bullet = {}
bullet.Num = self.Primary.NumberofShots
bullet.Src = self.Owner:GetShootPos()
bullet.Dir = self.Owner:GetAimVector()
bullet.Spread = Vector( self.Primary.Spread, self.Primary.Spread, 0 )
bullet.Tracer = 0
bullet.Distance = 8192
bullet.Force = self.Primary.Force
bullet.Damage = self.Primary.Damage
bullet.AmmoType = self.Primary.Ammo
self.Owner:FireBullets( bullet )
self:EmitSound( self.Primary.Sound )
self:ShootEffects()
self:TakePrimaryAmmo( self.Primary.TakeAmmo )
self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
self:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
if self.Primary.Spread < self.Primary.SpreadMax then
if self.Scope == 0 then
self.Primary.Spread = self.Primary.Spread + self.Primary.SpreadKick
end
if !( self.Scope == 0 ) then
self.Primary.Spread = self.Primary.Spread + self.Primary.SpreadKickAlt
end
end
self.Primary.SpreadRecoveryTimer = CurTime() + self.Primary.SpreadRecoveryTime
self.Scope = 0
self.ShotTimer = CurTime() + self.Primary.Delay
self.ReloadingTimer = CurTime() + self.Primary.Delay
if ( CLIENT || game.SinglePlayer() ) and IsFirstTimePredicted() then
if self.Recoil > 4 and self.Recoil < 8 then
self.Owner:SetEyeAngles( self.Owner:EyeAngles() + Angle( self.Recoil - 8, 0, 0 ) )
self.Recoil = 8
end
if self.Recoil <= 4 then
self.Owner:SetEyeAngles( self.Owner:EyeAngles() + Angle( -4, 0, 0 ) )
self.Recoil = self.Recoil + 4
end
end
self.Idle = 0
self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
self.Weapon:SetNWInt( "ScopeAlpha", 0 )
self.Weapon:SetNWInt( "MouseSensitivity", 1 )
self.Owner:SetFOV( 0, 0.1 )
self.Owner:SetWalkSpeed( self.WalkSpeed )
self.Owner:SetRunSpeed( self.RunSpeed )
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


function SWEP:Think()
if ( CLIENT || game.SinglePlayer() ) and IsFirstTimePredicted() then
if self.Recoil < 0 then
self.Recoil = 0
end
if self.Recoil > 0 then
self.Owner:SetEyeAngles( self.Owner:EyeAngles() + Angle( 0.25, 0, 0 ) )
self.Recoil = self.Recoil - 0.25
end
end
if self.ShotTimer > CurTime() then
self.Primary.SpreadRecoveryTimer = CurTime() + self.Primary.SpreadRecoveryTime
end
if self.Owner:IsOnGround() then
if self.Owner:GetVelocity():Length() <= 100 then
if self.Primary.SpreadRecoveryTimer <= CurTime() then
if self.Scope == 0 then
self.Primary.Spread = self.Primary.SpreadMin
end
if !( self.Scope == 0 ) then
self.Primary.Spread = self.Primary.SpreadMinAlt
end
end
if self.Scope == 0 and self.Primary.Spread > self.Primary.SpreadMin then
self.Primary.Spread = ( ( self.Primary.SpreadRecoveryTimer - CurTime() ) / self.Primary.SpreadRecoveryTime ) * self.Primary.Spread
end
if !( self.Scope == 0 ) and self.Primary.Spread > self.Primary.SpreadMinAlt then
self.Primary.Spread = ( ( self.Primary.SpreadRecoveryTimer - CurTime() ) / self.Primary.SpreadRecoveryTime ) * ( self.Primary.SpreadMinAlt + self.Primary.Spread )
end
end
if self.Owner:GetVelocity():Length() <= 100 and self.Primary.Spread > self.Primary.SpreadMax then
self.Primary.Spread = self.Primary.SpreadMax
end
if self.Owner:GetVelocity():Length() > 100 then
self.Primary.Spread = self.Primary.SpreadMove
self.Primary.SpreadRecoveryTimer = CurTime() + self.Primary.SpreadRecoveryTime
if self.Primary.Spread > self.Primary.SpreadMin then
self.Primary.Spread = ( ( self.Primary.SpreadRecoveryTimer - CurTime() ) / self.Primary.SpreadRecoveryTime ) * self.Primary.SpreadMove
end
end
end
if !self.Owner:IsOnGround() then
self.Primary.Spread = self.Primary.SpreadAir
self.Primary.SpreadRecoveryTimer = CurTime() + self.Primary.SpreadRecoveryTime
if self.Scope == 0 and self.Primary.Spread > self.Primary.SpreadMin then
self.Primary.Spread = ( ( self.Primary.SpreadRecoveryTimer - CurTime() ) / self.Primary.SpreadRecoveryTime ) * self.Primary.SpreadAir
end
if !( self.Scope == 0 ) and self.Primary.Spread > self.Primary.SpreadMinAlt then
self.Primary.Spread = ( ( self.Primary.SpreadRecoveryTimer - CurTime() ) / self.Primary.SpreadRecoveryTime ) * self.Primary.SpreadAir
end
end
if self.Reloading == 1 and self.ReloadingTimer <= CurTime() then
if self.Weapon:Ammo1() > ( self.Primary.ClipSize - self.Weapon:Clip1() ) then
self.Owner:SetAmmo( self.Weapon:Ammo1() - self.Primary.ClipSize + self.Weapon:Clip1(), self.Primary.Ammo )
self.Weapon:SetClip1( self.Primary.ClipSize )
end
if ( self.Weapon:Ammo1() - self.Primary.ClipSize + self.Weapon:Clip1() ) + self.Weapon:Clip1() < self.Primary.ClipSize then
self.Weapon:SetClip1( self.Weapon:Clip1() + self.Weapon:Ammo1() )
self.Owner:SetAmmo( 0, self.Primary.Ammo )
end
self.Reloading = 0
end
if self.IdleTimer <= CurTime() then
if self.Idle == 0 then
self.Idle = 1
end
if SERVER and self.Idle == 1 then
self.Weapon:SendWeaponAnim( ACT_VM_IDLE )
end
self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
end
if self.Weapon:Ammo1() > self.Primary.MaxAmmo then
self.Owner:SetAmmo( self.Primary.MaxAmmo, self.Primary.Ammo )
end
end

function SWEP:SecondaryAttack()
if self.Scope == 0 then
self:SetNextSecondaryFire( CurTime() + self.Secondary.Delay )
self.Primary.SpreadRecoveryTimer = CurTime() + self.Primary.SpreadRecoveryTime
if IsFirstTimePredicted() then
self.Scope = 1
end
self.Weapon:SetNWInt( "ScopeAlpha", 255 )
self.Weapon:SetNWInt( "MouseSensitivity", 0.4 )
self.Owner:SetFOV( self.Owner:GetFOV() / 2.5, 0.1 )
self.Owner:SetWalkSpeed( 120 )
self.Owner:SetRunSpeed( 240 )
else
if self.Scope == 1 then
self:SetNextSecondaryFire( CurTime() + self.Secondary.Delay )
if IsFirstTimePredicted() then
self.Scope = 2
end
self.Weapon:SetNWInt( "ScopeAlpha", 255 )
self.Weapon:SetNWInt( "MouseSensitivity", 0.16 )
self.Owner:SetFOV( self.Owner:GetFOV() / 2.5, 0.1 )
self.Owner:SetWalkSpeed( 120 )
self.Owner:SetRunSpeed( 240 )
else
if self.Scope == 2 then
self:SetNextSecondaryFire( CurTime() + self.Secondary.Delay )
if IsFirstTimePredicted() then
self.Scope = 0
end
self.Weapon:SetNWInt( "ScopeAlpha", 0 )
self.Weapon:SetNWInt( "MouseSensitivity", 1 )
self.Owner:SetFOV( 0, 0.1 )
self.Owner:SetWalkSpeed( self.WalkSpeed )
self.Owner:SetRunSpeed( self.RunSpeed )
end
end
end
end


function SWEP:Reload()
self:EmitSound(Sound(self.ReloadSound)) 
        self.Weapon:DefaultReload( ACT_VM_RELOAD );
end



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


