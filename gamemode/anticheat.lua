customspawn = false
stopspawning = false;

function StartUp()
	stopspawning = false;
	for k, v in pairs(player.GetAll()) do
	v:Freeze(true)
	end
end

function MissionStart()
	stopspawning = true;
	timer.Simple(1, function()
	for k, v in pairs(player.GetAll()) do 
		v:ConCommand("play efu/cmp_b_combinemovingprimary_beta.wav") 
		v:Freeze(false)
		v:PrintMessage( HUD_PRINTCENTER, "[FSF Commander]: Get inside the facility." )
		--v:StartLoopingSound( "efu/motion_lp_fsf.wav" )
		--v:ChatPrint("MotionTracker звук включён, для остановки звука впешите stopsound.")
	end
	end )
end

local function CreateCheapTick()
	nearspawn = true
	
	timer.Simple(2, function()
	RunConsoleCommand("mp_falldamage","1")
	RunConsoleCommand("sbox_godmode","0")
	RunConsoleCommand("sbox_noclip","0")
	RunConsoleCommand("sv_allow_color_correction","1")
	RunConsoleCommand("ai_ignoreplayers","0")
	RunConsoleCommand("ai_disabled","0")
	--v:StartLoopingSound( "fsf/motion_lp.wav" )
	
	timer.Create( "cheapfragtick", 1, 0, function() 
		for k, v in pairs(player.GetAll()) do
			if(v:HasWeapon("weapon_rpg") && v:GetAmmoCount(10) == 0) then
				v:StripWeapon( "weapon_rpg" )
			end
		end
	end )


	timer.Create( "cheaptick", 1, 0, function() 
		if((GetConVarNumber( "gc_realismmode" ) == 1) || forcerealismenable) then
			if(stopspawning == false) then
				if(#player.GetAll() > 0) then
					if(!customspawn) then
						for k, v in pairs(player.GetAll()) do
							for m, l in pairs(ents.FindByClass("info_player_start")) do
								if(v:GetPos():Distance(l:GetPos()) > 256) then
									nearspawn = false
								else
									nearspawn = true
									break
								end
							end
							if(!nearspawn && !stopspawning) then
								MissionStart()
								break
							end
						end
					end	
				end
			end
		end
	end )
	
	end )
end
hook.Add( "Initialize", "Cheap Tick", CreateCheapTick )

local function DisableNoclip( ply )
	return false;
end
hook.Add( "PlayerNoClip", "DisableNoclipFunction", DisableNoclipFunction )

--[[local function PlayerDeath( ply )
ply:PlayerDeathSound( "efu/vo/death1.wav" )

end]]

local function spawn( ply )
	if(((GetConVarNumber( "gc_realismmode" ) == 1) || forcerealismenable) && stopspawning) then
		timer.Simple(0.1,function() 
			if(ply:IsValid()) then 
				ply:Kill() 
				ply:SetObserverMode(OBS_MODE_ROAMING) 
				ply:SetMoveType(MOVETYPE_OBSERVER)
				ply:SpectateEntity(table.Random(player.GetAll()))
			end 
		end )
		
	end
end
hook.Add( "PlayerInitialSpawn", "InitialSpawnCheck", spawn )

