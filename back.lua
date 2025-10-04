local function contains(table, element)
	for _, value in pairs(table) do
		if value == element then
			return true
		end
	end
	return false
end

UNLOCKED_CARDS = { 1, 2, 3, 4 }

SMODS.Back({
	name = "Archipelago Deck",
	key = "apdeck",
	atlas = "cardback",
	pos = { x = 0, y = 0 },
	config = { dollars = -4, discards = -2, hands = 3, joker_slot = -4, no_interest = true },
	loc_txt = {
		name = "Archipelago Deck",
		text = {
			"A deck optimized for",
			"{C:attention}Archipelago{}",
		},
	},
	apply = function(self)
		G.E_MANAGER:add_event(Event({
			func = function()
				for i = #G.playing_cards, 1, -1 do
					if not contains(UNLOCKED_CARDS, G.playing_cards[i]:get_id()) then
						SMODS.debuff_card(G.playing_cards[i], true, "archipelago")
					end
				end

				return true
			end,
		}))
	end,
})

-- local select_blindRef = G.FUNCS.select_blind

-- G.FUNCS.select_blind = function(e)
--   for i = #G.playing_cards, 1, -1 do
--     if not contains({ 1, 2, 3, 4 }, G.playing_cards[i]:get_id()) then
--       SMODS.debuff_card(G.playing_cards[i], true, 'archipelago')
--     end
--   end

--   return select_blindRef(e)
-- end
