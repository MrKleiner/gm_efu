local ply = FindMetaTable("Player")

local teams = {0,1,2,3}

teams[0] = {
	name = "FSF Soldier",
	color = Vector( 1.0, 0, 1.0),
	model = ("models/player/combine_soldier_customcombinepmv2.mdl"),
	weapons = { "efu_melee", "efu_handgun", "weapon_sb_pulserifle" } }
teams[1] = {
	name = "FSF Commander",
	color = Vector( 1.0, 0, 0),
	model = ("models/player/combine_super_soldier_customcombinepmv2.mdl"),	
	weapons = { "efu_melee", "efu_handgun", "weapon_sb_pulserifle" } }
teams[2] = {
	name = "Security Guard",
	color = Vector( 0, 1.0, 0),
	model = ("models/player/police.mdl"),	
	weapons = { "efu_handgun", "efu_melee" } }
teams[3] = {
	name = "FSF Juggernault",
	color = Vector( 1.0, 0, 0),
	model = ("models/player/combine_soldier_customcombinepmv2.mdl"),	
	weapons = { "efu_melee", "efu_handgun", "weapon_sb_shotgun" } }
	
function ply:SetupTeam( n )
	if ( not teams[n] ) then return end
	
	self:SetTeam( n )
	--self:SetPlayerColor( teams[n].color )
	self:SetHealth( 100 ) 
	self:SetModel(tostring(teams[n].model))
	
	self:GiveWeapons( n )
	
end

function ply:GiveWeapons( n )
	for k, weapon in pairs( teams[n].weapons ) do
		self:Give( weapon )
	end
end