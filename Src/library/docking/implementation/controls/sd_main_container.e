indexing
	description: "Objects that represent an EV_TITLED_WINDOW.%
		%The original version of this class was generated by EiffelBuild."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_MAIN_CONTAINER

inherit
	SD_MAIN_CONTAINER_IMP


feature {NONE} -- Initialization

	user_initialization is
			-- Called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		local
			l_helper: SD_COLOR_HELPER
		do
			create internal_shared
			create l_helper
			left_top.set_background_color (l_helper.build_color_with_lightness (background_color, internal_shared.Auto_hide_panel_lightness))
			right_top.set_background_color (l_helper.build_color_with_lightness (background_color, internal_shared.Auto_hide_panel_lightness))
			left_bottom.set_background_color (l_helper.build_color_with_lightness (background_color, internal_shared.Auto_hide_panel_lightness))
			right_bottom.set_background_color (l_helper.build_color_with_lightness (background_color, internal_shared.Auto_hide_panel_lightness))

			gap_area_top.set_background_color (l_helper.build_color_with_lightness (background_color, internal_shared.Auto_hide_panel_lightness))
			gap_area_bottom.set_background_color (l_helper.build_color_with_lightness (background_color, internal_shared.Auto_hide_panel_lightness))
			gap_area_left.set_background_color (l_helper.build_color_with_lightness (background_color, internal_shared.Auto_hide_panel_lightness))
			gap_area_right.set_background_color (l_helper.build_color_with_lightness (background_color, internal_shared.Auto_hide_panel_lightness))

		end

feature -- Command

	set_gap (a_direction: INTEGER; a_show: BOOLEAN) is
			-- Show gap at `a_direction'?
		require
			a_direction_valid: a_direction = {SD_DOCKING_MANAGER}.dock_top or a_direction = {SD_DOCKING_MANAGER}.dock_bottom
				or a_direction = {SD_DOCKING_MANAGER}.dock_left or a_direction = {SD_DOCKING_MANAGER}.dock_right
		do
			inspect
				a_direction
			when {SD_DOCKING_MANAGER}.dock_top then
				if a_show then
					gap_area_top.set_minimum_height (internal_shared.auto_hide_panel_gap_size)
				else
					gap_area_top.set_minimum_height (0)
				end
			when {SD_DOCKING_MANAGER}.dock_bottom then
				if a_show then
					gap_area_bottom.set_minimum_height (internal_shared.auto_hide_panel_gap_size)
				else
					gap_area_bottom.set_minimum_height (0)
				end
			when {SD_DOCKING_MANAGER}.dock_left then
				if a_show then
					gap_area_left.set_minimum_width (internal_shared.auto_hide_panel_gap_size)
					left_top.set_minimum_width (auto_hide_bar_width)
					left_bottom.set_minimum_width (auto_hide_bar_width)
				else
					gap_area_left.set_minimum_width (0)
					left_top.set_minimum_width (0)
					left_bottom.set_minimum_width (0)
				end
			when {SD_DOCKING_MANAGER}.dock_right then
				if a_show then
					gap_area_right.set_minimum_width (internal_shared.auto_hide_panel_gap_size)
					right_top.set_minimum_width (auto_hide_bar_width)
					right_bottom.set_minimum_width (auto_hide_bar_width)
				else
					gap_area_right.set_minimum_width (0)
					right_top.set_minimum_width (0)
					right_bottom.set_minimum_width (0)
				end
			end
		end

feature {NONE} -- Implementation

	internal_shared: SD_SHARED
			-- All singletons.

end -- class SD_MAIN_CONTAINER

