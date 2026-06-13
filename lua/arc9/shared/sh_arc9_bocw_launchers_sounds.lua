--=============================================================================
--   ARC9 CALL OF DUTY: BLACK OPS COLD WAR
--   LAUNCHERS
--   SOUNDS MASTER FILE
--[[
  .oooooo.    o8o                                              .oooo.   
 d8P'  `Y8b   `"'                                            .dP""Y88b  
888          oooo   .oooooooo ooo. .oo.  .oo.    .oooo.            ]8P' 
888          `888  888' `88b  `888P"Y88bP"Y88b  `P  )88b         .d8P'  
888           888  888   888   888   888   888   .oP"888       .dP'     
`88b    ooo   888  `88bod8P'   888   888   888  d8(  888     .oP     .o 
 `Y8bood8P'  o888o `8oooooo.  o888o o888o o888o `Y888""8o    8888888888 
                   d"     YD                                            
                   "Y88888P'                                            
]]
-- READY FOLEY

sound.Add({
    name = "ARC9_BOCW.Cigma2_ready_part1",
    channel = CHAN_AUTO,
    volume = 1.0,
    sound = "weapons/arc9/bocw_cigma2/cigma2_ready_part1.wav"
})
sound.Add({
    name = "ARC9_BOCW.Cigma2_ready_part2",
    channel = CHAN_AUTO,
    volume = 1.0,
    sound = "weapons/arc9/bocw_cigma2/cigma2_ready_part2.wav"
})
sound.Add({
    name = "ARC9_BOCW.Cigma2_ready_part3",
    channel = CHAN_AUTO,
    volume = 1.0,
    sound = "weapons/arc9/bocw_cigma2/cigma2_ready_part3.wav"
})

-- RELOAD

sound.Add({
    name = "ARC9_BOCW.Cigma2_reload_part1",
    channel = CHAN_AUTO,
    volume = 1.0,
    sound = "weapons/arc9/bocw_cigma2/cigma2_reload_part1.wav"
})
sound.Add({
    name = "ARC9_BOCW.Cigma2_reload_part2",
    channel = CHAN_AUTO,
    volume = 1.0,
    sound = "weapons/arc9/bocw_cigma2/cigma2_reload_part2.wav"
})

sound.Add({
    name = "ARC9_BOCW.Cigma2_reload_end",
    channel = CHAN_AUTO,
    volume = 0.5,
    sound = "weapons/arc9/bocw_cigma2/cigma2_reload_end.wav"
})

-- INSPECT FOLEY

sound.Add({
    name = "ARC9_BOCW.Cigma2_inspect",
    channel = CHAN_ITEM,
    volume = 1.0,
    sound = "weapons/arc9/bocw_cigma2/cigma2_inspect.wav"
})

-- PULLOUT PUTAWAY

sound.Add({
    name = "ARC9_BOCW.Cigma2_draw",
    channel = CHAN_AUTO,
    volume = 1.0,
    sound = "weapons/arc9/bocw_cigma2/cigma2_draw.wav"
})

sound.Add({
    name = "ARC9_BOCW.Cigma2_holster",
    channel = CHAN_AUTO,
    volume = 1.0,
    sound = "weapons/arc9/bocw_cigma2/cigma2_holster.wav"
})

-----------------------------------------------
-- FIRING SOUNDS
sound.Add({ -- BLACK OPS COLD WAR
    name = "ARC9_BOCW.Cigma2_fire",
    channel = CHAN_AUTO,
    volume = 1.0,
    sound = {"weapons/arc9/bocw_cigma2/cigma2_fire1.wav","weapons/arc9/bocw_cigma2/cigma2_fire2.wav","weapons/arc9/bocw_cigma2/cigma2_fire3.wav"}
})

--[[
ooooooooo.   ooooooooo.     .oooooo.             ooooooooo 
`888   `Y88. `888   `Y88.  d8P'  `Y8b           d"""""""8' 
 888   .d88'  888   .d88' 888                         .8'  
 888ooo88P'   888ooo88P'  888                        .8'   
 888`88b.     888         888     ooooo 8888888     .8'    
 888  `88b.   888         `88.    .88'             .8'     
o888o  o888o o888o         `Y8bood8P'             .8'      
]]
-- READY FOLEY

sound.Add({
    name = "ARC9_BOCW.RPG7_ready",
    channel = CHAN_AUTO,
    volume = 1.0,
    sound = "weapons/arc9/bocw_rpg7/rpg7_ready.wav"
})

-- RELOAD

sound.Add({
    name = "ARC9_BOCW.RPG7_reload_load",
    channel = CHAN_AUTO,
    volume = 1.0,
    sound = {"weapons/arc9/bocw_rpg7/rpg7_reload_load1.wav","weapons/arc9/bocw_rpg7/rpg7_reload_load2.wav"}
})

sound.Add({
    name = "ARC9_BOCW.RPG7_reload_twist",
    channel = CHAN_AUTO,
    volume = 1.0,
    sound = {"weapons/arc9/bocw_rpg7/rpg7_reload_twist1.wav","weapons/arc9/bocw_rpg7/rpg7_reload_twist2.wav","weapons/arc9/bocw_rpg7/rpg7_reload_twist3.wav"}
})

sound.Add({
    name = "ARC9_BOCW.RPG7_reload_end",
    channel = CHAN_AUTO,
    volume = 1.0,
    sound = {"weapons/arc9/bocw_rpg7/rpg7_reload_end1.wav","weapons/arc9/bocw_rpg7/rpg7_reload_end2.wav"}
})

-- INSPECT FOLEY

sound.Add({
    name = "ARC9_BOCW.RPG7_inspect",
    channel = CHAN_ITEM,
    volume = 1.0,
    sound = "weapons/arc9/bocw_rpg7/rpg7_inspect.wav"
})

-- PULLOUT PUTAWAY

sound.Add({
    name = "ARC9_BOCW.RPG7_draw",
    channel = CHAN_AUTO,
    volume = 1.0,
    sound = "weapons/arc9/bocw_rpg7/rpg7_draw.wav"
})

sound.Add({
    name = "ARC9_BOCW.RPG7_holster",
    channel = CHAN_AUTO,
    volume = 1.0,
    sound = "weapons/arc9/bocw_rpg7/rpg7_holster.wav"
})
-----------------------------------------------
-- FIRING SOUNDS
sound.Add({ -- BLACK OPS COLD WAR
    name = "ARC9_BOCW.RPG7_fire",
    channel = CHAN_AUTO,
    volume = 1.0,
    sound = {"weapons/arc9/bocw_rpg7/rpg7_fire1.wav","weapons/arc9/bocw_rpg7/rpg7_fire2.wav","weapons/arc9/bocw_rpg7/rpg7_fire3.wav","weapons/arc9/bocw_rpg7/rpg7_fire4.wav"}
})