GM.Name = "Escape From Unit"
GM.Author = "Punker"

DeriveGamemode( "sandbox" )

team.SetUp( 0, "FSF Soldier", Color( 255, 0 ,0 ), Model("models/player/combine_super_soldier_customcombinepmv2.mdl"))
team.SetUp( 1, "FSF Juggernault", Color( 255, 255, 0 ), Model("models/jimice.mdl"))
team.SetUp( 2, "Security Guard", Color( 0, 255 ,0 ), Model("models/player/combine_soldier_customcombinepmv2.mdl"))
team.SetUp( 0, "FSF Commander", Color( 255, 0 ,0 ), Model("models/player/combine_super_soldier_customcombinepmv2.mdl"))

TEAM_FSF = 0
TEAM_FSFCMD = 1
TEAM_GUARDS = 2
TEAM_FSFJ = 3

function GM:CreateTeams()
	
	team.SetUp( TEAM_FSF, "FastSpecialForce", Color( 80, 80, 255 ), true )
	team.SetSpawnPoint( TEAM_FSF, { "info_player_fsf" } )
	
	team.SetUp( TEAM_GUARDS, "Security Guards", Color( 80, 80, 255 ), true )
	team.SetSpawnPoint( TEAM_GUARDS, { "info_player_security" } )
	
	team.SetUp( TEAM_FSFCMD, "FastSpecialForce Commander", Color( 80, 80, 255 ), true )
	team.SetSpawnPoint( TEAM_FSFCMD, { "info_player_fsfcmd" } )
	
	team.SetUp( TEAM_FSFJ, "FastSpecialForce Juggernault", Color( 80, 80, 255 ), true )
	team.SetSpawnPoint( TEAM_FSF, { "info_player_fsf_jiga" } )
	
	team.SetUp( TEAM_SPECTATOR, "Spectators", Color( 80, 255, 150 ), true )
end team.SetSpawnPoint( TEAM_SPECTATOR, { "info_player_counterterrorist", "info_player_combine", "info_player_human", "info_player_deathmatch" } ) 
	team.SetSpawnPoint( TEAM_UNASSIGNED, { "info_player_counterterrorist", "info_player_combine", "info_player_human", "info_player_deathmatch" } ) 

function GM:Initialize()
timer.Simple(1, function()
function HideThings( name )
	if (name == "CHudDamageIndicator" || name == "CHudHintDisplay") then
		return false
	end
end
hook.Add( "HUDShouldDraw", "HideThings", HideThings )
end)
end

function GM:PrecacheResources()
	util.PrecacheSound("efu/fsf_attackedbyunit_1.wav")
	util.PrecacheSound("efu/fsf_attackedbyunit_2.wav")
	util.PrecacheSound("efu/fsf_attackedbyunit_3.wav")
	util.PrecacheSound("efu/fsf_attackedbyunit_4.wav")
	util.PrecacheSound("efu/fsf_attackedbyunit_5.wav")
	util.PrecacheSound("efu/fsf_foundunit_1.wav")
	util.PrecacheSound("efu/fsf_foundunit_2.wav")
	util.PrecacheSound("efu/fsf_foundunit_3.wav")
	for name, mdl in pairs(player_manager.AllValidModels()) do
		util.PrecacheModel(mdl)
	end
end

function GM:IsSpawnpointSuitable( ply, spawnpointent, bMakeSuitable )

	local Pos = spawnpointent:GetPos()

	-- Note that we're searching the default hull size here for a player in the way of our spawning.
	-- This seems pretty rough, seeing as our player's hull could be different.. but it should do the job
	-- ( HL2DM kills everything within a 128 unit radius )
	local Ents = ents.FindInBox( Pos + Vector( -16, -16, 0 ), Pos + Vector( 16, 16, 72 ) )

	if ( ply:Team() == TEAM_SPECTATOR or ply:Team() == TEAM_UNASSIGNED ) then return true end

	local Blockers = 0

	for k, v in pairs( Ents ) do
		if ( IsValid( v ) && v:GetClass() == "player" && v:Alive() ) then

			Blockers = Blockers + 1

			if ( bMakeSuitable ) then
				v:SetVelocity(v:GetPos() + Vector(100,100,0))
			end

		end
	end

	if ( bMakeSuitable ) then return true end
	if ( Blockers > 0 ) then return false end
	return true

end

function GM:OnSpawnMenuOpen()
	return false;
end

function GM:ContextMenuOpen()
	return false;
end 

function GM:PlayerNoClip(ply,desiredState)
	return false;
end 


function GM:PlayerDeathSound()
	return true;
end 

function GM:DrawDeathNotice(x,y)
	return false;
end 


function GM:PlayerSpawnVehicle(ply,model,name,table)
	return false;
end 

function GM:PlayerSpawnSWEP(ply,weapon,info)
	return false;
end 

function GM:PlayerSpawnSENT(ply,class)
	return false;
end 

function GM:PlayerSpawnRagdoll(ply,model)
	return false;
end 

function GM:PlayerSpawnProp(ply,model)
	return false;
end 

function GM:PlayerSpawnObject(ply,model,skin)
	return false;
end 

function GM:PlayerSpawnNPC(ply,npc_type,weapon)
	return false;
end

function GM:PlayerSpawnEffect(ply,model)
	return false;
end 

function GM:PlayerGiveSWEP(ply,weapon,swep)
	return false;
end 

function GM:HUDAmmoPickedUp( item, amount )
	return false;
end 