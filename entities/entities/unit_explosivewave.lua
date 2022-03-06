
AddCSLuaFile()

DEFINE_BASECLASS( "base_anim" )

ENT.PrintName = "Unit Explosion"
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
	
	self.timer = CurTime() + 0.1
	
	self.Entity:SetModel(model)
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity:DrawShadow(false)
	
	self.Entity:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	
	local phys = self.Entity:GetPhysicsObject()
	
	if (phys:IsValid()) then
		phys:Wake()
	end
	

end

function ENT:HitEffect()
	for k, v in pairs ( ents.FindInSphere( self.Entity:GetPos(), 600 ) ) do
		if v:IsValid() && v:IsPlayer() then
		end	
	end
end

function ENT:Think()
	if self.timer < CurTime() then
	self:Explosion()
	self:EmitSound("ambient/levels/labs/teleport_mechanism_windup1.wav", 1900, 65)
	self.Entity:Remove()
	end
end

function ENT:Explosion() 		  
	local explo = ents.Create( "prop_combine_ball" )
		explo:SetPos( self.Entity:GetPos() ) --explo:SetPos( Vector( 0, 0, 100 ) ) // centre of the map
		explo:Spawn() --explo:Activate()
		explo:Fire( "Explode", "", 0 )
		for k, v in pairs ( ents.FindInSphere( self.Entity:GetPos(), 250 ) ) do
		v:Fire( "EnableMotion", "", math.random( 0, 3 ) )
	    end
end
