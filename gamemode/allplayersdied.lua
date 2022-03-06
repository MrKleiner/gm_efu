CreateConVar( "gc_realismmode", 1, SERVER_CAN_EXECUTE, "Players don't respawn when they die, if all players die the map restarts" )
CreateConVar( "gc_allowcheckpoints", 1, SERVER_CAN_EXECUTE, "Health re-chargers and some doors act as checkpoints." )
util.PrecacheSound("efu/fsf_alldied1.wav")

restarting = 0
firstdeath = Vector(0,0,0)
anydeaths = false
forcerealismenable = false
disablecheckpoints = false
usedcheckpoints = {}
failmusic = "efu/fsf_alldied1.wav"

function MapLoadFunctionInitDead()
	timer.Simple(2,function()
	timer.Create( "DeadPlayerChecker", 1, 0, function()
	CheckingAlivePlayers()
	end )
	end )
end
hook.Add( "Initialize", "MapLoadFunctionDeadChecking", MapLoadFunctionInitDead );

function MissionFailed()
	if(restarting == 0) then
	restarting = 1
	for k, v in pairs(player.GetAll()) do 
		if(v:IsValid()) then
			v:ScreenFade(SCREENFADE.OUT, color_black,6,2) 
			v:Freeze(true)
			v:ConCommand("play " .. failmusic)
			v:StripAmmo()
			v:StripWeapons()
		end
	end

	--local relay = ents.FindByName(mission_failed_entity)[1]
	--if (relay != nil) then
	--relay:Fire("Trigger")
	--end
	if (mission_failed_entity ~= nil) then
	local relay = ents.FindByName(mission_failed_entity)[1]
	if (relay ~= nil) then
	relay:Fire("Trigger")
	end
	end
	stopspawning = false;
	timer.Simple( 7.1, function() 
		for m, l in pairs(player.GetAll()) do 
			if(l:IsValid()) then
				l:UnSpectate()
				l:Freeze(false)
			end
			restarting = 0
		end
		timer.Simple( 0.2, function() 
			RunConsoleCommand("changelevel",game.GetMap())
		end ) 
	end )
	end
end


function CheckingAlivePlayers()
	aliveplayers = 0 
	deadplayers = 0
	for k, v in pairs(player.GetAll()) do 
		if (v:IsValid() && v:Alive()) then 
		aliveplayers = aliveplayers + 1 
		end 
		if (v:IsValid() && !v:Alive()) then 
		deadplayers = deadplayers + 1 
		end 
	end
	if(aliveplayers == 0 && deadplayers != 0 && restarting == 0) then 
		if((GetConVarNumber( "gc_realismmode" ) == 1) || forcerealismenable) then
		restarting = 1
		for k, v in pairs(player.GetAll()) do 
		v:ScreenFade(SCREENFADE.OUT, color_black,6,2)
		v:Freeze(true)
		v:ConCommand("play " .. failmusic)
		end

		--local relay = ents.FindByName(mission_failed_entity)[1]
		--if (relay != nil) then
		--relay:Fire("Trigger")
		--end
		if (mission_failed_entity ~= nil) then
		local relay = ents.FindByName(mission_failed_entity)[1]
		if (relay ~= nil) then
		relay:Fire("Trigger")
		end
		end
		timer.Simple( 7.1, function() timer.Simple( 0.2, function() RunConsoleCommand("changelevel",game.GetMap()) end ) end )
		end
	end
end

function canrespawn( ply )
	if(((GetConVarNumber( "gc_realismmode" ) == 1) || forcerealismenable) && stopspawning) then
	return false
	end
end
hook.Add( "PlayerDeathThink", "PlayerDontSpawn", canrespawn);

hook.Add( "PlayerUse", "CheckPointRecharger", function( ply, ent )
if(ent:IsValid() && ent:GetClass() == "item_suitcharger") then if(ply:Armor() < 100) then ply:SetArmor(100) ent:EmitSound( "items/suitchargeok1.wav", 75, 100, 1, CHAN_AUTO ) end end
if((GetConVarNumber( "gc_allowcheckpoints" ) == 1) && (disablecheckpoints == false) && ((GetConVarNumber( "gc_realismmode" ) == 1) || forcerealismenable)) then
	if(ent:IsValid() && ent:GetClass() == "item_healthcharger") then
	if(ply:Health() < 100) then ply:SetHealth(100) ent:EmitSound( "items/medshot4.wav", 75, 100, 1, CHAN_AUTO ) end
		if(!table.HasValue(usedcheckpoints,ent:MapCreationID())) then
			table.insert(usedcheckpoints,ent:MapCreationID())
			for _, l in pairs(ents.GetAll()) do 
			if((l:GetPos():Distance(ent:GetPos()) < 3500) && l:GetClass() == "item_healthcharger") then table.insert(usedcheckpoints,l:MapCreationID()) end 
			if((l:GetPos():Distance(ent:GetPos()) < 3500) && l:GetClass() == "prop_door_rotating") then table.insert(usedcheckpoints,l:MapCreationID()) end 
			end
			ActivateCheckpoint(ply:GetPos(),true)
		else
		end
	end
end
end )

hook.Add( "PlayerUse", "CheckPointDoors", function( ply, ent )
if((GetConVarNumber( "gc_allowcheckpoints" ) == 1) && (disablecheckpoints == false) && ((GetConVarNumber( "gc_realismmode" ) == 1) || forcerealismenable)) then
	if(ent:IsValid() && (ent:GetClass() == "prop_door_rotating") && (!ent:GetSaveTable( ).m_bLocked)) then
			if(!table.HasValue(usedcheckpoints,ent:MapCreationID())) then
			table.insert(usedcheckpoints,ent:MapCreationID())
			if (ent:GetPos():Distance(firstdeath) > 3500) then
			ActivateCheckpoint(ply:GetPos(),true)
			anydeaths = false
			end
			end
	end
end
end )

hook.Add( "DoPlayerDeath", "FirstDeathVector", function( victim )
	if(anydeaths == false) then
	firstdeath = victim:GetPos()
	anydeaths = true
	end
end )

function ActivateCheckpoint(checkpoint,sound)
	for k, v in pairs(player.GetAll()) do
		if(!v:Alive()) then 
			v:UnSpectate() 
			v:Spawn() 
			v:SetPos(checkpoint)
			v:SetHealth(50)
			if(sound) then 
				v:EmitSound( "ambient/energy/whiteflash.wav", 75, 100, 0.3, CHAN_AUTO ) 
			end 
		end
	end
end