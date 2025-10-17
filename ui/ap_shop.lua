function G.FUNCS.ap_shop(e)
	G.SETTINGS.paused = true
	G.FUNCS.overlay_menu({
		definition = create_UIBox_ap_shop(),
	})
end

function G.FUNCS.exit_ap_shop(e)
	if e then
		-- This is only needed when back button is pressed
		G.FUNCS.exit_overlay_menu(e)
	end
end

local create_UIBox_HUDRef = create_UIBox_HUD
function create_UIBox_HUD(type, run_info)
	local uiBox_hud = create_UIBox_HUDRef(type, run_info)

	-- Add AP logo for blinds (next to reward) that have not been beaten yet.
	local targetNode = util_get_ui_node(uiBox_hud, { 1, 1, -1, 1, 1 })
	if targetNode then
		local button = {
			n = G.UIT.R,
			config = {
				align = "cm",
				maxw = 1,
				minh = 1,
				padding = 0.05,
				r = 0.1,
				hover = true,
				colour = G.C.BLUE,
				button = "ap_shop",
				shadow = true,
			},
			nodes = {
				{
					n = G.UIT.C,
					config = {
						align = "cm",
						focus_args = { button = "start", orientation = "bm" },
						func = "set_button_pip",
					},
					nodes = {
						{
							n = G.UIT.R,
							config = { align = "cm" },
							nodes = {
								{
									n = G.UIT.T,
									config = { text = "AP", scale = 0.45, colour = G.C.UI.TEXT_LIGHT, shadow = true },
								},
							},
						},
						{
							n = G.UIT.R,
							config = { align = "cm" },
							nodes = {
								{
									n = G.UIT.T,
									config = { text = "Shop", scale = 0.35, colour = G.C.UI.TEXT_LIGHT, shadow = true },
								},
							},
						},
					},
				},
			},
		}

		table.insert(targetNode, button)
	end

	return uiBox_hud
end

function create_UIBox_ap_shop()
	local first_row = {}
	for i = 1, 10, 1 do
		table.insert(first_row, ap_createShopItem(i))
	end
	local second_row = {}
	for i = 1, 10, 1 do
		table.insert(second_row, ap_createShopItem(i + 2))
	end
	local third_row = {}
	for i = 1, 10, 1 do
		table.insert(third_row, ap_createShopItem(i + 4))
	end

	play_sound("whoosh1", math.random() * 0.1 + 0.3, 0.3)
	play_sound("crumple" .. math.random(1, 5), math.random() * 0.2 + 0.6, 0.65)

	return (
		create_UIBox_generic_options({
			back_func = "exit_ap_shop",
			contents = {
				{
					n = G.UIT.C,
					config = {
						padding = 0,
						align = "tm",
					},
					nodes = {
						{
							n = G.UIT.R,
							config = { align = "cm" },
							nodes = {
								{
									n = G.UIT.O,
									config = {
										object = DynaText({
											string = "Archipelago SHOP",
											colours = { G.C.UI.TEXT_LIGHT },
											rotate = true,
											bump = true,
											silent = true,
											shadow = true,
											scale = 1,
										}),
									},
								},
							},
						},
						{
							n = G.UIT.R,
							config = { align = "cm" },
							nodes = {
								{ n = G.UIT.B, config = { h = 0.8, w = 1 } },
							},
						},
						{ n = G.UIT.R, config = { align = "cm" }, nodes = first_row },
						{ n = G.UIT.R, config = { align = "cm" }, nodes = second_row },
						{ n = G.UIT.R, config = { align = "cm" }, nodes = third_row },
					},
				},
			},
		})
	)
end

SMODS.Voucher({
	key = "ap_shop_item",
	set = "Voucher",
	name = "Shop Item",
	atlas = "ap_item_voucher",
	unlocked = true,
	discovered = true,
	cost = 3,
	requires = { "fuck!! shit!!!! (put here anything so it doesnt spawn naturally)" },
	in_pool = function(self)
		return false
	end,
	config = {
		extra = { id = 0 },
	},
	inject = function(self) -- prevent injection outside of AP
		if isAPProfileLoaded() then
			SMODS.Center.inject(self)
		end
	end,
	set_ability = function()
		print("hiya")
	end,
	set_sprites = function(self, card, card_table, other_card)
		-- if card.ability and card.ability.extra and card.ability.extra.id ~= 0 then
		-- 	if G.APClient ~= nil and not tableContains(G.APClient.missing_locations, card.ability.extra.id) then
		-- 		card.children.center.atlas = G.ASSET_ATLAS["Tarot"]
		-- 		card.children.center:set_sprite_pos({
		-- 			x = 6,
		-- 			y = 2,
		-- 		})
		-- 	end
		-- end
	end,
})

function ap_createShopItem(delay)
	local card_area = CardArea(
		G.hand.T.x + 0,
		G.hand.T.y + G.ROOM.T.y + 9,
		2.1 * G.CARD_W,
		1.05 * G.CARD_H,
		{ card_limit = 1, type = "shop", highlight_limit = 1 }
	)

	if G.P_CENTERS["v_rand_ap_item"] == nil then
		print("Cry about it")
	end

	local card = Card(
		card_area.T.x + card_area.T.w / 2,
		card_area.T.y,
		G.CARD_W,
		G.CARD_H,
		G.P_CARDS.empty,
		G.P_CENTERS["v_rand_ap_item"],
		{ bypass_discovery_center = true, bypass_discovery_ui = true }
	)
	card.shop_voucher = true
	card.states.visible = false

	G.E_MANAGER:add_event(Event({
		trigger = "after",
		delay = 0.05 * delay,
		blocking = false,
		blockable = false,
		func = function()
			create_shop_card_ui(card)
			card:start_materialize(nil, true)
			return true
		end,
	}))

	return { n = G.UIT.O, config = { object = card } }
end
