unstuckammo = false
forcebringdisable = false
forcerealisticheadcrabs = false
forcerealisticzombies = false
noweapontransfer = false
flashlights = true

function CheckpointsDisabled(bool)
if(bool) then
	disablecheckpoints = true
else
	disablecheckpoints = false
end
end

function RemoveSpeedMods()
	for k, v in pairs( ents.FindByClass( "player_speedmod" ) ) do
	if(!v:GetName() == "coopspeed1" && !v:GetName() == "coopspeed2" && !v:GetName() == "coopspeed3" && !v:GetName() == "coopspeed") then
		v:Remove()
	end
	end
end

function MapChange(mapname)
	file.Write("weptranslevel.txt",string.lower(mapname))
	file.Write("weptransplayers.txt","")
	file.Write("weptransweps.txt","")
	file.Write("weptransammo.txt","")
	file.Write("weptransammotypes.txt","")
	file.Write("weptranshealth.txt","")
	file.Write("weptransarmor.txt","")
	file.Write("weptransclips.txt","")
	file.Write("weptransalreadygiven.txt","")
	file.Write("weptransmodel.txt","")
	if(game.SinglePlayer()) then
	file.Write("weptransgametype.txt","singleplayer")
	else
	file.Write("weptransgametype.txt","multiplayer")
	end
	for k, v in pairs(player.GetAll()) do
		if(game.SinglePlayer()) then
		file.Write("weptransplayers.txt",1)
		else
			if(v:IsValid()) then
				file.Append("weptransplayers.txt",v:SteamID()..",")
			end
		end
			if(v:IsValid()) then
				if(v:Health() > 25) then
					file.Append("weptranshealth.txt",v:Health()..",")
				else
					file.Append("weptranshealth.txt","25,")
				end
				file.Append("weptransarmor.txt",v:Armor()..",")
				file.Append("weptransmodel.txt",v:GetModel()..",")
				v:ScreenFade(SCREENFADE.OUT, color_black,1.5,9999)
				v:Freeze(true)
					for l, m in pairs(v:GetWeapons()) do
						file.Append("weptransweps.txt",m:GetClass()..",")
						file.Append("weptransclips.txt",m:Clip1()..",")
					end
						file.Append("weptransweps.txt","\n")
						file.Append("weptransclips.txt","\n")
					for d, z in pairs(v:GetAmmo()) do
						file.Append("weptransammo.txt",z..",")
						file.Append("weptransammotypes.txt",game.GetAmmoName(d)..",")
					end
				file.Append("weptransammo.txt","\n")
				file.Append("weptransammotypes.txt","\n")
			end
	end
	timer.Simple( 2, function() RunConsoleCommand("changelevel",string.lower(mapname)) end )
	timer.Simple( 4, function() PrintMessage( HUD_PRINTTALK,"Next map not found! Download the next map!" ) end )
	timer.Simple( 7, function() RunConsoleCommand("disconnect") end )
end

function LoadWeapons()
	if(game.SinglePlayer() && file.Read("weptransgametype.txt","DATA") == "singleplayer") then
	local ply = Entity(1)
				if(ply:IsValid()) then
					ply:SetHealth(string.Split(file.Read("weptranshealth.txt","DATA"),",")[1])
					ply:SetArmor(string.Split(file.Read("weptransarmor.txt","DATA"),",")[1])
					ply:SetModel(string.Split(file.Read("weptransmodel.txt","DATA"),",")[1])
					ply.UseWeaponSpawn = CurTime()
					for m, l in pairs(string.Split(string.Split(file.Read("weptransweps.txt","DATA"),"\n")[1],",")) do
						if(l != "") then
							ply:Give(l,true)
							ply:GetWeapon(l):SetClip1(string.Split(string.Split(file.Read("weptransclips.txt","DATA"),"\n")[1],",")[m])
						end
					end
				end
				timer.Simple( 0.1, function()
				for d, z in pairs(string.Split(string.Split(file.Read("weptransammotypes.txt","DATA"),"\n")[1],",")) do
					if(z != "") then
						if(ply:IsValid()) then
							ply:GiveAmmo(string.Split(string.Split(file.Read("weptransammo.txt","DATA"),"\n")[1],",")[d],z,true)
						end
					end
				end
				end )
	else if (!game.SinglePlayer() && file.Read("weptransgametype.txt","DATA") == "multiplayer") then
	for k, v in pairs(string.Split(file.Read("weptransplayers.txt","DATA"),",")) do
	local ply = player.GetBySteamID(v)
		if(ply != false && ply:GetNWBool("givenloadout") != true) then
				if(ply:IsValid()) then
					ply:SetNWBool("givenloadout",true)
					file.Append("weptransalreadygiven.txt",ply:SteamID()..",")
					ply:SetHealth(string.Split(file.Read("weptranshealth.txt","DATA"),",")[k])
					ply:SetArmor(string.Split(file.Read("weptransarmor.txt","DATA"),",")[k])
					ply:SetModel(string.Split(file.Read("weptransmodel.txt","DATA"),",")[k])
					ply.UseWeaponSpawn = CurTime()
				for m, l in pairs(string.Split(string.Split(file.Read("weptransweps.txt","DATA"),"\n")[k],",")) do
					if(l != "") then
						ply:Give(l,true)
						ply:GetWeapon(l):SetClip1(string.Split(string.Split(file.Read("weptransclips.txt","DATA"),"\n")[k],",")[m])
					end
				end
				end
				timer.Simple( 0.1, function()
				for d, z in pairs(string.Split(string.Split(file.Read("weptransammotypes.txt","DATA"),"\n")[k],",")) do
					if(z != "") then
						if(ply:IsValid()) then
							ply:GiveAmmo(string.Split(string.Split(file.Read("weptransammo.txt","DATA"),"\n")[k],",")[d],z,true)
						end
					end
				end
				end )
		end
	end
	end
	end
end

hook.Add( "PlayerDeath", "LoadoutDeath", function( victim, inflictor, attacker )
	if(victim:GetNWBool("givenloadout") != true) then
		if(victim:IsValid()) then
			file.Append("weptransalreadygiven.txt",victim:SteamID()..",")
		end
	end
	if(victim:IsValid()) then victim:SetNWBool("givenloadout",true) end
end )

--[[function lddisc( ply )
	if(!CheckGiven(player)) then
	file.Append("weptransalreadygiven.txt",ply:SteamID()..",")
	end
end
hook.Add( "PlayerDisconnected", "loadoutdisconnect", lddisc )]]--

--[[function CheckGiven(ply)
for k, v in pairs(string.Split(file.Read("weptransalreadygiven.txt","DATA"),",")) do
	local ply = player.GetBySteamID(v)
	if(ply != false) then
		return true
	end
end
	return false
end]]--

hook.Add( "PlayerSpawn", "LevelChangeLoadout", function(player)
	timer.Simple(2,function()
		if(!noweapontransfer) then
			if(player:IsValid() && player:GetNWBool("givenloadout") != true) then
--	if(!CheckGiven(player)) then
				if(game.GetMap() == file.Read("weptranslevel.txt")) then
					LoadWeapons()
				end
--	end 
			end
		end
	end )
end )

function EmptyTransferData()
	file.Write("weptranslevel.txt","")
	file.Write("weptransplayers.txt","")
	file.Write("weptransweps.txt","")
	file.Write("weptransammo.txt","")
	file.Write("weptransammotypes.txt","")
	file.Write("weptranshealth.txt","")
	file.Write("weptransarmor.txt","")
	file.Write("weptransclips.txt","")
	file.Write("weptransalreadygiven.txt","")
	file.Write("weptransmodel.txt","")
end

function AllFrozen(bool)
if(bool) then
	for k, v in pairs(player.GetAll()) do v:Freeze(true) end
else
	for k, v in pairs(player.GetAll()) do v:Freeze(false) end
end
end

function UnfreezeAmmo()
	if(unstuckammo == false) then
		for k, v in pairs( ents.FindByClass( "item_*" ) ) do
		v:SetPos(v:GetPos() + Vector(0,0,1))
		unstuckammo = true
		end
	end
end

local function spawnspeedmodremove( ply )
	RemoveSpeedMods()
	UnfreezeAmmo()
end
hook.Add( "PlayerInitialSpawn", "InitialSpawnRemove", spawnspeedmodremove )

local function MapperStuffInit()
	timer.Simple(2, function()
	RemoveSpeedMods()
	UnfreezeAmmo()
	--if(#ents.FindByClass("weapon_crowbar") != 0) then StartWithNothing(true) end
	end )
end
hook.Add( "Initialize", "RemoveSpeedModInit", MapperStuffInit )

function FlashlightStatus(allow)
if(allow) then
	for k, v in pairs(player.GetAll()) do v:AllowFlashlight(true) end
	flashlights = true
else
	for k, v in pairs(player.GetAll()) do v:AllowFlashlight(false) end
	flashlights = false
end
end



hook.Add( "PlayerSwitchFlashlight", "FlashlightSettings", function( ply, enabled )
	return flashlights
end )

function ForceRealismEnable(bool)
if(bool) then
	forcerealismenable = true
else
	forcerealismenable = false
end
end

function ForceBringDisable(bool)
if(bool) then
	forcebringdisable = true
else
	forcebringdisable = false
end
end

function ForceRealisticZombies(bool)
if(bool) then
	forcerealisticzombies = true
else
	forcerealisticzombies = false
end
end

function ForceRealisticHeadcrabs(bool)
if(bool) then
	forcerealisticheadcrabs = true
else
	forcerealisticheadcrabs = false
end
end
