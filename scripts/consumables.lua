SMODS.ConsumableType{
    key = 'GTDConsumableType', --consumable type key

    collection_rows = {5,5}, --amount of cards in one page
    primary_colour = G.C.RED, --first color
    secondary_colour = G.C.PURPLE, --second color
    loc_txt = {
        collection = 'GTD Cards', --name displayed in collection
        name = 'GTD Cards', --name displayed in badge
        undiscovered = {
            name = 'Hidden Ref', --undiscovered name
            text = {'you dont get the', 'ref'} --undiscovered text
        }
    },
    shop_rate = 0, --rate in shop out of 100
}

SMODS.Booster{
    key = 'GTDBooster',
    atlas = 'gtd',
    pos = {x = 0, y = 0},
    config = {
        extra = 2,
        choose = 1,
    },
    loc_txt = {
        name = 'GTD Booster',
        text = {
            'Contains GTD Cards'
        },
        group_name = "Goons Tower Defense"
    },
    group_key = 'gl_GTDBooster',

    select_card = 'consumeables',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.config.center.config.choose, card.ability.extra } }
    end,

    create_card = function(self, card)
        local i = 0
        repeat
            i = i + 1  -- Increment to prevent infinite loop
            card = create_card("GTDConsumableType", G.pack_cards, nil, nil, true, true, nil, "gl_GTDConsumableType")  -- Long card creation logic
        until i > 100 or card:remove() -- If the card is disabled, regenerate it or clean up after 100 attempts
        return card-- Return the valid card
        end,

    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.PURPLE)
        ease_background_colour({new_colour = G.C.PURPLE, special_colour = G.C.RED, contrast = 2})
    end
}

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

    in_pool = function(self, args)
        return true, { allow_duplicates = true }
    end,

    can_use = function(self, context)
        return context.cardarea == G.consumables and #G.hand.cards > 0 and #G.deck.cards > 0
    end,

    use = function(self, card, area)
            local cookie = create_card("GTDConsumableType", G.consumeables, nil, nil, nil, nil, "c_gl_cookie", "c_gl_cookie")
            if cookie then
                cookie:add_to_deck()
                G.consumeables:emplace(cookie)
            end

            local justthebag = create_card("GTDConsumableType", G.consumeables, nil, nil, nil, nil, "c_gl_justthebag", "c_gl_justthebag")
            if justthebag then
                justthebag:add_to_deck()
                G.consumeables:emplace(justthebag)
                play_sound("gl_bigbag")
            end
        end
}

SMODS.Consumable{
    key = 'cookie', -- key
    set = 'GTDConsumableType', -- the set of the card: corresponds to a consumable type
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

    in_pool = function(self, args)
        return true, { allow_duplicates = true }
    end,

    can_use = function(self, context)
        return context.cardarea == G.consumables and #G.hand.cards > 0 and #G.deck.cards > 0 and G.GAME.current_round.discards_used > 0
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
    set = 'GTDConsumableType',
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

    in_pool = function(self, args)
        return true, { allow_duplicates = true }
    end,

    can_use = function(self, context)
        return context.cardarea == G.consumables and #G.hand.cards > 0 and #G.deck.cards > 0 and G.GAME.current_round.hands_played > 0
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

SMODS.Consumable{
    key = 'bart', -- key
    set = 'GTDConsumableType', -- the set of the card: corresponds to a consumable type
    atlas = 'gtd', -- atlas
    pos = {x = 3, y = 0}, -- position in atlas
    loc_txt = {
        name = 'Bart', -- name of card
        text = { -- text of card
            '{C:money}Eat my shorts.{}',
            '{C:inactive,s:0.8}Idea by Mars1941{}',
            '{C:inactive,s:0.8}Made by iam4pple{}'
        }
    },
    config = {},

    unlocked = true,

    discovered = true,

    in_pool = function(self, args)
        return true, { allow_duplicates = true }
    end,

    can_use = function(self)
        return true
    end,

    use = function(self, card, area)
            ease_dollars(15)
        end,
}