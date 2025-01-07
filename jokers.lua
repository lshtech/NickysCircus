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

SMODS.Joker{
    name = "Cross Joker",
    key = "cross_joker",
    config = {
        extra = {
            mult = 5
        }
    },
    pos = {
        x = 0,
        y = 0
    },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    --atlas = 'jokers',
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.mult}}
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            for _, other_card in pairs(context.scoring_hand) do
                if other_card.debuff then
                    return {
                         message = localize{
                             type = "variable",
                             key = "a_mult",
                             vars = {
                                 card.ability.extra.mult
                             }
                         },
                         mult_mod = card.ability.extra.mult,
                         colour = G.C.MULT,
                         card = card
                     }
                end
            end
        end
    end
}

SMODS.Joker{
    name = "Spirit",
    key = "spirit",
    config = { },
    pos = {
        x = 0,
        y = 0
    },
    cost = 7,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    --atlas = 'jokers',
    loc_vars = function(self, info_queue, card)
        return {vars = {}}
    end,
    calculate = function(self, card, context)
		if context.selling_self and not (context.blueprint or context.retrigger_joker_check or context.retrigger_joker) then
			for _ = 1, 3 do
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    local spectral = create_card("Spectral", G.consumeables, nil, nil, nil, nil, nil, "spirit")
                    spectral:add_to_deck()
                    G.consumeables:emplace(spectral)
                end
			end
		end
    end
}

SMODS.Joker{
    name = "Golden Scissors",
    key = "golden_scissors",
    config = { extra = { chips = 0 } },
    pos = {
        x = 0,
        y = 0
    },
    cost = 7,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    --atlas = 'jokers',
    loc_vars = function(self, info_queue, card)
        return {vars = { card.ability.extra.chips }}
    end,
    calculate = function(self, card, context)
        local my_pos = nil
		for i = 1, #G.jokers.cards do
			if G.jokers.cards[i] == card then
				my_pos = i
				break
			end
		end
		if	context.setting_blind
			and not (context.blueprint_card or self).getting_sliced
			and my_pos
			and G.jokers.cards[my_pos + 1]
			and not G.jokers.cards[my_pos + 1].ability.eternal
			and not G.jokers.cards[my_pos + 1].getting_sliced
		then
			local sliced_card = G.jokers.cards[my_pos + 1]
            local chips = sliced_card.sell_cost * 10
			sliced_card.getting_sliced = true
			G.GAME.joker_buffer = G.GAME.joker_buffer - 1
            card.ability.extra.chips = card.ability.extra.chips + chips
			G.E_MANAGER:add_event(Event({
				func = function()
					G.GAME.joker_buffer = 0
					card:juice_up(0.8, 0.8)
					sliced_card:start_dissolve({ HEX("57ecab") }, nil, 1.6)
					play_sound("slice1", 0.96 + math.random() * 0.08)
					return true
				end,
			}))
		end
        if context.joker_main and card.ability.extra.chips > 0 then
            return {
                message = localize{
                    type = "variable",
                    key = "a_chips",
                    vars = {
                        card.ability.extra.chips
                    }
                },
                chip_mod = card.ability.extra.chips
            }
        end
    end
}