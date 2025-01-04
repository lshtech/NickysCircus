SMODS.Joker{
    name = "Robot",
    key = "robot",
    config = {
        extra = { Xmult = 1.75 }
    },
    pos = {
        x = 0,
        y = 0
    },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    --atlas = 'jokers',
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.Xmult}}
    end,
    calculate = function(self, card, context)
      if context.cardarea == G.play and context.individual and not context.other_card.debuff and not context.end_of_round and
         context.other_card.ability.name == 'Steel Card' then
          return {
            message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.Xmult}},
            colour = G.C.XMULT,
            x_mult = card.ability.extra.Xmult
          }
      end
    end
}

--[[
SMODS.Joker{
    name = "Alien",
    key = "alien",
    config = { },
    pos = {
        x = 0,
        y = 0
    },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    --atlas = 'jokers',
    loc_vars = function(self, info_queue, card)
        return {vars = {}}
    end,
    calculate = function(self, card, context)
    end
}

local create_card_ref = create_card
function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    print(debug.traceback())
    if next(SMODS.find_card('j_nicky_alien')) and _type == 'Tarot' and not (key_append == 'sho' or key_append == 'ar1') then
        return create_card_ref("Planet", area, legendary, _rarity, skip_materialize, soulable, nil, 'alien')
    else
        return create_card_ref(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    end
end]]

SMODS.Joker{
    name = "Plain Joker",
    key = "plain_joker",
    config = {
        extra = {
            x_mult = 1,
            x_mult_mod = 0.5
        }
    },
    pos = {
        x = 0,
        y = 0
    },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    --atlas = 'jokers',
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.x_mult, card.ability.extra.x_mult_mod}}
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                message = localize {
                    type = 'variable',
                    key = 'a_xmult',
                    vars = {card.ability.extra.x_mult}
                },
                Xmult_mod = card.ability.extra.x_mult,
                colour = G.C.MULT
            }
        end
    end,
    update = function(self, card, dt)
        if G.STAGE ~= G.STAGES.RUN then
            return
        end
        local unenhanced = 0
        for i = #G.jokers.cards, 1, -1 do
            if G.jokers.cards[i].area and (G.jokers.cards[i].area == G.jokers) and not G.jokers.cards[i].edition and G.jokers.cards[i].config.center.key ~= 'j_nicky_plain_joker' then
                unenhanced = unenhanced + 1
            end
        end
        card.ability.extra.x_mult = 1 + math.max(0, unenhanced) * card.ability.extra.x_mult_mod
    end,
}

SMODS.Joker{
    name = "Rainbow Joker",
    key = "rainbow_joker",
    config = {
        extra = {
            x_mult = 1,
            x_mult_mod = 0.2
        }
    },
    pos = {
        x = 0,
        y = 0
    },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    --atlas = 'jokers',
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.x_mult, card.ability.extra.x_mult_mod}}
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if context.scoring_name == "Flush" or context.scoring_name == "Straight Flush" or context.scoring_name == "Royal Flush" or context.scoring_name == "Flush Five" or context.scoring_name == "Flush House" then
                if not context.blueprint then
                    card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_mod
                end
            end
            return {
                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                Xmult_mod = card.ability.extra.x_mult
            }
        end
    end
}