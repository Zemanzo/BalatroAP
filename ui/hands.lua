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

local DARK_RED = HEX("721d0e")

local create_UIBox_current_hand_rowRef = create_UIBox_current_hand_row
function create_UIBox_current_hand_row(handname, simple)
	local uiBox_current_hand_row = create_UIBox_current_hand_rowRef(handname, simple)

	if uiBox_current_hand_row ~= nil and not available_hands[handname] then
		if not simple then
			uiBox_current_hand_row.config.colour = G.C.BLACK
			local handNode = uiBox_current_hand_row.nodes[1].nodes
			if handNode then
				local levelNumberNode = handNode[1]
				levelNumberNode.config.outline_colour = DARK_RED
				levelNumberNode.config.colour = DARK_RED
				local levelText = levelNumberNode.nodes[1]
				levelText.config.text = "DISABLED"
				levelText.config.colour = G.C.RED
				levelText.config.scale = 0.35

				local nameNode = handNode[2].nodes[1]
				nameNode.config.colour = G.C.UI.TEXT_DARK
			end
		end
	end

	return uiBox_current_hand_row
end
