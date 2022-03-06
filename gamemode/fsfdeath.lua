hook.Add("PlayerDeathSound", "DeFlatline", function() return true end)
local noise = Sound("efu/vo/death1.wav", 1900, 100)
hook.Add("PlayerDeath", "NewSound", function(vic,unused1,unused2) vic:EmitSound(noise) end) --UNIT.FSFDeathScreaming