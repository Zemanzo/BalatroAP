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
		table.insert(first_row, ap_createShopItem())
	end
	local second_row = {}
	for i = 1, 10, 1 do
		table.insert(second_row, ap_createShopItem())
	end
	local third_row = {}
	for i = 1, 10, 1 do
		table.insert(third_row, ap_createShopItem())
	end

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

function ap_createShopItem()
	local price = math.random(1, 999)
	local ap_icon = Sprite(0, 0, 1, 1, G.ASSET_ATLAS[G.AP.this_mod.prefix .. "_apicon"], { x = 0, y = 0 })
	ap_icon:define_draw_steps({
		{ shader = "dissolve", shadow_height = 0.05 },
		{ shader = "dissolve" },
	})
	ap_icon.states.drag.can = false

	-- local area = G.shop_jokers
	-- local _center = {order = 1, discovered = false, cost = 3, consumeable = true, name = "The Fool", pos = {x=0,y=0}, set = "Tarot", effect = "Disable Blind Effect", cost_mult = 1.0, config = {}}
	-- local card = Card(area.T.x + area.T.w/2, area.T.y, G.CARD_W, G.CARD_H, G.P_CARDS.empty, _center, {bypass_discovery_center = true, bypass_discovery_ui = true})

	-- local t1 = {
	--     n=G.UIT.ROOT, config = {minw = 0.6, align = 'tm', colour = darken(G.C.BLACK, 0.2), shadow = true, r = 0.05, padding = 0.05, minh = 1}, nodes={
	--         {n=G.UIT.R, config={align = "cm", colour = lighten(G.C.BLACK, 0.1), r = 0.1, minw = 1, minh = 0.55, emboss = 0.05, padding = 0.03}, nodes={
	--           {n=G.UIT.O, config={object = DynaText({string = {{prefix = localize('$')..price, ref_value = 'cost'}}, colours = {G.C.MONEY},shadow = true, silent = true, bump = true, pop_in = 0, scale = 0.5})}},
	--         }}
	--     }}

	return {
		n = G.UIT.C,
		config = { align = "cm", padding = 0.1, w = 3 },
		nodes = {
			{
				n = G.UIT.C,
				config = {
					align = "cm",
					padding = 0.1,
					w = 2.9,
					r = 1,
					colour = lighten(G.C.JOKER_GREY, 0.5),
					shadow = true,
				},
				nodes = {
					{
						n = G.UIT.C,
						config = { align = "cm", padding = 0.1, w = 2.8, r = 1, colour = lighten(G.C.BLACK, 0.1) },
						nodes = {
							{
								n = G.UIT.R,
								config = { align = "cm" },
								nodes = {
									{ n = G.UIT.O, config = { w = 1, h = 1, object = ap_icon } },
								},
							},
							{
								n = G.UIT.R,
								config = { align = "cm" },
								nodes = {
									-- {n=G.UIT.T, config={text = "Cost: ", scale = 0.4, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
									{
										n = G.UIT.O,
										config = {
											object = DynaText({
												string = localize("$") .. price,
												colours = { G.C.MONEY },
												rotate = true,
												bump = true,
												silent = true,
												scale = 0.4,
											}),
										},
									},
								},
							},
						},
					},
				},
			},
		},
	}
end
