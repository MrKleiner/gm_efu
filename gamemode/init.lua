
AddCSLuaFile( "default_player.lua" )
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "realhud.lua" )
AddCSLuaFile( "teamsetup.lua" )
AddCSLuaFile( "alt_flashlight.lua" )
AddCSLuaFile( "fsfdeath.lua" )
AddCSLuaFile( "resource.lua" )
AddCSLuaFile( "fsfinjure.lua" )
include( "spawninit.lua" )
include( "weaponsystem.lua" )
include( "allplayersdied.lua" )
include( "deathspectate.lua" )
include( "anticheat.lua" )
include( "realisticdamage.lua" )
include( "dynamicmovement.lua" )
include( "mapperstuff.lua" )
include( "shared.lua" )
include( "teamsetup.lua" )
include( "tables.lua" )
include( "default_player.lua" )
include( "shared.lua" )
include( "resource.lua" )
include( "fsfdeath.lua" )
include( "fsfinjure.lua" )

resource.AddFile("efu/fsf_attackedbyunit_1.ogg")
resource.AddFile("efu/fsf_attackedbyunit_2.ogg")
resource.AddFile("efu/fsf_attackedbyunit_3.ogg")
resource.AddFile("efu/fsf_attackedbyunit_4.ogg")
resource.AddFile("efu/fsf_attackedbyunit_5.ogg")
resource.AddFile("efu/fsf_foundunit_1.ogg")
resource.AddFile("efu/fsf_foundunit_2.ogg")
resource.AddFile("efu/fsf_foundunit_3.ogg")

function GM:PlayerSpawn( ply )
	ply:SetupHands()
	ply:SetupTeam( math.random(0,3) )
end

function GM:PlayerSetHandsModel( ply, ent )
   local simplemodel = player_manager.TranslateToPlayerModelName(ply:GetModel())
   local info = player_manager.TranslatePlayerHands(simplemodel)
   if info then
      ent:SetModel(info.model)
      ent:SetSkin(info.skin)
      ent:SetBodyGroups(info.body)
   end
end

function GM:PlayerDeathSound()

	return true 
	
end