--Config
SWEP.PrintName = "5.56mm M249 SAW"
SWEP.Category = "EP:Goverment"
SWEP.Author = "Punker"

--Spawnable
SWEP.Spawnable = true
SWEP.AdminSpawnable = true

--Slot & Switch
SWEP.Slot = 1
SWEP.SlotPos = 10
SWEP.AutoSwitchFrom = true
SWEP.AutoSwitchTo = true

--Settings
SWEP.HoldType = "ar2"

--Models
SWEP.ViewModel = "models/weapons/cstrike/c_mach_m249para.mdl"
SWEP.WorldModel = "models/weapons/w_snip_sg550.mdl"
SWEP.ViewModelFOV			= 62
SWEP.UseHands			= true
SWEP.ShowWorldModel = false
SWEP.ViewModelBoneMods = {
	["v_weapon.m249"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}

SWEP.VElements = {
	["element_name"] = { type = "Model", model = "models/weapons/w_gdcm2402.mdl", bone = "v_weapon.m249", rel = "", pos = Vector(0, 3.525, 13.765), angle = Angle(-90, 90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
SWEP.WElements = {
	["element_name"] = { type = "Model", model = "models/weapons/w_gdcm2402.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(17.163, -0.191, -2.504), angle = Angle(174.761, -1.64, -0.965), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.Base 				    = "weapon_base"

--Ironsight Settings
SWEP.IronFov = 73
SWEP.IronTime = 0.3

--Bipods
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

--Primary Settings
SWEP.Primary.Sound = Sound("weapons/firearms/mg/mg1_shot1.wav") 
SWEP.Primary.NumberofShots = 1
SWEP.Primary.Damage = 45
SWEP.Primary.Delay = .062
SWEP.Primary.ClipSize = 200
SWEP.Primary.DefaultClip = 368
SWEP.Primary.Automatic = true
SWEP.Primary.Force = 1.2
SWEP.Primary.TakeAmmo = 1
SWEP.Primary.Recoil = .4
SWEP.Primary.Ammo = "smg1"
SWEP.Primary.Tracer = "Tracer"
SWEP.Primary.Spread = 0.13
SWEP.Primary.SpreadSecondary = 0.011
SWEP.Primary.SpreadMovement = 0.17

--Secondary Settings
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.ClipSize = 1

SWEP.IronSightsPos = Vector(-5.761, 0, 2.2)
SWEP.IronSightsAng = Vector(0.352, -0.278, 0)

--Initialize
function SWEP:Initialize()
	if ( SERVER ) then
		self:SetNPCMinBurst( 30 )
		self:SetNPCMaxBurst( 30 )
		self:SetNPCFireRate( 0.01 )
	end
	if CLIENT then
	if self.Owner:IsPlayer() then
		self:SetWeaponHoldType(self.HoldType)
		self.VElements = table.FullCopy( self.VElements )
		self.WElements = table.FullCopy( self.WElements )
		self.ViewModelBoneMods = table.FullCopy( self.ViewModelBoneMods )

		self:CreateModels(self.VElements) // create viewmodels
		self:CreateModels(self.WElements) // create worldmodels
		
		if IsValid(self.Owner) then
			local vm = self.Owner:GetViewModel()
			if IsValid(vm) then
				self:ResetBonePositions(vm)
				
				// Init viewmodel visibility
				if (self.ShowViewModel == nil or self.ShowViewModel) then
					vm:SetColor(Color(255,255,255,255))
				else
					vm:SetColor(Color(255,255,255,1))
					vm:SetMaterial("Debug/hsv")	
				end
			end
		end
		
	end

end
end
--cock
function SWEP:Holster( wep )
if IsValid( wep ) and self.Owner:Alive() and self.Weapon:GetNWBool( "Holster" ) == false then
self.Bipods = 0
self.Owner:SetWalkSpeed( 200 )
self.Owner:SetRunSpeed( 400 )
self.Owner:SetJumpPower( 200 )
return
end
if !IsValid( wep ) || self.Weapon:GetNWBool( "Holster" ) == true then
return true
end
end
--cock

function SWEP:PrimaryAttack()
if self.Sprint == 1 then return end
if self.Reloading == 1 then return end
if self.Weapon:Clip1() <= 0 and self.Weapon:Ammo1() <= 0 then
self.Weapon:EmitSound( "Default.ClipEmpty_Rifle" )
self:SetNextPrimaryFire( CurTime() + 0.2 )
end
if self.FiresUnderwater == false and self.Owner:WaterLevel() == 3 then
self.Weapon:EmitSound( "Default.ClipEmpty_Rifle" )
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
--bullet.Spread = Vector( 1 * self.Primary.Spread, 1 * self.Primary.Spread, 0 )
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
if ( CLIENT || game.SinglePlayer() ) and IsFirstTimePredicted() and self.Bipods == 0 then
self.Recoil = 1 --1
self.RecoilTimer = CurTime() + 0.1
self.RecoilDirection = math.Rand( -0.01, 0.01 )
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
end

function SWEP:SecondaryAttack()
if !self.Owner:IsOnGround() then return end
if self.Sprint == 1 then return end
if self.Reloading == 1 then return end
if self.Bipods == 0 then
self:SetNextPrimaryFire( CurTime() + self.Owner:GetViewModel():SequenceDuration() )
self:SetNextSecondaryFire( CurTime() + self.Owner:GetViewModel():SequenceDuration() )
if IsFirstTimePredicted() then
self.Bipods = 1
end
self.Idle = 0
self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
self.Weapon:SetNWString( "CrosshairAlpha", 255 )
self.Owner:SetWalkSpeed( 1 )
self.Owner:SetRunSpeed( 1 )
self.Owner:SetJumpPower( 0 )
else
self:SetNextPrimaryFire( CurTime() + self.Owner:GetViewModel():SequenceDuration() )
self:SetNextSecondaryFire( CurTime() + self.Owner:GetViewModel():SequenceDuration() )
if IsFirstTimePredicted() then
self.Bipods = 0
end
self.Idle = 0
self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
self.Weapon:SetNWString( "CrosshairAlpha", 0 )
self.Owner:SetWalkSpeed( 100 )
self.Owner:SetRunSpeed( 200 )
self.Owner:SetJumpPower( 100 )
end
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


/*---------------------------------------------------------
	SetIronsights
---------------------------------------------------------*/
function SWEP:SetIronsights( b )

	self.Weapon:SetNetworkedBool( "Ironsights", b )

end

function SWEP:OnRestore()

	self.NextSecondaryAttack = 0
	self:SetIronsights( false )
	self.Primary.Spread = self.Primary.SpreadN
	
end

function SWEP:Think()
if self.Bipods == 1 and self.Reloading == 0 and !self.Owner:IsOnGround() then
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
if self.Sprint == 0 and self.SprintAngles < 0 then
self.SprintAngles = self.SprintAngles + 3
end
if self.Sprint == 1 and self.SprintAngles > -30 then
self.SprintAngles = self.SprintAngles - 3
end
self.Weapon:SetNWString( "SprintAngles", self.SprintAngles )
if ( CLIENT || game.SinglePlayer() ) and IsFirstTimePredicted() then
if self.Recoil == 1 then
self.Owner:SetEyeAngles( self.Owner:EyeAngles() + Angle( -1, self.RecoilDirection, 0 ) )
end
if self.Recoil == 1 and self.RecoilTimer <= CurTime() then
self.Recoil = 0
end
end
if self.Sprint == 0 and self.Owner:KeyDown( IN_SPEED ) and ( self.Owner:KeyDown( IN_FORWARD ) || self.Owner:KeyDown( IN_BACK ) || self.Owner:KeyDown( IN_MOVELEFT ) || self.Owner:KeyDown( IN_MOVERIGHT ) ) then
if self.Bipods == 1 then
if self.Reloading == 0 then
self:SetNextPrimaryFire( CurTime() + self.Owner:GetViewModel():SequenceDuration() )
self:SetNextSecondaryFire( CurTime() + self.Owner:GetViewModel():SequenceDuration() )
self.Idle = 0
self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
end
self.Bipods = 0
self.Weapon:SetNWString( "CrosshairAlpha", 0 )
self.Owner:SetWalkSpeed( 100 )
self.Owner:SetRunSpeed( 200 )
self.Owner:SetJumpPower( 100 )
end
self.Sprint = 1
self.SprintAngles = 0
end
if self.Sprint == 1 and !self.Owner:KeyDown( IN_SPEED ) then
self.Sprint = 0
end
if self.Sprint == 1 and !( self.Owner:KeyDown( IN_FORWARD ) || self.Owner:KeyDown( IN_BACK ) || self.Owner:KeyDown( IN_MOVELEFT ) || self.Owner:KeyDown( IN_MOVERIGHT ) ) then
self.Sprint = 0
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
if self.Idle == 0 and self.IdleTimer < CurTime() then
if SERVER then
if self.Bipods == 0 then
if self.Weapon:Clip1() > 8 then
self.Weapon:SendWeaponAnim( ACT_VM_IDLE )
end
if self.Weapon:Clip1() == 8 then
self.Weapon:SendWeaponAnim( ACT_VM_IDLE_8 )
end
if self.Weapon:Clip1() == 7 then
self.Weapon:SendWeaponAnim( ACT_VM_IDLE_7 )
end
if self.Weapon:Clip1() == 6 then
self.Weapon:SendWeaponAnim( ACT_VM_IDLE_6 )
end
if self.Weapon:Clip1() == 5 then
self.Weapon:SendWeaponAnim( ACT_VM_IDLE_5 )
end
if self.Weapon:Clip1() == 4 then
self.Weapon:SendWeaponAnim( ACT_VM_IDLE_4 )
end
if self.Weapon:Clip1() == 3 then
self.Weapon:SendWeaponAnim( ACT_VM_IDLE_3 )
end
if self.Weapon:Clip1() == 2 then
self.Weapon:SendWeaponAnim( ACT_VM_IDLE_2 )
end
if self.Weapon:Clip1() == 1 then
self.Weapon:SendWeaponAnim( ACT_VM_IDLE_1 )
end
if self.Weapon:Clip1() <= 0 then
self.Weapon:SendWeaponAnim( ACT_VM_IDLE_EMPTY )
end
end
if self.Bipods == 1 then
if self.Weapon:Clip1() > 8 then
self.Weapon:SendWeaponAnim( ACT_VM_IDLE_DEPLOYED )
end
if self.Weapon:Clip1() == 8 then
self.Weapon:SendWeaponAnim( ACT_VM_IDLE_DEPLOYED_8 )
end
if self.Weapon:Clip1() == 7 then
self.Weapon:SendWeaponAnim( ACT_VM_IDLE_DEPLOYED_7 )
end
if self.Weapon:Clip1() == 6 then
self.Weapon:SendWeaponAnim( ACT_VM_IDLE_DEPLOYED_6 )
end
if self.Weapon:Clip1() == 5 then
self.Weapon:SendWeaponAnim( ACT_VM_IDLE_DEPLOYED_5 )
end
if self.Weapon:Clip1() == 4 then
self.Weapon:SendWeaponAnim( ACT_VM_IDLE_DEPLOYED_4 )
end
if self.Weapon:Clip1() == 3 then
self.Weapon:SendWeaponAnim( ACT_VM_IDLE_DEPLOYED_3 )
end
if self.Weapon:Clip1() == 2 then
self.Weapon:SendWeaponAnim( ACT_VM_IDLE_DEPLOYED_2 )
end
if self.Weapon:Clip1() == 1 then
self.Weapon:SendWeaponAnim( ACT_VM_IDLE_DEPLOYED_1 )
end
if self.Weapon:Clip1() <= 0 then
self.Weapon:SendWeaponAnim( ACT_VM_IDLE_DEPLOYED_EMPTY )
end
end
end
self.Idle = 1
end
end

--Holster
function SWEP:Holster()

	if CLIENT and IsValid(self.Owner) and self.Owner:IsPlayer() then
		self:SetIronsights( false )
		self.Zoomed = false	
		self.Owner:SetFOV( 0, 0.5 ) 
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

--Deploy
function SWEP:Deploy()
self:SetNextPrimaryFire( CurTime() + 1 )
self:SetNextSecondaryFire( CurTime() + 1 ) 
self:SendWeaponAnim(ACT_VM_DRAW)
self:SetIronsights( false )
self.Zoomed = false	
self.Owner:SetFOV( 0, 0.5 ) 
self.Primary.Spread = self.Primary.SpreadN
return true
end

--Reload
function SWEP:Reload()
if self.Owner:IsPlayer() then
if self:Clip1() < self.Primary.ClipSize && self:Ammo1() > 0 then
self:SetIronsights( false )
self.Zoomed = false	
self.Owner:SetFOV( 0, 0.5 ) 
self.Weapon:DefaultReload( ACT_VM_RELOAD )
self.Primary.Spread = self.Primary.SpreadN
end
end
end

list.Add( "NPCUsableWeapons", { class = "epg_pkm",	title = "EPG PKM" } )

--SCK Code

if CLIENT then
	SWEP.vRenderOrder = nil
	function SWEP:ViewModelDrawn()
		if self.Owner:IsPlayer() then
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
				
				local colorConVarr1 = GetConVar("turretfirstcolor_r")
				local colorConVarr2 = GetConVar("turretsecondcolor_r")
				local colorConVarg1 = GetConVar("turretfirstcolor_g")
				local colorConVarg2 = GetConVar("turretsecondcolor_g")
				local colorConVarb1 = GetConVar("turretfirstcolor_b")
				local colorConVarb2 = GetConVar("turretsecondcolor_b")
				local r1 = colorConVarr1:GetFloat("turretfirstcolor_r")
				local r2 = colorConVarr2:GetFloat("turretsecondcolor_r")
				local g1 = colorConVarg1:GetFloat("turretfirstcolor_g")
				local g2 = colorConVarg2:GetFloat("turretsecondcolor_g")
				local b1 = colorConVarb1:GetFloat("turretfirstcolor_b")
				local b2 = colorConVarb2:GetFloat("turretsecondcolor_b")
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				render.SetMaterial(sprite)
				if self.Owner:IsValid() then
				if self.Owner:KeyDown(IN_ATTACK) then
				render.DrawSprite(drawpos, v.size.x, v.size.y, Color(r1,g1,b1))
				else
				render.DrawSprite(drawpos, v.size.x, v.size.y, Color(r2,g2,b2))
				end
				end
				
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

	--[[CreateClientConVar("turretfirstcolor_r", 255, (FCVAR_GAMEDLL), "turret hand not deployed red color parameter", true, true)
	CreateClientConVar("turretfirstcolor_g", 0, (FCVAR_GAMEDLL), "turret hand not deployed green color parameter", true, true)
	CreateClientConVar("turretfirstcolor_b", 0, (FCVAR_GAMEDLL), "turret hand not deployed blue color parameter", true, true)
	CreateClientConVar("turretsecondcolor_r", 0, (FCVAR_GAMEDLL), "turret hand deployed red color parameter", true, true)
	CreateClientConVar("turretsecondcolor_g", 255, (FCVAR_GAMEDLL), "turret hand deployed green color parameter", true, true)
	CreateClientConVar("turretsecondcolor_b", 0, (FCVAR_GAMEDLL), "turret hand deployed blue color parameter", true, true)]]
	
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