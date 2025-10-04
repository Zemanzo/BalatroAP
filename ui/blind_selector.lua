local create_UIBox_blind_choiceRef = create_UIBox_blind_choice
function create_UIBox_blind_choice(type, run_info)
	local uiBox_blind_choice = create_UIBox_blind_choiceRef(type, run_info)

	-- Add AP logo for blinds (next to reward) that have not been beaten yet.
	local targetNode = util_get_ui_node(uiBox_blind_choice, { 1, 3, 1, 2 })
	if targetNode then
		-- Icon
		local ap_icon = Sprite(0, 0, 1, 1, G.ASSET_ATLAS[G.AP.this_mod.prefix .. "_balatroicon"], { x = 0, y = 0 })
		ap_icon:define_draw_steps({
			{ shader = "dissolve", shadow_height = 0.05 },
			{ shader = "dissolve" },
		})
		ap_icon.states.drag.can = false

		local ap_reward = {
			n = G.UIT.R,
			config = { align = "cm" },
			nodes = {
				{ n = G.UIT.O, config = { w = 0.4, h = 0.4, object = ap_icon } },
				{
					n = G.UIT.T,
					config = { text = " Three of a Kind", scale = 0.35, colour = G.C.MONEY, shadow = not disabled },
				},
			},
		}

		ap_icon.float = true
		ap_icon.states.hover.can = true
		ap_icon.states.drag.can = false
		ap_icon.states.collide.can = true
		ap_icon.config = { force_focus = true }
		ap_icon.hover = function()
			if not G.CONTROLLER.dragging.target or G.CONTROLLER.using_touch then
				if not ap_icon.hovering and ap_icon.states.visible then
					ap_icon.hovering = true
					ap_icon.hover_tilt = 3
					ap_icon:juice_up(0.05, 0.02)
					play_sound("chips1", math.random() * 0.1 + 0.55, 0.12)
					ap_icon.config.h_popup = {
						n = G.UIT.ROOT,
						config = { align = "cm", colour = G.C.CLEAR },
						nodes = {
							{
								n = G.UIT.R,
								config = {
									align = "cm",
									func = "show_infotip",
									object = Moveable(),
									padding = 0.05,
									colour = lighten(G.C.JOKER_GREY, 0.5),
									r = 0.1,
									shadow = true,
								},
								nodes = {
									{
										n = G.UIT.C,
										config = { align = "cm", padding = 0.1, r = 0.1, colour = G.C.BLACK },
										nodes = {
											{
												n = G.UIT.R,
												config = { align = "cm" },
												nodes = {
													{
														n = G.UIT.T,
														config = {
															text = "Zemanzo_Jigsaw's",
															scale = 0.35,
															colour = G.C.UI.TEXT_LIGHT,
														},
													},
												},
											},
											{
												n = G.UIT.R,
												config = { align = "cm" },
												nodes = {
													{
														n = G.UIT.T,
														config = {
															text = "Puzzle Piece",
															scale = 0.35,
															colour = G.C.PURPLE,
															shadow = true,
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
					ap_icon.config.h_popup_config = { align = "tm", offset = { x = 0, y = -0.1 }, parent = ap_icon }
					Node.hover(ap_icon)
					if ap_icon.children.alert then
						ap_icon.children.alert:remove()
						ap_icon.children.alert = nil
						ap_icon.config.blind.alerted = true
						G:save_progress()
					end
				end
			end
			ap_icon.stop_hover = function()
				ap_icon.hovering = false
				Node.stop_hover(ap_icon)
				ap_icon.hover_tilt = 0
			end
		end

		table.insert(targetNode, ap_reward)
	end

	return uiBox_blind_choice
end
