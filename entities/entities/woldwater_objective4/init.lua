
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
	self:ObjectiveCompleted()
	self.Entity:Remove()
	end
end

function ENT:ObjectiveCompleted()
for k, v in pairs(player.GetAll()) do
if v then
v:PrintMessage( HUD_PRINTCENTER, "[FSF Commander]: Objective completed." )
v:EmitSound( "efu/objective_completed_v2.wav" )
--v:StartLoopingSound( "efu/motion_lp_fsf.wav" )
timer.Simple(4, function()
v:PrintMessage( HUD_PRINTCENTER, "[FSF Commander]: New objective is in the chat." )
v:EmitSound( "efu/message.wav" )
v:PrintMessage( HUD_PRINTTALK, "Get keycard in security cabinet. Keycard must give access to laboratory." ) -- N E W  O B J E C T I V E  M E S S A G E  T Y P E  H E R E /!\ 
end)
end
end
end

--else if failed use this:
--[[
if v then
v:PrintMessage( HUD_PRINTCENTER, "[FSF Commander]: Somethin is wrong...objective is failed!" )
v:PrintMessage( HUD_PRINTTALK, "ERROR: OBJECTIVE IS FAILED." )
v:EmitSound( "efu/objective_completed.wav" )
v:StartLoopingSound( "efu/motion_lp_fsf.wav" )
end
]]--
