local function contains(table, element)
	for _, value in pairs(table) do
		if value == element then
			return true
		end
	end
	return false
end

UNLOCKED_CARDS = { 2, 3, 4 }

local get_deck_config_from_profile = function(key)
	if G.PROFILES[G.AP.profile_Id] then
		local saved_value = G.PROFILES[G.AP.profile_Id][key]
		if saved_value ~= nil then
			return saved_value
		end
	end
	return 0
end

local get_updated_deck_config = function()
	return {
		dollars = -4 + get_deck_config_from_profile("apdeck_bonusmoney"),
		discards = -2 + get_deck_config_from_profile("apdeck_bonushands"),
		hands = -3 + get_deck_config_from_profile("apdeck_bonusdiscards"),
		joker_slot = -5 + get_deck_config_from_profile("apdeck_bonusjoker"),
		no_interest = true,
	}
end

print(G.P_CENTERS["b_red"] ~= nil)

local apback = SMODS.Back({
	name = "Archipelago Deck",
	key = "archipelago",
	atlas = "cardback",
	pos = { x = 0, y = 0 },
	config = get_updated_deck_config(),
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
