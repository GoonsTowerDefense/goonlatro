-- Script Loading Start

        -- load jokers
assert(SMODS.load_file('scripts/jokers.lua'))()

-- Script Loading End

--Sound Junk Start

SMODS.Sound { -- used to import the sound effect
key = 'gavinybytes',
path = 'gavinybytes.wav',
volume = 1.3,
pitch = 1.0,
}

SMODS.Sound { -- used to import the sound effect
key = 'crazyeights',
path = 'crazyeights',
volume = 1.3,
pitch = 1.0,
}

SMODS.Sound:register_global() -- used to import the sound effect

-- Sound Junk End

--Atlas Junk start

SMODS.Atlas { -- atlas for the joker textures.
       
    key = "gtd",  -- key it uses to call the correct sheet later on.
      
    path = "JokerSheet.png",  -- name of the file the joker textures are located in.

    -- size of the individual textures in the file. (71x95 is default)
    px = 71,
    py = 95
}

SMODS.Atlas { -- icon for the modpack as shown in the mods menu.
    key = "modicon", -- this text needs to be modicon afaik.
   path = "modicon.png", -- file name should also be modicon.png.
   px = 32, -- icon should be 32x32
   py = 32
}

SMODS.Atlas{
    key = "shop_sign",
    path = "gtd.png",
    px=113,
    py=57,
    atlas_table = 'ANIMATION_ATLAS',
    raw_key = true,
	frames = 4,
    prefix_config = {key = false}
}