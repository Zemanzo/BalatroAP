local available_hands = {
	["Flush Five"] = false,
	["Flush House"] = false,
	["Five of a Kind"] = false,
	["Straight Flush"] = false,
	["Four of a Kind"] = false,
	["Full House"] = false,
	["Flush"] = false,
	["Straight"] = false,
	["Three of a Kind"] = false,
	["Two Pair"] = false,
	["Pair"] = true,
	["High Card"] = true,
}

G.FUNCS.evaluate_play_precalculate = function(cards, poker_hands, text)
	if not available_hands[text] then
		mult = mod_mult(0)
		hand_chips = mod_chips(0)
		play_area_status_text("Not Allowed!")
		return true
	end
	return false
end
