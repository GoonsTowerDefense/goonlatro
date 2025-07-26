SMODS.Consumable{
    key = 'abigbag', -- key
    set = 'Spectral', -- the set of the card: corresponds to a consumable type
    atlas = 'gtd', -- atlas
    pos = {x = 4, y = 1}, -- position in atlas
    loc_txt = {
        name = 'A Big Bag', -- name of card
        text = { -- text of card
            'Contains one {C:spectral}cookie{}',
        }
    },
    config = {},

    can_use = function(self)
        return #G.hand.cards > 0 and #G.deck.cards > 0
    end,

    use = function(self, card, area)
            local consumable = create_card("Spectral", G.consumeables, nil, nil, nil, nil, "c_gl_cookie", "c_gl_cookie")
            if consumable then
            consumable:add_to_deck()
            G.consumeables:emplace(consumable)
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
        }
    },
    config = {},

    can_use = function(self)
        return #G.hand.cards > 0 and #G.deck.cards > 0
    end,

    use = function(self, card, area)
            G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                -- Add discards
                local discards_to_add = G.GAME.current_round.discards_used
                ease_discard(discards_to_add)

                return true
            end
        }))
    end
}