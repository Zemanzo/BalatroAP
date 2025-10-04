-- Add this on deck select.
-- G.GAME.win_ante = 16

local scaling_factor = 2
local get_blind_amountRef = get_blind_amount
function get_blind_amount(ante)
	if G.GAME.selected_back and G.GAME.selected_back.name == "Archipelago Deck" then
		local amounts = {
			-- Ante 1 - 4
			20,
			50,
			100,
			300,
			-- Ante 5 - 8
			1000,
			5000,
			11000,
			20000,
			-- Ante 9 - 12
			35000,
			50000,
			80000,
			130000,
			-- Ante 13 - 16
			250000,
			1000000,
			50000000,
			100000000,
		}
		if ante < 1 then
			return 100
		end
		if ante <= 8 then
			return amounts[ante]
		end
		local amount = math.floor(amounts[G.GAME.win_ante] * scaling_factor ^ (ante - G.GAME.win_ante))
		amount = amount - amount % (10 ^ math.floor(math.log10(amount) - 1))
		return amount
	-- elseif G.GAME.modifiers.scaling == 2 then
	--   local amounts = {
	--     300,  900, 2600,  8000,  20000,  36000,  60000,  100000
	--     --300,  900, 2400,  7000,  18000,  32000,  56000,  90000
	--   }
	--   if ante < 1 then return 100 end
	--   if ante <= 8 then return amounts[ante] end
	--   local amount = math.floor(amounts[8]*scaling_factor^(ante-8))
	--   amount = amount - amount%(10^math.floor(math.log10(amount)-1))
	--   return amount
	-- elseif G.GAME.modifiers.scaling == 3 then
	--   local amounts = {
	--     300,  1000, 3200,  9000,  25000,  60000,  110000,  200000
	--     --300,  1000, 3000,  8000,  22000,  50000,  90000,  180000
	--   }
	--   if ante < 1 then return 100 end
	--   if ante <= 8 then return amounts[ante] end
	--   local amount = math.floor(amounts[8]*scaling_factor^(ante-8))
	--   amount = amount - amount%(10^math.floor(math.log10(amount)-1))
	--   return amount
	-- end
	else
		return get_blind_amountRef(ante)
	end
end
