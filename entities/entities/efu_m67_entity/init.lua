AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

function ENT:Initialize()
self.Entity:SetModel( "models/weapons/insurgency/w_m67.mdl" )
self.Entity:PhysicsInit( SOLID_VPHYSICS )
self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
self.Entity:SetSolid( SOLID_VPHYSICS )
self.Entity:DrawShadow( false )
self.Entity:SetOwner( self.Owner )
self.Entity:SetCollisionGroup( COLLISION_GROUP_INTERACTIVE )
local phys = self.Entity:GetPhysicsObject()
if ( phys:IsValid() ) then
phys:Wake()
end
self.DetonateTimer = CurTime() + 3
end

function ENT:Think()
if self.DetonateTimer <= CurTime() then

	local effectData = EffectData()
	effectData:SetOrigin(self:GetPos())
	//effectData:SetScale(500)
	--//util.Effect("HelicopterMegaBomb", effectData)
	--/util.Effect("ThumperDust", effectData)
	--util.Effect("Explosion", effectData)
	util.Effect("Realistic_Explosion", effectData) --VJ_Small_Explosion1 
		-- util.Effect("Realistic_Explosion", effectData) --VJ_Small_Explosion1
	self.Entity:EmitSound( "weapons/rpg7/rpg1_explosion1.wav" ) --hit
	self:EmitSound("efu/explode.wav", 1900, 100)
	self:EmitSound("weapons/firearms/distance/dust_fall_01.ogg", 1900, 82)
	self:EmitSound("weapons/firearms/distance/dist_explosion_single_01.ogg", 81900, 100)
	self:Explosion()

local shake = ents.Create( "env_shake" )
		shake:SetOwner( self.Owner )
		shake:SetPos( self.Entity:GetPos() )
		shake:SetKeyValue( "amplitude", "2000" )	-- Power of the shake
		shake:SetKeyValue( "radius", "1200" )	-- Radius of the shake
		shake:SetKeyValue( "duration", "1.75" )	-- Time of shake
		shake:SetKeyValue( "frequency", "255" )	-- How har should the screenshake be
		shake:SetKeyValue( "spawnflags", "4" )	-- Spawnflags( In Air )
		shake:Spawn()
		shake:Activate()
		shake:Fire( "StartShake", "", 0 ) --self.Entity:EmitSound( "Weapon_M67.Explode" )
		self.Entity:Remove()
end
end


function ENT:Explosion()

	local effectData = EffectData()
	effectData:SetOrigin(self:GetPos())
	
	local physexp = ents.Create( "env_physexplosion" )
		physexp:SetOwner( self.Owner )
		physexp:SetPos( self.Entity:GetPos() )
		physexp:SetKeyValue( "magnitude", "15" )
		physexp:SetKeyValue( "radius", "650" )
		physexp:Spawn()
		physexp:Activate()
		physexp:Fire( "Explode", "", 0 )	
	
	local explo = ents.Create( "point_hurt" )
		explo:SetOwner( self.GrenadeOwner )
		explo:SetPos( self.Entity:GetPos() )
		explo:SetKeyValue( "Damage", "125" )
		explo:SetKeyValue( "DamageDelay", "0.25" )
		explo:SetKeyValue( "DamageRadius", "159" )
		explo:SetKeyValue( "DamageType", "64" )
		explo:Spawn()
		explo:Activate()
		explo:Fire( "Hurt", "", 0 )
	
	local physexp = ents.Create( "env_physexplosion" )
		physexp:SetOwner( self.Owner )
		physexp:SetPos( self.Entity:GetPos() )
		physexp:SetKeyValue( "magnitude", "15" )
		physexp:SetKeyValue( "radius", "650" )
		physexp:Spawn()
		physexp:Activate()
		physexp:Fire( "Explode", "", 0 )	
	
	local explo = ents.Create( "point_hurt" )
		explo:SetOwner( self.GrenadeOwner )
		explo:SetPos( self.Entity:GetPos() )
		explo:SetKeyValue( "Damage", "85" )
		explo:SetKeyValue( "DamageDelay", "0.25" )
		explo:SetKeyValue( "DamageRadius", "159" )
		explo:SetKeyValue( "DamageType", "64" )
		explo:Spawn()
		explo:Activate()
		explo:Fire( "Hurt", "", 0 )
	
	
	local shake = ents.Create( "env_shake" )
		shake:SetOwner( self.Owner )
		shake:SetPos( self.Entity:GetPos() )
		shake:SetKeyValue( "amplitude", "2000" )	-- Power of the shake
		shake:SetKeyValue( "radius", "900" )	-- Radius of the shake
		shake:SetKeyValue( "duration", "2.5" )	-- Time of shake
		shake:SetKeyValue( "frequency", "255" )	-- How har should the screenshake be
		shake:SetKeyValue( "spawnflags", "4" )	-- Spawnflags( In Air )
		shake:Spawn()
		shake:Activate()
		shake:Fire( "StartShake", "", 0 )
	
	        	local ent = ents.Create("prop_physics")
        ent:SetModel("models/props_junk/rock001a.mdl")
	ent:SetPos(self:GetPos())
	ent:SetAngles(self:GetAngles())
	ent:Spawn()
	ent:SetCollisionGroup(SOLID_VPHYSICS)
	        	local ent = ents.Create("prop_physics")
        ent:SetModel("models/props_junk/rock001a.mdl")
	ent:SetPos(self:GetPos())
	ent:SetAngles(self:GetAngles())
	ent:Spawn()
	ent:SetCollisionGroup(SOLID_VPHYSICS)
	        	local ent = ents.Create("prop_physics")
        ent:SetModel("models/props_debris/rebar001a_32.mdl")
	ent:SetPos(self:GetPos())
	ent:SetAngles(self:GetAngles())
	ent:Spawn()
	ent:SetCollisionGroup(SOLID_VPHYSICS)
	        	local ent = ents.Create("prop_physics")
        ent:SetModel("models/props_debris/concrete_chunk04a.mdl")
	ent:SetPos(self:GetPos())
	ent:SetAngles(self:GetAngles())
	ent:Spawn()
	ent:SetCollisionGroup(SOLID_VPHYSICS)
	
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