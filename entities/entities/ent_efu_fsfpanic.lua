--[[
AddCSLuaFile()

DEFINE_BASECLASS( "base_anim" )

ENT.PrintName = "FSF Panic Entity (because fucking normal coding doesnt works on gmod so I have to make attach entity that plays sounds while player near unit the metrocock"
ENT.Author = "Punker"
ENT.Category = "Unit"

ENT.Spawnable = false
ENT.AdminOnly = false

function ENT:SpawnFunction( ply, tr, ClassName )

	if ( !tr.Hit ) then return end

	local ent = ents.Create( ClassName )
	ent:SetPos( tr.HitPos + tr.HitNormal )
	ent:Spawn()
	ent:Activate()

	--return ent

end

--local exp

function ENT:Initialize()

	local model = ("models/props_junk/PopCan01a.mdl")
	
	self.Entity:SetModel(model)
	self.Entity:SetMaterial("Models/effects/vol_light001")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity:DrawShadow(false)
	
	self.Entity:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	
	local phys = self.Entity:GetPhysicsObject()
	
	if (phys:IsValid()) then
		phys:Wake()
	end

	self.timer = CurTime() + 0.1
end

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
	EmitSound( Sound( 'UNIT.FSFSoldierScream' ), Entity(1):GetPos(), 1, CHAN_AUTO, 1, 75, 0, 100 )
	self.Entity:Remove() 
	end
end

function ENT:OnTakeDamage( dmginfo )
end

function ENT:Use( activator, caller, type, value )
end

function ENT:StartTouch( entity )
end

function ENT:EndTouch( entity )
end


function ENT:Touch( entity )
end
]]
