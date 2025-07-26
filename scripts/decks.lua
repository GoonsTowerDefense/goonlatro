SMODS.Back{
    name = "tmplaystyle",      -- name of the deck (in code)
    key = "tmplaystyle",       -- key used to call the deck 
    pos = {x = 0, y = 4},   -- unsure what this does currently, come back to this !!
    atlas = 'gtd',        -- atlas referenced for deck texture
    atlas_key = 'tmplaystyle', -- also unsure what this does, come back to this !!
    pos = {             -- position of the texture on the atlas
        x = 1,
        y = 0,
        },

    config = {              -- config for the deck, can include hands, discards, consumables, vouchers, money, etc.
        hands = 0,
        discards = 0,
        jokers = {'j_gl_playstyle', 'j_gl_crazyeights'},
        consumables = {'c_gl_abigbag', 'c_gl_cookie'}
    },

    loc_txt = {
        name = "Take my Playstyle", -- name the deck appears as in game
        text = {            -- description text for the deck
            "Start with the {C:spectral}GTD{} cards"
        }
    },
    loc_vars = function(self)   --variable setup
        return { vars = { 
            self.config.discards,   -- #1#
            self.config.hands,      -- #2#
            self.config.jokers, -- #3#
            self.config.consumables -- #4#
        }}
    end
}
