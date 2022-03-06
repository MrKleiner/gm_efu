
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

/*---------------------------------------------------------
Initialize
---------------------------------------------------------*/
function ENT:Initialize()

	self.Entity:SetModel("models/props_junk/PopCan01a.mdl")
	self.Entity:SetMaterial("Models/effects/vol_light001")
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:DrawShadow( false )
	self.Entity:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	
	local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
	phys:Wake()
	end
	
	local phys = self.Entity:GetPhysicsObject()
	
	if (phys:IsValid()) then
		phys:Wake()
	end
	
	self.timer = CurTime() + 0.1
end

local exp

function ENT:HitEffect()
	for k, v in pairs ( ents.FindInSphere( self.Entity:GetPos(), 600 ) ) do
		if v:IsValid() && v:IsPlayer() then
		end	
	end
end

function ENT:Think()
	if self.timer < CurTime() then
	self:Screaming()
	end
end

function ENT:Screaming()
	for i, ply in ipairs( player.GetAll() ) do
	self:EmitSound("UNIT.FSFSoldierPanicScream", 1900, 65)
	self.Entity:Remove() 
	end
end

function Sound( name )
	util.PrecacheSound( name )
	return name
end
