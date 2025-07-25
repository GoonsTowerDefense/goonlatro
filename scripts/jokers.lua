SMODS.Joker { -- Crazy Eights --
       key = 'crazy eights',

           -- description of the joker.
        loc_txt = {
            name = 'Crazy Eights',
            text = {
                "{C:mult}+#1#{} Mult, gains",
                "{C:mult}+#2#{} Mult when scored.",
            }
        },

           -- config of the joker. Variables go here.
        config = {
           extra = {
                mult = 0,
                gain = 1
         }
     },
            -- rarity level, 0 = common, 1 = uncommon, 2 = rare, 3 = legendary.
        rarity = 1,

            -- atlas the joker uses for texture(s).
        atlas = 'gtd',
    
            -- where on the atlas texture the joker is locarted.
        pos = {
            x = 0,
            y = 0
        },
            -- cost of the joker in the shop.
        cost = 8,

            -- whether it is unlocked by default.
        unlocked = true,

            -- whether it is discovered by default.
        discovered = true,

            -- whether blueprint can copy this joker.
        blueprint_compat = true,

            -- whether this joker can have the perishable sticker.
        perishable_compat = true,

            -- whether this joker can have the eternal sticker.
        eternal_compat = true,

            -- whether duplicates of this joker can appear in the shop by default.
        allow_duplicates = true,

            -- loc_vars works with the config and gives you text variables to work with.
            -- these are formatted as #n#, where n is the position in the variable table.
        loc_vars = function(self, info_queue, card)
            return {
                vars = {
                        -- #1#
                    card.ability.extra.mult,
                        -- #2#
                    card.ability.extra.gain,
                    }
                }
        end,

            -- calculate is where the scoring and effects of the joker are handled. 
        calculate = function(self, card, context)
                -- context.joker_main takes place when the joker is meant to score.
            if context.joker_main then
                return {
                        -- adds the number contained in the mult variable to the score.
                mult_mod = card.ability.extra.mult,
                        -- message is the text that appears when the joker scores.
                        -- localize is used to make sure the text works across multiple languages.
                    message  = localize {
                        type = 'variable',
                        key = 'a_mult',
                        vars = {
                            card.ability.extra.mult
                        }
                    }
                }
            end
                -- context.after takes place after the hand is scored.
                -- context.blueprint applies if the joker is a blueprint copy.
            if context.after and not context.blueprint then
                            -- adds the gain variable to the base mult number.
                        card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.gain
                    return {
                            -- another message, just prints the text.
                        message = "Crazy Eights!",
                        colour = G.C.MULT,
                            -- plays the sound effect yippie.ogg. the prefix is needed.
                        play_sound("gl_crazyeights"),
                            -- needed, can be changed to context.other_card to apply to another card.
                        card = card
                    }
            end
        end
    }