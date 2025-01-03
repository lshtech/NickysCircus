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