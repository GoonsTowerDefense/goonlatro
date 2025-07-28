SMODS.Consumable{
    key = 'abigbag', -- key
    set = 'Spectral', -- the set of the card: corresponds to a consumable type
    atlas = 'gtd', -- atlas
    pos = {x = 4, y = 1}, -- position in atlas
    loc_txt = {
        name = 'A Big Bag', -- name of card
        text = { -- text of card
            'Contains one {C:spectral}cookie{}.',
            '{C:inactive,s:0.8}Idea by Mars1941{}',
            '{C:inactive,s:0.8}Made by iam4pple{}'
        }
    },
    config = {},

    unlocked = true,

    discovered = true,

    can_use = function(self)
        return #G.hand.cards > 0 and #G.deck.cards > 0
    end,

    use = function(self, card, area)
            local cookie = create_card("Spectral", G.consumeables, nil, nil, nil, nil, "c_gl_cookie", "c_gl_cookie")
            if cookie then
            cookie:add_to_deck()
            G.consumeables:emplace(cookie)
            end

            local justthebag = create_card("Spectral", G.consumeables, nil, nil, nil, nil, "c_gl_justthebag", "c_gl_justthebag")
            if justthebag then
                justthebag:add_to_deck()
                G.consumeables:emplace(justthebag)
                play_sound("gl_bigbag")
            end
        end,
}

SMODS.Consumable{
    key = 'cookie', -- key
    set = 'Spectral', -- the set of the card: corresponds to a consumable type
    atlas = 'gtd', -- atlas
    pos = {x = 5, y = 1}, -- position in atlas
    loc_txt = {
        name = 'Cookie', -- name of card
        text = { -- text of card
            'Give back all {C:white,X:red}discards{} used.',
            '{C:inactive,s:0.8}Idea by Mars1941{}',
            '{C:inactive,s:0.8}Made by iam4pple{}'
        }
    },
    config = {},

    unlocked = true,

    discovered = true,

    no_collection = true,

    can_use = function(self)
        return #G.hand.cards > 0 and #G.deck.cards > 0 and G.GAME.current_round.discards_used > 0
    end,

    use = function(self, card, area)
            G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                -- Add discards
                local discards_to_add = G.GAME.current_round.discards_used
                ease_discard(discards_to_add)
                play_sound("gl_cookie")
                G.GAME.current_round.discards_used = 0
                return true
            end
        }))
    end
}

SMODS.Consumable{
    key = 'justthebag',
    set = 'Spectral',
    atlas = 'gtd',
    pos = {x = 3, y = 1},
    loc_txt = {
        name = 'Just the Bag',
        text = {
            'Give back all {C:white,X:blue}hands{} used.',
            '{C:inactive,s:0.8}Idea by iam4pple{}',
            '{C:inactive,s:0.8}Made by iam4pple{}'
        }
    },
    config = {},

    unlocked = true,
    
    discovered = true,

    no_collection = true,

    can_use = function(self)
        return #G.hand.cards > 0 and #G.deck.cards > 0 and G.GAME.current_round.hands_played > 0
    end,

    use = function(self, card, area)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                -- Add hands
                local hands_to_add = G.GAME.current_round.hands_played
                ease_hands_played(hands_to_add)
                play_sound("gl_bigbag")
                G.GAME.current_round.hands_played = 0
                return true
            end
        }))
    end

}