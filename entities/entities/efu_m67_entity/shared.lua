//ENT.Base = "base_entity"
ENT.Type = "anim"

function ENT:OnRemove()
end

function ENT:PhysicsUpdate()
end

function ENT:PhysicsCollide( data, phys )
if data.Speed > 50 then
self.Entity:EmitSound( "weapon_M67.Bounce" )
end
end