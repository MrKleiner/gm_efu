--[[local ply = FindMetaTable("Player")

local teams = {0,1,2,3}

teams[0] = {
	name = "FSF Soldier",
	color = Vector( 1.0, 0, 1.0),
	model = ("models/player/combine_super_soldier_customcombinepmv2.mdl"),
	weapons = { "epg_glock18c", "weapon_frag", "weapon_idcard_fsf", "epg_mp5k" } }
teams[1] = {
	name = "FSF Commander",
	color = Vector( 1.0, 0, 0),
	model = ("models/player/combine_soldier_customcombinepmv2.mdl"),	
	weapons = { "epg_m1911", "weapon_frag", "epg_stavenge", "weapon_idcard_fsfcmd", "epg_mp5k" } }
teams[2] = {
	name = "Security Guard",
	color = Vector( 0, 1.0, 0),
	model = ("models/player/police.mdl"),	
	weapons = { "epg_m9", "epg_mp5", "weapon_idcard_guards" } }
teams[3] = {
	name = "Unit",
	color = Vector( 0, 0, 1.0),
	model = ("models/player/charple.mdl"),	
	weapons = { "weapon_crowbar" } }
	
function ply:SetupTeam( n )
	if ( not teams[n] ) then return end
	
	self:SetTeam( n )
	self:SetPlayerColor( teams[n].color )
	self:SetHealth( 100 ) 
	self:SetModel(tostring(teams[n].model))
	
	self:GiveWeapons( n )
	
end

function ply:GiveWeapons( n )
	for k, weapon in pairs( teams[n].weapons ) do
		self:Give( weapon )
	end
end




team.SetUp( 0, "FSF Soldier", Color( 255, 0 ,0 ), Model("models/player/combine_super_soldier_customcombinepmv2.mdl"))
team.SetUp( 1, "FSF Commander", Color( 255, 255, 0 ), Model("models/jimice.mdl"))
team.SetUp( 2, "Security Guard", Color( 0, 255 ,0 ), Model("models/player/combine_soldier_customcombinepmv2.mdl"))
team.SetUp( 3, "Unit", Color( 0, 0 ,255 ), Model("models/player/combine_soldier_customcombinepmv2_new.mdl"))

TEAM_FSF = 1
TEAM_UNIT = 2
TEAM_SECURITY = 3
TEAM_FSFCMD = 4

function GM:CreateTeams()
	
	team.SetUp( TEAM_FSF, "FastSpecialForce", Color( 80, 80, 255 ), true )
	team.SetSpawnPoint( TEAM_FSF, { "info_player_fsf" } )
	
	team.SetUp( TEAM_UNIT, "Unit the MetroCock", Color( 255, 80, 80 ), false )
	team.SetSpawnPoint( TEAM_UNIT, { "info_player_unit" } )
	
	team.SetUp( TEAM_GUARDS, "Security Guards", Color( 80, 80, 255 ), true )
	team.SetSpawnPoint( TEAM_GUARDS, { "info_player_security" } )
	
	team.SetUp( TEAM_FSFCMD, "FastSpecialForce Commander", Color( 80, 80, 255 ), true )
	team.SetSpawnPoint( TEAM_FSFCMD, { "info_player_fsfcmd" } )
	
	team.SetUp( TEAM_SPECTATOR, "Spectators", Color( 80, 255, 150 ), true )
	team.SetSpawnPoint( TEAM_SPECTATOR, { "info_player_counterterrorist", "info_player_combine", "info_player_human", "info_player_deathmatch" } ) 
	team.SetSpawnPoint( TEAM_UNASSIGNED, { "info_player_counterterrorist", "info_player_combine", "info_player_human", "info_player_deathmatch" } ) 

end








]]