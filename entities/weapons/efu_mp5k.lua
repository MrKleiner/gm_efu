
SWEP.PrintName = "MP5K"

SWEP.Category = "Insurgency"

SWEP.Spawnable= true
SWEP.AdminSpawnable= true
SWEP.AdminOnly = false

SWEP.ViewModelFOV = 62
SWEP.ViewModel = "models/weapons/insurgency/v_mp5kpdw.mdl"
SWEP.WorldModel = "models/weapons/insurgency/w_mp5k.mdl"
SWEP.ViewModelFlip = false

SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.Slot = 0
SWEP.SlotPos = 0
 
SWEP.UseHands = true

SWEP.HoldType = "smg" 

SWEP.FiresUnderwater = false

SWEP.DrawCrosshair = false

SWEP.DrawAmmo = true

SWEP.Base = "weapon_base"

SWEP.CSMuzzleFlashes = true

SWEP.Vehicle = 0
SWEP.FirstTime = 0
SWEP.Sprint = 0
SWEP.Reloading = 0
SWEP.IronSightsPos = Vector( -2.31, 0, 0.65 )
SWEP.IronSightsAng = Vector( 0, 0, 0 )
SWEP.Primary.Cone = 0.02
SWEP.NextSecondaryAttack = 0.2

SWEP.Primary.Sound = Sound( "Weapon_mp5k.Single" )
SWEP.Primary.Damage = 60
SWEP.Primary.TakeAmmo = 1
SWEP.Primary.ClipSize = 30
SWEP.Primary.Ammo = "smg1"
SWEP.Primary.DefaultClip = 360
SWEP.Primary.Spread = 0.1
SWEP.Primary.NumberofShots = 1
SWEP.Primary.Automatic = true
SWEP.Primary.Recoil = 1
SWEP.Primary.Delay = 0.07
SWEP.Primary.Force = 1

SWEP.Secondary.ClipSize = 0
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

function SWEP:Initialize()
self:SetWeaponHoldType( self.HoldType )
self.FirstTime = 1
end 


function SWEP:DrawModels()
if CLIENT then
if GetConVar( "hands_model" ):GetInt() == 1 then
self.Hands = ClientsideModel( "models/weapons/insurgency/v_hands_sec_h.mdl", RENDERGROUP_VIEWMODEL )
local vm = self.Owner:GetViewModel()
self.Hands:SetPos( vm:GetPos() )
self.Hands:SetAngles( vm:GetAngles() )
self.Hands:AddEffects( EF_BONEMERGE )
self.Hands:SetNoDraw( true )
self.Hands:SetParent( vm )
self.Hands:DrawModel()
end
if GetConVar( "hands_model" ):GetInt() == 2 then
self.Hands = ClientsideModel( "models/weapons/insurgency/v_hands_sec_h.mdl", RENDERGROUP_VIEWMODEL )
local vm = self.Owner:GetViewModel()
self.Hands:SetPos( vm:GetPos() )
self.Hands:SetAngles( vm:GetAngles() )
self.Hands:AddEffects( EF_BONEMERGE )
self.Hands:SetNoDraw( true )
self.Hands:SetParent( vm )
self.Hands:DrawModel()
end
if GetConVar( "hands_model" ):GetInt() == 3 then
self.Hands = ClientsideModel( "models/weapons/insurgency/v_hands_sec_h.mdl", RENDERGROUP_VIEWMODEL )
local vm = self.Owner:GetViewModel()
self.Hands:SetPos( vm:GetPos() )
self.Hands:SetAngles( vm:GetAngles() )
self.Hands:AddEffects( EF_BONEMERGE )
self.Hands:SetNoDraw( true )
self.Hands:SetParent( vm )
self.Hands:DrawModel()
end
if GetConVar( "hands_model" ):GetInt() == 4 then
self.Hands = ClientsideModel( "models/weapons/insurgency/v_hands_sec_h.mdl", RENDERGROUP_VIEWMODEL )
local vm = self.Owner:GetViewModel()
self.Hands:SetPos( vm:GetPos() )
self.Hands:SetAngles( vm:GetAngles() )
self.Hands:AddEffects( EF_BONEMERGE )
self.Hands:SetNoDraw( true )
self.Hands:SetParent( vm )
self.Hands:DrawModel()
end
if GetConVar( "hands_model" ):GetInt() == 5 then
self.Hands = ClientsideModel( "models/weapons/insurgency/v_hands_sec_h.mdl", RENDERGROUP_VIEWMODEL )
local vm = self.Owner:GetViewModel()
self.Hands:SetPos( vm:GetPos() )
self.Hands:SetAngles( vm:GetAngles() )
self.Hands:AddEffects( EF_BONEMERGE )
self.Hands:SetNoDraw( true )
self.Hands:SetParent( vm )
self.Hands:DrawModel()
end
if GetConVar( "hands_model" ):GetInt() == 6 then
self.Hands = ClientsideModel( "models/weapons/insurgency/v_hands_sec_h.mdl", RENDERGROUP_VIEWMODEL )
local vm = self.Owner:GetViewModel()
self.Hands:SetPos( vm:GetPos() )
self.Hands:SetAngles( vm:GetAngles() )
self.Hands:AddEffects( EF_BONEMERGE )
self.Hands:SetNoDraw( true )
self.Hands:SetParent( vm )
self.Hands:DrawModel()
end
if GetConVar( "hands_model" ):GetInt() == 7 then
self.Hands = ClientsideModel( "models/weapons/insurgency/v_hands_sec_h.mdl", RENDERGROUP_VIEWMODEL )
local vm = self.Owner:GetViewModel()
self.Hands:SetPos( vm:GetPos() )
self.Hands:SetAngles( vm:GetAngles() )
self.Hands:AddEffects( EF_BONEMERGE )
self.Hands:SetNoDraw( true )
self.Hands:SetParent( vm )
self.Hands:DrawModel()
end
end
end


function SWEP:ViewModelDrawn()
if CLIENT then
if not( self.Hands ) then
self:DrawModels()
end
if self.Hands then
self.Hands:DrawModel()
end
end
end

function SWEP:Deploy()
if self.Weapon:Clip1() > 0 then
self:SetNextPrimaryFire( CurTime() + self.Owner:GetViewModel():SequenceDuration() )
self:SetNextSecondaryFire( CurTime() + self.Owner:GetViewModel():SequenceDuration() )
end
self.Weapon:SendWeaponAnim( ACT_VM_DRAW )
if self.FirstTime == 0 then
local vm = self.Owner:GetViewModel()
vm:SendViewModelMatchingSequence( vm:LookupSequence( "base_draw" ) )
end
if self.FirstTime == 1 then
local vm = self.Owner:GetViewModel()
vm:SendViewModelMatchingSequence( vm:LookupSequence( "base_ready" ) )
self:SetNextPrimaryFire( CurTime() + self.Owner:GetViewModel():SequenceDuration() )
self:SetNextSecondaryFire( CurTime() + self.Owner:GetViewModel():SequenceDuration() )
self.FirstTime = 0
end
self.Vehicle = 1
self.Sprint = 0
self.Reloading = 0
self.NextSecondaryAttack = 0
self:SetIronsights( false )
end

function SWEP:Holster()
self.Vehicle = 1
self.Sprint = 0
self.Reloading = 0
self.NextSecondaryAttack = 0
self:SetIronsights( false )
return true
end

function SWEP:PrimaryAttack()

if not( self.Sprint == 0 ) then return end
if ( !self:CanPrimaryAttack() ) then return end

local bullet = {} 
bullet.Num = self.Primary.NumberofShots 
bullet.Src = self.Owner:GetShootPos() 
bullet.Dir = self.Owner:GetAimVector() 
bullet.Spread = Vector( self.Primary.Spread * 0.1, self.Primary.Spread * 0.1, 0 )
bullet.Tracer = 1 
bullet.Force = self.Primary.Force 
bullet.Damage = self.Primary.Damage 
bullet.AmmoType = self.Primary.Ammo 

self:ShootEffects()
local vm = self.Owner:GetViewModel()
vm:SendViewModelMatchingSequence( vm:LookupSequence( "base_fire" ) )
if self.Weapon:GetNetworkedBool( "Ironsights", true ) then
local vm = self.Owner:GetViewModel()
vm:SendViewModelMatchingSequence( vm:LookupSequence( "iron_fire_a" ) )
end
self.Owner:FireBullets( bullet )
self:EmitSound( Sound( self.Primary.Sound ) )
self.Owner:MuzzleFlash()
self.Owner:ViewPunchReset()
self.Owner:ViewPunch( Angle( -1 * self.Primary.Recoil, math.Rand( -0.5, 2 ) *self.Primary.Recoil, 0 ) )
self.Owner:SetEyeAngles( self.Owner:EyeAngles() + Angle( -1, 0, 0 ) )
self:TakePrimaryAmmo( self.Primary.TakeAmmo )
self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
self:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
end

local IRONSIGHT_TIME = 0.2

function SWEP:GetViewModelPosition( pos, ang )

if ( !self.IronSightsPos ) then return pos, ang end

local bIron = self.Weapon:GetNetworkedBool( "Ironsights" )

if ( bIron != self.bLastIron ) then

self.bLastIron = bIron
self.fIronTime = CurTime()

if ( bIron ) then
self.SwayScale = 0.1
self.BobScale = 0.1
else
self.SwayScale = 1.0
self.BobScale = 1.0
end
end

local fIronTime = self.fIronTime or 0

if ( !bIron && fIronTime < CurTime() - IRONSIGHT_TIME ) then 
return pos, ang 
end

local Mul = 1.0

if ( fIronTime > CurTime() - IRONSIGHT_TIME ) then

Mul = math.Clamp( ( CurTime() - fIronTime) / IRONSIGHT_TIME, 0, 1 )

if ( !bIron ) then Mul = 1 - Mul end

end

local Offset = self.IronSightsPos

if ( self.IronSightsAng ) then
	
ang = ang * 1
ang:RotateAroundAxis( ang:Right(), self.IronSightsAng.x * Mul )
ang:RotateAroundAxis( ang:Up(), self.IronSightsAng.y * Mul )
ang:RotateAroundAxis( ang:Forward(), self.IronSightsAng.z * Mul )

end

local Right = ang:Right()
local Up = ang:Up()
local Forward = ang:Forward()

pos = pos + Offset.x * Right * Mul
pos = pos + Offset.y * Forward * Mul
pos = pos + Offset.z * Up * Mul

return pos, ang

end

function SWEP:SetIronsights( b )
self.Weapon:SetNetworkedBool( "Ironsights", b )
end

function SWEP:SecondaryAttack()

if ( !self.IronSightsPos ) then return end
if ( self.NextSecondaryAttack > CurTime() ) then return end
	
bIronsights = !self.Weapon:GetNetworkedBool( "Ironsights", false )

self:SetIronsights( bIronsights )

self.NextSecondaryAttack = CurTime() + 0.2
end

function SWEP:OnRestore()
self.Vehicle = 0
self.Sprint = 0
self.Reloading = 0
self.NextSecondaryAttack = 0
self:SetIronsights( false )
end

function SWEP:Reload()
if self.Weapon:Clip1() < self.Primary.ClipSize and self.Weapon:Ammo1() > 0 then
self.Weapon:DefaultReload( ACT_VM_RELOAD )
if self.Weapon:Clip1() > 0 then
local vm = self.Owner:GetViewModel()
vm:SendViewModelMatchingSequence( vm:LookupSequence( "base_reload" ) )
end
if self.Weapon:Clip1() <= 0 then
local vm = self.Owner:GetViewModel()
vm:SendViewModelMatchingSequence( vm:LookupSequence( "base_reloadempty" ) )
self:SetNextPrimaryFire( CurTime() + self.Owner:GetViewModel():SequenceDuration() )
self:SetNextSecondaryFire( CurTime() + self.Owner:GetViewModel():SequenceDuration() )
end
self.Sprint = 0
self.Reloading = 1
self:EmitSound("efu/vo/ammolow2.ogg", 100, 85)
if self.Reloading == 1 and self.Weapon:Clip1() <= 0 then
timer.Simple( 5, function()
if self.Reloading == 1 then
self.Reloading = 0
end
end)
end
if self.Reloading == 1 and self.Weapon:Clip1() > 0 then
timer.Simple( 2.5, function()
if self.Reloading == 1 then
self.Reloading = 0
end
end)
end
self.NextSecondaryAttack = 0
self:SetIronsights( false )
end
end

function SWEP:Think()
if self.Owner:InVehicle() and self.Vehicle == 0 then
self.Vehicle = 1
end
if not( self.Owner:InVehicle() ) and self.Vehicle == 1 then
self.Vehicle = 0
self:DrawModels()
end
if self.Owner:KeyPressed( IN_RELOAD ) and self.Weapon:Clip1() < self.Primary.ClipSize and self.Weapon:Ammo1() > 0 then
self.Sprint = 0
self.Reloading = 1
end
if self.Owner:KeyPressed( IN_ATTACK ) and self.Weapon:Clip1() <= 0 and self.Weapon:Ammo1() > 0 then
self.Sprint = 0
self.Reloading = 1
end
if self.Owner:KeyDown( IN_ATTACK ) and self.Weapon:Clip1() <= 0 and self.Weapon:Ammo1() > 0 then
self.Sprint = 0
self.Reloading = 1
end
if self.Reloading == 1 then return end
if self.Sprint == 0 and self.Reloading == 0 then
if self.Owner:KeyDown( IN_SPEED ) and ( self.Owner:KeyDown( IN_FORWARD ) || self.Owner:KeyDown( IN_BACK ) || self.Owner:KeyDown( IN_MOVELEFT ) || self.Owner:KeyDown( IN_MOVERIGHT ) ) then
self.Sprint = 1
self.NextSecondaryAttack = 0
self:SetIronsights( false )
end
end
if self.Sprint == 1 and self.Reloading == 0 then
local vm = self.Owner:GetViewModel()
vm:SendViewModelMatchingSequence( vm:LookupSequence( "base_sprint" ) )
self.Sprint = 2
end
if self.Sprint == 2 and self.Reloading == 0 then
if not( self.Owner:KeyDown( IN_SPEED ) ) and self.Reloading == 0 then
local vm = self.Owner:GetViewModel()
vm:SendViewModelMatchingSequence( vm:LookupSequence( "base_idle" ) )
self:SetNextPrimaryFire( CurTime() + 0.05 )
self:SetNextSecondaryFire( CurTime() + 0.05 )
self.Sprint = 0
end
if self.Reloading == 0 and not( self.Owner:KeyDown( IN_FORWARD ) || self.Owner:KeyDown( IN_BACK ) || self.Owner:KeyDown( IN_MOVELEFT ) || self.Owner:KeyDown( IN_MOVERIGHT ) ) then
local vm = self.Owner:GetViewModel()
vm:SendViewModelMatchingSequence( vm:LookupSequence( "base_idle" ) )
self:SetNextPrimaryFire( CurTime() + 0.05 )
self:SetNextSecondaryFire( CurTime() + 0.05 )
self.Sprint = 0
end
end
end