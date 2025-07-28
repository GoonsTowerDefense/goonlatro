    SMODS.Joker { -- Crazy Eights --
       key = 'crazyeights',

           -- description of the joker.
        loc_txt = {
            name = 'Crazy Eights',
            text = {
                "{C:mult}X#2#{} Mult, gains",
                "{C:mult}X#1#{} Mult at end of round.",
                "{C:inactive,s:0.8}Idea by Mars1941{}",
                "{C:inactive,s:0.8}Made by iam4pple{}"
            }
        },

           -- config of the joker. Variables go here.
        config = {
           extra = {
                gain = 8,
                Xmult = 8
         }
     },
            -- rarity level, 0 = common, 1 = uncommon, 2 = rare, 3 = legendary.
        rarity = 4,

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
                    card.ability.extra.gain,
                        -- #2#
                    card.ability.extra.Xmult
                    }
                }
        end,

            -- calculate is where the scoring and effects of the joker are handled. 
        calculate = function(self, card, context)
                -- context.joker_main takes place when the joker is meant to score.
            if context.joker_main then
                return {
                          -- another message, just prints the text.
                    message = "Crazy!",
                    colour = G.C.MULT,
                            -- needed, can be changed to context.other_card to apply to another card.
                    card = card,
                Xmult_mod = card.ability.extra.Xmult
                }
            end

            if context.post_trigger and context.cardarea == G.jokers then
                return {
                    play_sound("gl_crazyeights")
                }
            end
                -- context.after takes place after the hand is scored.
                -- context.blueprint applies if the joker is a blueprint copy.
            if context.end_of_round and context.cardarea == G.jokers then
                        card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.gain
                    return {
                            -- another message, just prints the text.
                        message = "Crazy!",
                        colour = G.C.MULT,
                            -- plays the sound effect yippie.ogg. the prefix is needed.
                        play_sound("gl_crazyeights"),
                            -- needed, can be changed to context.other_card to apply to another card.
                        card = card
                    }
            end
        end
    }

    SMODS.Joker { -- Playstyle --
       key = 'playstyle',

           -- description of the joker.
        loc_txt = {
            name = 'Playstyle',
            text = {
                "All {X:blue,C:white}face-down{} cards",
                "will be drawn {X:red,C:white}face-up{}.",
                "{C:inactive,s:0.8}Idea by Mars1941{}",
                "{C:inactive,s:0.8}Made by iam4pple{}"
            }
        },

           -- config of the joker. Variables go here.
        config = {},
            -- rarity level, 0 = common, 1 = uncommon, 2 = rare, 3 = legendary.
        rarity = 2,

            -- atlas the joker uses for texture(s).
        atlas = 'gtd',
    
            -- where on the atlas texture the joker is locarted.
        pos = {
            x = 1,
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

            -- calculate is where the scoring and effects of the joker are handled. 
        calculate = function(self, card, context)
            if context.hand_drawn then
                for index, card in ipairs(G.hand.cards) do
                    if G.hand.cards[index].facing == 'back' then
                    -- Flip the card's facing and sprite_facing to 'back'
                    G.hand.cards[index]:flip()
                    end
                end
            end
    end
    }

    SMODS.Joker { -- Bart --
       key = 'clickthebart',

           -- description of the joker.
        loc_txt = {
            name = 'Click the Bart',
            text = {
                "All {X:blue,C:white}face-down{} cards",
                "will be drawn {X:red,C:white}face-up{}.",
                "{C:inactive,s:0.8}Idea by Mars1941{}",
                "{C:inactive,s:0.8}Made by iam4pple{}"
            }
        },

           -- config of the joker. Variables go here.
        config = {},
            -- rarity level, 0 = common, 1 = uncommon, 2 = rare, 3 = legendary.
        rarity = 2,

            -- atlas the joker uses for texture(s).
        atlas = 'gtd',
    
            -- where on the atlas texture the joker is locarted.
        pos = {
            x = 3,
            y = 0
        },
            -- cost of the joker in the shop.
        cost = 8,

            -- whether it is unlocked by default.
        unlocked = false,

            -- whether it is discovered by default.
        discovered = false,

            -- whether blueprint can copy this joker.
        blueprint_compat = true,

            -- whether this joker can have the perishable sticker.
        perishable_compat = true,

            -- whether this joker can have the eternal sticker.
        eternal_compat = true,

            -- whether duplicates of this joker can appear in the shop by default.
        allow_duplicates = true,
    }