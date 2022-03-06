
local function NeuronsAttack()
for k,v in pairs (ents.GetAll()) do
if v then
if v:IsNPC() and v.NPCFlash == true then
v:ClearEnemyMemory()
v:StopMoving()
v:ClearSchedule()
if v.DontLoopNPC == false or v.DontLoopNPC == nil then
v.DontLoopNPC = true
timer.Simple(6, function()
v.NPCFlash = false
v.DontLoopNPC = false
end)
end
end
if v:IsPlayer() and v.PlayerFlash == true and (v.PlayerFlashDist == false or v.PlayerFlashDist == nil) then
if v.DontLoopPlayer == false or v.DontLoopPlayer == nil then
if v.GetAsTarget == nil or v.GetAsTarget == false then
v:ConCommand( "play weapons/cup_flash/inyourhead/mind_long" .. math.random(1,2) .. ".wav" )
end
v:ConCommand("pp_colormod 1")
timer.Simple(0.01, function() v:ConCommand("pp_colormod_contrast 0.9") end)
timer.Simple(0.015, function() v:ConCommand("pp_colormod_contrast 0.8") end)
timer.Simple(0.02, function() v:ConCommand("pp_colormod_contrast 0.7") end)
timer.Simple(0.025, function() v:ConCommand("pp_colormod_contrast 0.6") end)
timer.Simple(0.03, function() v:ConCommand("pp_colormod_contrast 0.5") end)
timer.Simple(0.035, function() v:ConCommand("pp_colormod_contrast 0.4") end)
timer.Simple(0.04, function() v:ConCommand("pp_colormod_contrast 0.3") end)
timer.Simple(0.045, function() v:ConCommand("pp_colormod_contrast 0.2") end)
timer.Simple(0.05, function() v:ConCommand("pp_colormod_contrast 0.1") end)
timer.Simple(0.055, function() v:ConCommand("pp_colormod_contrast 0.0") end)
timer.Simple(0.055, function() v:ConCommand("pp_colormod_color 0.0") end)
RandomOver = math.random(1,3)
if RandomOver == 1 then
timer.Simple(0.055, function() v:ConCommand("pp_mat_overlay effects/tp_eyefx/tpeye.vmt") end)
elseif RandomOver == 2 then
timer.Simple(0.055, function() v:ConCommand("pp_mat_overlay effects/tp_eyefx/tpeye2.vmt") end)
elseif RandomOver == 3 then
timer.Simple(0.055, function() v:ConCommand("pp_mat_overlay effects/tp_eyefx/tpeye3.vmt") end)
end
v.DontLoopPlayer = true
timer.Simple(6, function()
v.DontLoopPlayer = false
v.PlayerFlash = false
timer.Simple(0.01, function() v:ConCommand("pp_colormod_contrast 0.1") end)
timer.Simple(0.015, function() v:ConCommand("pp_colormod_contrast 0.2") end)
timer.Simple(0.02, function() v:ConCommand("pp_colormod_contrast 0.3") end)
timer.Simple(0.025, function() v:ConCommand("pp_colormod_contrast 0.4") end)
timer.Simple(0.03, function() v:ConCommand("pp_colormod_contrast 0.5") end)
timer.Simple(0.035, function() v:ConCommand("pp_colormod_contrast 0.6") end)
timer.Simple(0.04, function() v:ConCommand("pp_colormod_contrast 0.7") end)
timer.Simple(0.045, function() v:ConCommand("pp_colormod_contrast 0.8") end)
timer.Simple(0.05, function() v:ConCommand("pp_colormod_contrast 0.9") end)
timer.Simple(0.055, function() v:ConCommand("pp_colormod_contrast 1.0") end)
timer.Simple(0.055, function() v:ConCommand("pp_colormod_color 1.0") end)
timer.Simple(0.055, function() v:ConCommand("pp_colormod 0") end)
timer.Simple(0.055, function() v:ConCommand("pp_mat_overlay \"\"") end)
end)
end 
end 
if v:IsPlayer() and v.PlayerFlashDist == true and (v.PlayerFlash == false or v.PlayerFlash == nil) then
if v.DontLoopPlayer == false or v.DontLoopPlayer == nil then
if v.GetAsTarget == nil or v.GetAsTarget == false then
v:ConCommand( "play weapons/cup_flash/inyourhead/mind_short" .. math.random(1,2) .. ".wav" )
end
v:ConCommand("pp_colormod 1")
timer.Simple(0.01, function() v:ConCommand("pp_colormod_contrast 0.9") end)
timer.Simple(0.015, function() v:ConCommand("pp_colormod_contrast 0.8") end)
timer.Simple(0.02, function() v:ConCommand("pp_colormod_contrast 0.7") end)
timer.Simple(0.025, function() v:ConCommand("pp_colormod_contrast 0.6") end)
timer.Simple(0.03, function() v:ConCommand("pp_colormod_contrast 0.5") end)
timer.Simple(0.035, function() v:ConCommand("pp_colormod_contrast 0.4") end)
timer.Simple(0.04, function() v:ConCommand("pp_colormod_contrast 0.3") end)
timer.Simple(0.045, function() v:ConCommand("pp_colormod_contrast 0.2") end)
timer.Simple(0.05, function() v:ConCommand("pp_colormod_contrast 0.1") end)
timer.Simple(0.055, function() v:ConCommand("pp_colormod_contrast 0.0") end)
timer.Simple(0.055, function() v:ConCommand("pp_colormod_color 0.0") end)
RandomOver = math.random(1,3)
if RandomOver == 1 then
timer.Simple(0.055, function() v:ConCommand("pp_mat_overlay effects/tp_eyefx/tpeye.vmt") end)
elseif RandomOver == 2 then
timer.Simple(0.055, function() v:ConCommand("pp_mat_overlay effects/tp_eyefx/tpeye2.vmt") end)
elseif RandomOver == 3 then
timer.Simple(0.055, function() v:ConCommand("pp_mat_overlay effects/tp_eyefx/tpeye3.vmt") end)
end
v.DontLoopPlayer = true
timer.Simple(3, function()
v.DontLoopPlayer = false
v.PlayerFlashDist = false
timer.Simple(0.01, function() v:ConCommand("pp_colormod_contrast 0.1") end)
timer.Simple(0.015, function() v:ConCommand("pp_colormod_contrast 0.2") end)
timer.Simple(0.02, function() v:ConCommand("pp_colormod_contrast 0.3") end)
timer.Simple(0.025, function() v:ConCommand("pp_colormod_contrast 0.4") end)
timer.Simple(0.03, function() v:ConCommand("pp_colormod_contrast 0.5") end)
timer.Simple(0.035, function() v:ConCommand("pp_colormod_contrast 0.6") end)
timer.Simple(0.04, function() v:ConCommand("pp_colormod_contrast 0.7") end)
timer.Simple(0.045, function() v:ConCommand("pp_colormod_contrast 0.8") end)
timer.Simple(0.05, function() v:ConCommand("pp_colormod_contrast 0.9") end)
timer.Simple(0.055, function() v:ConCommand("pp_colormod_contrast 1.0") end)
timer.Simple(0.055, function() v:ConCommand("pp_colormod_color 1.0") end)
timer.Simple(0.055, function() v:ConCommand("pp_colormod 0") end)
timer.Simple(0.055, function() v:ConCommand("pp_mat_overlay \"\"") end)
end)
end
end
end
end
end
hook.Add("Think", "UNITNeurons", NeuronsAttack)