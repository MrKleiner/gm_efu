
SWEP.PrintName = "M67 Frag"

SWEP.Category = "Insurgency"

SWEP.Spawnable= true
SWEP.AdminSpawnable= true
SWEP.AdminOnly = false

SWEP.ViewModelFOV = 65
SWEP.ViewModel = "models/weapons/insurgency/v_m67.mdl"
SWEP.WorldModel = "models/weapons/insurgency/w_m67.mdl"
SWEP.ViewModelFlip = false

SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.Slot = 4
SWEP.SlotPos = 0
 
SWEP.UseHands = false

SWEP.HoldType = "grenade" 

SWEP.FiresUnderwater = false

SWEP.DrawCrosshair = false

SWEP.DrawAmmo = true

SWEP.Base = "weapon_base"

SWEP.CSMuzzleFlashes = true

SWEP.Vehicle = 0
SWEP.Sprint = 0
SWEP.Active = 0
SWEP.Throw = 0

SWEP.Primary.Damage = 160
SWEP.Primary.ClipSize = -1
SWEP.Primary.Ammo = "none"
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Delay = 1
SWEP.Primary.Force = 1000

SWEP.Secondary.ClipSize = 0
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

function SWEP:Initialize()
self:SetWeaponHoldType( self.HoldType )
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
self:SetNextPrimaryFire( CurTime() + self.Owner:GetViewModel():SequenceDuration() )
self:SetNextSecondaryFire( CurTime() + self.Owner:GetViewModel():SequenceDuration() )
self.Weapon:SendWeaponAnim( ACT_VM_DRAW )
local vm = self.Owner:GetViewModel()
vm:SendViewModelMatchingSequence( vm:LookupSequence( "draw" ) )
self.Vehicle = 1
self.Sprint = 0
self.Active = 1
self.Throw = 0
end

function SWEP:Holster()
self.Vehicle = 1
self.Sprint = 0
self.Active = 0
self.Throw = 0
return true
end

function SWEP:PrimaryAttack()

if not( self.Sprint == 0 ) then return end
if self.Throw == 0 then

local vm = self.Owner:GetViewModel()
vm:SendViewModelMatchingSequence( vm:LookupSequence( "pullbackhigh" ) )
self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
self:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
self.Throw = 1
self:EmitSound("efu/vo/frag1.ogg", 150, 85) -- 20:35 YES FINNALY MULTI-SOUNDS
end
timer.Simple( 1.2, function()
if self.Active == 1 and self.Throw == 1 then
self.Owner:SetAnimation( PLAYER_ATTACK1 )
local vm = self.Owner:GetViewModel()
vm:SendViewModelMatchingSequence( vm:LookupSequence( "throw" ) )
if SERVER then
local entity = ents.Create( "efu_m67_entity" )
entity:SetOwner( self.Owner )
if IsValid( entity ) then
local Forward = self.Owner:EyeAngles():Forward()
local Right = self.Owner:EyeAngles():Right()
local Up = self.Owner:EyeAngles():Up()
entity:SetPos( self.Owner:GetShootPos() + Forward * 32 + Right * 15 + Up * 5 )
entity:SetAngles( self.Owner:EyeAngles() )
entity:Spawn()	
local phys = entity:GetPhysicsObject()
phys:SetVelocity( self.Owner:GetAimVector() * self.Primary.Force )
end
end
self.Throw = 2
end
end)
--[[timer.Simple( 1.6, function()
self.Owner:DropWeapon( self.Weapon )
self.Weapon:Remove()
end)]]
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end

function SWEP:Think()
if self.Owner:InVehicle() and self.Vehicle == 0 then
self.Vehicle = 1
end
if not( self.Owner:InVehicle() ) and self.Vehicle == 1 then
self.Vehicle = 0
self:DrawModels()
end
if not( self.Throw == 0 ) then return end
if self.Sprint == 0 then
if self.Owner:KeyDown( IN_SPEED ) and ( self.Owner:KeyDown( IN_FORWARD ) || self.Owner:KeyDown( IN_BACK ) || self.Owner:KeyDown( IN_MOVELEFT ) || self.Owner:KeyDown( IN_MOVERIGHT ) ) then
self.Sprint = 1
self.Iron = 0
end
end
if self.Sprint == 1 then
local vm = self.Owner:GetViewModel()
vm:SendViewModelMatchingSequence( vm:LookupSequence( "sprint" ) )
self.Sprint = 2
end
if self.Sprint == 2 then
if not( self.Owner:KeyDown( IN_SPEED ) ) then
local vm = self.Owner:GetViewModel()
vm:SendViewModelMatchingSequence( vm:LookupSequence( "idle" ) )
self.Sprint = 0
end
if not( self.Owner:KeyDown( IN_FORWARD ) || self.Owner:KeyDown( IN_BACK ) || self.Owner:KeyDown( IN_MOVELEFT ) || self.Owner:KeyDown( IN_MOVERIGHT ) ) then
local vm = self.Owner:GetViewModel()
vm:SendViewModelMatchingSequence( vm:LookupSequence( "idle" ) )
self.Sprint = 0
end
end
end