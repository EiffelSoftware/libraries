indexing
	description: "Objects that represent an EV_TITLED_WINDOW.%
		%The original version of this class was generated by EiffelBuild."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ITEM_TAB_IMP

inherit
	EV_VERTICAL_BOX
		redefine
			initialize, is_in_default_state
		end
			
	CONSTANTS
		undefine
			is_equal, default_create, copy
		end

-- This class is the implementation of an EV_TITLED_WINDOW generated by EiffelBuild.
-- You should not modify this code by hand, as it will be re-generated every time
-- modifications are made to the project.

feature {NONE}-- Initialization

	initialize is
			-- Initialize `Current'.
		do
			Precursor {EV_VERTICAL_BOX}
			initialize_constants
			
				-- Create all widgets.
			create item_finder
			create item_frame
			create main_box
			create l_ev_horizontal_box_1
			create l_ev_label_1
			create item_x_index
			create l_ev_label_2
			create item_y_index
			create l_ev_table_1
			create textable_container
			create l_ev_label_3
			create textable_entry
			create is_selected
			create pixmapable_container
			create l_ev_label_4
			create pixmap_holder
			create left_border_container
			create l_ev_label_5
			create left_border_spin_button
			create spacing_container
			create l_ev_label_6
			create spacing_spin_button
			create alignment_container
			create l_ev_label_7
			create alignment_combo
			create left_alignment_item
			create center_alignment_item
			create right_alignment_item
			create apply_pixmap_row_button
			create apply_pixmap_column_button
			create apply_alignment_row_button
			create apply_alignment_column_button
			create apply_left_border_row_button
			create apply_left_border_column_button
			create apply_spacing_row_button
			create apply_spacing_column_button
			create l_ev_horizontal_box_2
			create l_ev_label_8
			create foreground_color_combo
			create l_ev_horizontal_box_3
			create l_ev_label_9
			create background_color_combo
			create apply_background_row_button
			create apply_background_column_button
			create apply_selection_row_button
			create apply_selection_column_button
			create apply_foreground_row_button
			create apply_foreground_column_button
			create top_border_container
			create l_ev_label_10
			create top_border_spin_button
			create bottom_border_container
			create l_ev_label_11
			create bottom_border_spin_button
			create right_border_container
			create l_ev_label_12
			create right_border_spin_button
			create apply_bottom_border_row_button
			create apply_bottom_border_column_button
			create apply_right_border_row_button
			create apply_right_border_column_button
			create apply_top_border_row_button
			create apply_top_border_column_button
			create vertical_alignment_container
			create l_ev_label_13
			create vertical_alignment_combo
			create top_alignment_item
			create vertically_center_item
			create bottom_alignment_item
			create apply_vertical_alignment_column_button
			create apply_vertical_alignment_row_button
			create font_container
			create l_ev_label_14
			create font_combo
			create l_ev_cell_1
			create font_size_combo
			create l_ev_list_item_1
			create l_ev_list_item_2
			create l_ev_list_item_3
			create l_ev_list_item_4
			create l_ev_list_item_5
			create l_ev_list_item_6
			create l_ev_list_item_7
			create l_ev_list_item_8
			create l_ev_list_item_9
			create l_ev_list_item_10
			create l_ev_list_item_11
			create apply_font_row_button
			create apply_font_column_button
			create is_full_select_button
			create apply_full_select_row_button
			create apply_full_select_column_button
			create apply_text_row_button
			create apply_text_column_button
			create item_operations_frame
			create l_ev_vertical_box_1
			create remove_item_button
			
				-- Build_widget_structure.
			extend (item_finder)
			extend (item_frame)
			item_frame.extend (main_box)
			main_box.extend (l_ev_horizontal_box_1)
			l_ev_horizontal_box_1.extend (l_ev_label_1)
			l_ev_horizontal_box_1.extend (item_x_index)
			l_ev_horizontal_box_1.extend (l_ev_label_2)
			l_ev_horizontal_box_1.extend (item_y_index)
			main_box.extend (l_ev_table_1)
			textable_container.extend (l_ev_label_3)
			textable_container.extend (textable_entry)
			pixmapable_container.extend (l_ev_label_4)
			pixmapable_container.extend (pixmap_holder)
			left_border_container.extend (l_ev_label_5)
			left_border_container.extend (left_border_spin_button)
			spacing_container.extend (l_ev_label_6)
			spacing_container.extend (spacing_spin_button)
			alignment_container.extend (l_ev_label_7)
			alignment_container.extend (alignment_combo)
			alignment_combo.extend (left_alignment_item)
			alignment_combo.extend (center_alignment_item)
			alignment_combo.extend (right_alignment_item)
			l_ev_horizontal_box_2.extend (l_ev_label_8)
			l_ev_horizontal_box_2.extend (foreground_color_combo)
			l_ev_horizontal_box_3.extend (l_ev_label_9)
			l_ev_horizontal_box_3.extend (background_color_combo)
			top_border_container.extend (l_ev_label_10)
			top_border_container.extend (top_border_spin_button)
			bottom_border_container.extend (l_ev_label_11)
			bottom_border_container.extend (bottom_border_spin_button)
			right_border_container.extend (l_ev_label_12)
			right_border_container.extend (right_border_spin_button)
			vertical_alignment_container.extend (l_ev_label_13)
			vertical_alignment_container.extend (vertical_alignment_combo)
			vertical_alignment_combo.extend (top_alignment_item)
			vertical_alignment_combo.extend (vertically_center_item)
			vertical_alignment_combo.extend (bottom_alignment_item)
			font_container.extend (l_ev_label_14)
			font_container.extend (font_combo)
			font_container.extend (l_ev_cell_1)
			font_container.extend (font_size_combo)
			font_size_combo.extend (l_ev_list_item_1)
			font_size_combo.extend (l_ev_list_item_2)
			font_size_combo.extend (l_ev_list_item_3)
			font_size_combo.extend (l_ev_list_item_4)
			font_size_combo.extend (l_ev_list_item_5)
			font_size_combo.extend (l_ev_list_item_6)
			font_size_combo.extend (l_ev_list_item_7)
			font_size_combo.extend (l_ev_list_item_8)
			font_size_combo.extend (l_ev_list_item_9)
			font_size_combo.extend (l_ev_list_item_10)
			font_size_combo.extend (l_ev_list_item_11)
			extend (item_operations_frame)
			item_operations_frame.extend (l_ev_vertical_box_1)
			l_ev_vertical_box_1.extend (remove_item_button)
			
			item_frame.disable_sensitive
			item_frame.set_text ("Item Properties")
			main_box.set_padding_width (box_padding)
			main_box.set_border_width (box_padding)
			main_box.disable_item_expand (l_ev_horizontal_box_1)
			l_ev_horizontal_box_1.set_padding_width (box_padding)
			l_ev_horizontal_box_1.disable_item_expand (l_ev_label_1)
			l_ev_horizontal_box_1.disable_item_expand (l_ev_label_2)
			l_ev_label_1.set_text ("X Index")
			l_ev_label_1.align_text_left
			item_x_index.value_range.adapt (create {INTEGER_INTERVAL}.make (0, 1000000))
			l_ev_label_2.set_text ("Y Index")
			item_y_index.value_range.adapt (create {INTEGER_INTERVAL}.make (0, 1000000))
			l_ev_table_1.resize (3, 14)
			l_ev_table_1.set_row_spacing (box_padding)
			l_ev_table_1.set_column_spacing (box_padding)
			l_ev_table_1.set_border_width (box_padding)
				-- Insert and position all children of `l_ev_table_1'.
			l_ev_table_1.put_at_position (textable_container, 1, 1, 1, 1)
			l_ev_table_1.put_at_position (is_selected, 1, 10, 1, 1)
			l_ev_table_1.put_at_position (pixmapable_container, 1, 2, 1, 1)
			l_ev_table_1.put_at_position (left_border_container, 1, 5, 1, 1)
			l_ev_table_1.put_at_position (spacing_container, 1, 9, 1, 1)
			l_ev_table_1.put_at_position (alignment_container, 1, 3, 1, 1)
			l_ev_table_1.put_at_position (apply_pixmap_row_button, 2, 2, 1, 1)
			l_ev_table_1.put_at_position (apply_pixmap_column_button, 3, 2, 1, 1)
			l_ev_table_1.put_at_position (apply_alignment_row_button, 2, 3, 1, 1)
			l_ev_table_1.put_at_position (apply_alignment_column_button, 3, 3, 1, 1)
			l_ev_table_1.put_at_position (apply_left_border_row_button, 2, 5, 1, 1)
			l_ev_table_1.put_at_position (apply_left_border_column_button, 3, 5, 1, 1)
			l_ev_table_1.put_at_position (apply_spacing_row_button, 2, 9, 1, 1)
			l_ev_table_1.put_at_position (apply_spacing_column_button, 3, 9, 1, 1)
			l_ev_table_1.put_at_position (l_ev_horizontal_box_2, 1, 11, 1, 1)
			l_ev_table_1.put_at_position (l_ev_horizontal_box_3, 1, 12, 1, 1)
			l_ev_table_1.put_at_position (apply_background_row_button, 2, 12, 1, 1)
			l_ev_table_1.put_at_position (apply_background_column_button, 3, 12, 1, 1)
			l_ev_table_1.put_at_position (apply_selection_row_button, 2, 10, 1, 1)
			l_ev_table_1.put_at_position (apply_selection_column_button, 3, 10, 1, 1)
			l_ev_table_1.put_at_position (apply_foreground_row_button, 2, 11, 1, 1)
			l_ev_table_1.put_at_position (apply_foreground_column_button, 3, 11, 1, 1)
			l_ev_table_1.put_at_position (top_border_container, 1, 7, 1, 1)
			l_ev_table_1.put_at_position (bottom_border_container, 1, 8, 1, 1)
			l_ev_table_1.put_at_position (right_border_container, 1, 6, 1, 1)
			l_ev_table_1.put_at_position (apply_bottom_border_row_button, 2, 8, 1, 1)
			l_ev_table_1.put_at_position (apply_bottom_border_column_button, 3, 8, 1, 1)
			l_ev_table_1.put_at_position (apply_right_border_row_button, 2, 6, 1, 1)
			l_ev_table_1.put_at_position (apply_right_border_column_button, 3, 6, 1, 1)
			l_ev_table_1.put_at_position (apply_top_border_row_button, 2, 7, 1, 1)
			l_ev_table_1.put_at_position (apply_top_border_column_button, 3, 7, 1, 1)
			l_ev_table_1.put_at_position (vertical_alignment_container, 1, 4, 1, 1)
			l_ev_table_1.put_at_position (apply_vertical_alignment_column_button, 3, 4, 1, 1)
			l_ev_table_1.put_at_position (apply_vertical_alignment_row_button, 2, 4, 1, 1)
			l_ev_table_1.put_at_position (font_container, 1, 13, 1, 1)
			l_ev_table_1.put_at_position (apply_font_row_button, 2, 13, 1, 1)
			l_ev_table_1.put_at_position (apply_font_column_button, 3, 13, 1, 1)
			l_ev_table_1.put_at_position (is_full_select_button, 1, 14, 1, 1)
			l_ev_table_1.put_at_position (apply_full_select_row_button, 3, 14, 1, 1)
			l_ev_table_1.put_at_position (apply_full_select_column_button, 2, 14, 1, 1)
			l_ev_table_1.put_at_position (apply_text_row_button, 2, 1, 1, 1)
			l_ev_table_1.put_at_position (apply_text_column_button, 3, 1, 1, 1)
			textable_container.disable_item_expand (l_ev_label_3)
			l_ev_label_3.set_text ("Text : ")
			textable_entry.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (212, 208, 200))
			is_selected.set_text ("is_selected")
			pixmapable_container.disable_item_expand (l_ev_label_4)
			l_ev_label_4.set_text ("Pixmap : ")
			left_border_container.disable_item_expand (l_ev_label_5)
			l_ev_label_5.set_text ("Left Border : ")
			spacing_container.disable_item_expand (l_ev_label_6)
			l_ev_label_6.set_text ("Spacing : ")
			alignment_container.disable_item_expand (l_ev_label_7)
			l_ev_label_7.set_text ("Alignment : ")
			l_ev_label_7.align_text_left
			alignment_combo.set_text ("Left")
			left_alignment_item.set_text ("Left")
			center_alignment_item.set_text ("Center")
			right_alignment_item.set_text ("Right")
			apply_pixmap_row_button.set_text ("Apply Row")
			apply_pixmap_column_button.set_text ("Apply Column")
			apply_alignment_row_button.set_text ("Apply Row")
			apply_alignment_column_button.set_text ("Apply Column")
			apply_left_border_row_button.set_text ("Apply Row")
			apply_left_border_column_button.set_text ("Apply Column")
			apply_spacing_row_button.set_text ("Apply Row")
			apply_spacing_column_button.set_text ("Apply Column")
			l_ev_horizontal_box_2.disable_item_expand (l_ev_label_8)
			l_ev_label_8.set_text ("Foreground Color : ")
			l_ev_horizontal_box_3.disable_item_expand (l_ev_label_9)
			l_ev_label_9.set_text ("Background Color : ")
			apply_background_row_button.set_text ("Apply Row")
			apply_background_column_button.set_text ("Apply Column")
			apply_selection_row_button.set_text ("Apply Row")
			apply_selection_column_button.set_text ("Apply Column")
			apply_foreground_row_button.set_text ("Apply Row")
			apply_foreground_column_button.set_text ("Apply Column")
			top_border_container.disable_item_expand (l_ev_label_10)
			l_ev_label_10.set_text ("Top Border : ")
			bottom_border_container.disable_item_expand (l_ev_label_11)
			l_ev_label_11.set_text ("Bottom Border : ")
			right_border_container.disable_item_expand (l_ev_label_12)
			l_ev_label_12.set_text ("Right Border : ")
			apply_bottom_border_row_button.set_text ("Apply Row")
			apply_bottom_border_column_button.set_text ("Apply Column")
			apply_right_border_row_button.set_text ("Apply Row")
			apply_right_border_column_button.set_text ("Apply Column")
			apply_top_border_row_button.set_text ("Apply Row")
			apply_top_border_column_button.set_text ("Apply Column")
			vertical_alignment_container.disable_item_expand (l_ev_label_13)
			l_ev_label_13.set_text ("V. Alignment : ")
			l_ev_label_13.align_text_left
			vertical_alignment_combo.set_text ("Top")
			top_alignment_item.set_text ("Top")
			vertically_center_item.set_text ("Center")
			bottom_alignment_item.set_text ("Bottom")
			apply_vertical_alignment_column_button.set_text ("Apply Column")
			apply_vertical_alignment_row_button.set_text ("Apply Column")
			font_container.disable_item_expand (l_ev_label_14)
			font_container.disable_item_expand (l_ev_cell_1)
			font_container.disable_item_expand (font_size_combo)
			l_ev_label_14.set_text ("Font : ")
			font_size_combo.set_minimum_width (50)
			l_ev_list_item_2.set_text ("6")
			l_ev_list_item_3.set_text ("8")
			l_ev_list_item_4.set_text ("10")
			l_ev_list_item_5.set_text ("12")
			l_ev_list_item_6.set_text ("14")
			l_ev_list_item_7.set_text ("18")
			l_ev_list_item_8.set_text ("24")
			l_ev_list_item_9.set_text ("36")
			l_ev_list_item_10.set_text ("48")
			l_ev_list_item_11.set_text ("72")
			apply_font_row_button.set_text ("Apply Row")
			apply_font_column_button.set_text ("Apply Column")
			is_full_select_button.set_text ("is_full_select_enabled")
			apply_full_select_row_button.set_text ("Apply Column")
			apply_full_select_column_button.set_text ("Apply_Row")
			apply_text_row_button.set_text ("Apply Row")
			apply_text_column_button.set_text ("Apply Column")
			item_operations_frame.disable_sensitive
			item_operations_frame.set_text ("Item Operations")
			l_ev_vertical_box_1.set_padding_width (box_padding)
			l_ev_vertical_box_1.set_border_width (box_padding)
			l_ev_vertical_box_1.disable_item_expand (remove_item_button)
			remove_item_button.set_text ("Remove Item")
			set_border_width (box_padding)
			disable_item_expand (item_finder)
			disable_item_expand (item_frame)
			disable_item_expand (item_operations_frame)
			
				--Connect events.
			item_x_index.change_actions.extend (agent item_x_index_changed (?))
			item_y_index.change_actions.extend (agent item_y_index_changed (?))
			textable_entry.change_actions.extend (agent textable_entry_changed)
			is_selected.select_actions.extend (agent is_selected_selected)
			pixmap_holder.select_actions.extend (agent pixmap_holder_item_selected)
			left_border_spin_button.change_actions.extend (agent left_border_spin_button_changed (?))
			spacing_spin_button.change_actions.extend (agent spacing_spin_button_changed (?))
			left_alignment_item.select_actions.extend (agent left_alignment_item_selected)
			center_alignment_item.select_actions.extend (agent center_alignment_item_selected)
			right_alignment_item.select_actions.extend (agent right_alignment_item_selected)
			apply_pixmap_row_button.select_actions.extend (agent apply_pixmap_row_button_selected)
			apply_pixmap_column_button.select_actions.extend (agent apply_pixmap_column_selected)
			apply_alignment_row_button.select_actions.extend (agent apply_alignment_row_button_selected)
			apply_alignment_column_button.select_actions.extend (agent apply_alignment_column_button_selected)
			apply_left_border_row_button.select_actions.extend (agent apply_left_border_row_button_selected)
			apply_left_border_column_button.select_actions.extend (agent apply_left_border_column_button_selected)
			apply_spacing_row_button.select_actions.extend (agent apply_spacing_row_button_selected)
			apply_spacing_column_button.select_actions.extend (agent apply_spacing_column_button_selected)
			foreground_color_combo.select_actions.extend (agent foreground_color_combo_selected)
			background_color_combo.select_actions.extend (agent background_color_combo_selected)
			apply_background_row_button.select_actions.extend (agent apply_background_row_button_selected)
			apply_background_column_button.select_actions.extend (agent apply_background_column_button_selected)
			apply_selection_row_button.select_actions.extend (agent apply_selection_row_selected_button)
			apply_selection_column_button.select_actions.extend (agent apply_selection_column_button_selected)
			apply_foreground_row_button.select_actions.extend (agent apply_foreground_row_button_selected)
			apply_foreground_column_button.select_actions.extend (agent apply_foreground_column_button_selected)
			top_border_spin_button.change_actions.extend (agent top_border_spin_button_changed (?))
			bottom_border_spin_button.change_actions.extend (agent bottom_border_spin_button_changed (?))
			right_border_spin_button.change_actions.extend (agent right_border_spin_button_changed (?))
			apply_bottom_border_row_button.select_actions.extend (agent apply_bottom_border_row_button_selected)
			apply_bottom_border_column_button.select_actions.extend (agent apply_bottom_border_column_button_selected)
			apply_right_border_row_button.select_actions.extend (agent apply_right_border_row_button_selected)
			apply_right_border_column_button.select_actions.extend (agent apply_right_border_column_button_selected)
			apply_top_border_row_button.select_actions.extend (agent apply_top_border_row_button_selected)
			apply_top_border_column_button.select_actions.extend (agent apply_top_border_column_button_selected)
			top_alignment_item.select_actions.extend (agent top_alignment_item_selected)
			vertically_center_item.select_actions.extend (agent vertically_center_item_selected)
			bottom_alignment_item.select_actions.extend (agent bottom_alignment_item_selected)
			apply_vertical_alignment_column_button.select_actions.extend (agent apply_vertical_alignment_column_button_selected)
			apply_vertical_alignment_row_button.select_actions.extend (agent apply_vertical_alignment_row_button_selected)
			font_combo.select_actions.extend (agent font_combo_selected)
			font_size_combo.select_actions.extend (agent font_size_combo_selected)
			apply_font_row_button.select_actions.extend (agent apply_font_row_button_selected)
			apply_font_column_button.select_actions.extend (agent apply_font_column_button_selected)
			is_full_select_button.select_actions.extend (agent is_full_select_button_selected)
			apply_full_select_row_button.select_actions.extend (agent apply_full_select_row_button_selected)
			apply_full_select_column_button.select_actions.extend (agent apply_full_select_column_button_selected)
			apply_text_row_button.select_actions.extend (agent apply_text_row_button_selected)
			apply_text_column_button.select_actions.extend (agent apply_text_column_button_selected)
			remove_item_button.select_actions.extend (agent remove_item_button_selected)
				-- Close the application when an interface close
				-- request is recieved on `Current'. i.e. the cross is clicked.

				-- Call `user_initialization'.
			user_initialization
		end

feature -- Access

	main_box: EV_VERTICAL_BOX
	is_selected, is_full_select_button: EV_CHECK_BUTTON
	item_x_index, item_y_index, left_border_spin_button,
	spacing_spin_button, top_border_spin_button, bottom_border_spin_button, right_border_spin_button: EV_SPIN_BUTTON
	item_finder: GRID_ITEM_FINDER
	textable_container,
	pixmapable_container, left_border_container, spacing_container, alignment_container,
	top_border_container, bottom_border_container, right_border_container, vertical_alignment_container,
	font_container: EV_HORIZONTAL_BOX
	apply_pixmap_row_button, apply_pixmap_column_button, apply_alignment_row_button,
	apply_alignment_column_button, apply_left_border_row_button, apply_left_border_column_button,
	apply_spacing_row_button, apply_spacing_column_button, apply_background_row_button,
	apply_background_column_button, apply_selection_row_button, apply_selection_column_button,
	apply_foreground_row_button, apply_foreground_column_button, apply_bottom_border_row_button,
	apply_bottom_border_column_button, apply_right_border_row_button, apply_right_border_column_button,
	apply_top_border_row_button, apply_top_border_column_button, apply_vertical_alignment_column_button,
	apply_vertical_alignment_row_button, apply_font_row_button, apply_font_column_button,
	apply_full_select_row_button, apply_full_select_column_button, apply_text_row_button,
	apply_text_column_button, remove_item_button: EV_BUTTON
	item_frame, item_operations_frame: EV_FRAME
	pixmap_holder,
	alignment_combo, foreground_color_combo, background_color_combo, vertical_alignment_combo,
	font_combo, font_size_combo: EV_COMBO_BOX
	textable_entry: EV_TEXT_FIELD
	left_alignment_item, center_alignment_item,
	right_alignment_item, top_alignment_item, vertically_center_item, bottom_alignment_item: EV_LIST_ITEM

feature {NONE} -- Implementation

	l_ev_list_item_1, l_ev_list_item_2, l_ev_list_item_3, l_ev_list_item_4, l_ev_list_item_5,
	l_ev_list_item_6, l_ev_list_item_7, l_ev_list_item_8, l_ev_list_item_9, l_ev_list_item_10,
	l_ev_list_item_11: EV_LIST_ITEM
	l_ev_vertical_box_1: EV_VERTICAL_BOX
	l_ev_horizontal_box_1, l_ev_horizontal_box_2,
	l_ev_horizontal_box_3: EV_HORIZONTAL_BOX
	l_ev_label_1, l_ev_label_2, l_ev_label_3, l_ev_label_4, l_ev_label_5,
	l_ev_label_6, l_ev_label_7, l_ev_label_8, l_ev_label_9, l_ev_label_10, l_ev_label_11,
	l_ev_label_12, l_ev_label_13, l_ev_label_14: EV_LABEL
	l_ev_table_1: EV_TABLE
	l_ev_cell_1: EV_CELL

feature {NONE} -- Implementation

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			-- Re-implement if you wish to enable checking
			-- for `Current'.
			Result := True
		end
	
	user_initialization is
			-- Feature for custom initialization, called at end of `initialize'.
		deferred
		end
	
	item_x_index_changed (a_value: INTEGER) is
			-- Called by `change_actions' of `item_x_index'.
		deferred
		end
	
	item_y_index_changed (a_value: INTEGER) is
			-- Called by `change_actions' of `item_y_index'.
		deferred
		end
	
	textable_entry_changed is
			-- Called by `change_actions' of `textable_entry'.
		deferred
		end
	
	is_selected_selected is
			-- Called by `select_actions' of `is_selected'.
		deferred
		end
	
	pixmap_holder_item_selected is
			-- Called by `select_actions' of `pixmap_holder'.
		deferred
		end
	
	left_border_spin_button_changed (a_value: INTEGER) is
			-- Called by `change_actions' of `left_border_spin_button'.
		deferred
		end
	
	spacing_spin_button_changed (a_value: INTEGER) is
			-- Called by `change_actions' of `spacing_spin_button'.
		deferred
		end
	
	left_alignment_item_selected is
			-- Called by `select_actions' of `left_alignment_item'.
		deferred
		end
	
	center_alignment_item_selected is
			-- Called by `select_actions' of `center_alignment_item'.
		deferred
		end
	
	right_alignment_item_selected is
			-- Called by `select_actions' of `right_alignment_item'.
		deferred
		end
	
	apply_pixmap_row_button_selected is
			-- Called by `select_actions' of `apply_pixmap_row_button'.
		deferred
		end
	
	apply_pixmap_column_selected is
			-- Called by `select_actions' of `apply_pixmap_column_button'.
		deferred
		end
	
	apply_alignment_row_button_selected is
			-- Called by `select_actions' of `apply_alignment_row_button'.
		deferred
		end
	
	apply_alignment_column_button_selected is
			-- Called by `select_actions' of `apply_alignment_column_button'.
		deferred
		end
	
	apply_left_border_row_button_selected is
			-- Called by `select_actions' of `apply_left_border_row_button'.
		deferred
		end
	
	apply_left_border_column_button_selected is
			-- Called by `select_actions' of `apply_left_border_column_button'.
		deferred
		end
	
	apply_spacing_row_button_selected is
			-- Called by `select_actions' of `apply_spacing_row_button'.
		deferred
		end
	
	apply_spacing_column_button_selected is
			-- Called by `select_actions' of `apply_spacing_column_button'.
		deferred
		end
	
	foreground_color_combo_selected is
			-- Called by `select_actions' of `foreground_color_combo'.
		deferred
		end
	
	background_color_combo_selected is
			-- Called by `select_actions' of `background_color_combo'.
		deferred
		end
	
	apply_background_row_button_selected is
			-- Called by `select_actions' of `apply_background_row_button'.
		deferred
		end
	
	apply_background_column_button_selected is
			-- Called by `select_actions' of `apply_background_column_button'.
		deferred
		end
	
	apply_selection_row_selected_button is
			-- Called by `select_actions' of `apply_selection_row_button'.
		deferred
		end
	
	apply_selection_column_button_selected is
			-- Called by `select_actions' of `apply_selection_column_button'.
		deferred
		end
	
	apply_foreground_row_button_selected is
			-- Called by `select_actions' of `apply_foreground_row_button'.
		deferred
		end
	
	apply_foreground_column_button_selected is
			-- Called by `select_actions' of `apply_foreground_column_button'.
		deferred
		end
	
	top_border_spin_button_changed (a_value: INTEGER) is
			-- Called by `change_actions' of `top_border_spin_button'.
		deferred
		end
	
	bottom_border_spin_button_changed (a_value: INTEGER) is
			-- Called by `change_actions' of `bottom_border_spin_button'.
		deferred
		end
	
	right_border_spin_button_changed (a_value: INTEGER) is
			-- Called by `change_actions' of `right_border_spin_button'.
		deferred
		end
	
	apply_bottom_border_row_button_selected is
			-- Called by `select_actions' of `apply_bottom_border_row_button'.
		deferred
		end
	
	apply_bottom_border_column_button_selected is
			-- Called by `select_actions' of `apply_bottom_border_column_button'.
		deferred
		end
	
	apply_right_border_row_button_selected is
			-- Called by `select_actions' of `apply_right_border_row_button'.
		deferred
		end
	
	apply_right_border_column_button_selected is
			-- Called by `select_actions' of `apply_right_border_column_button'.
		deferred
		end
	
	apply_top_border_row_button_selected is
			-- Called by `select_actions' of `apply_top_border_row_button'.
		deferred
		end
	
	apply_top_border_column_button_selected is
			-- Called by `select_actions' of `apply_top_border_column_button'.
		deferred
		end
	
	top_alignment_item_selected is
			-- Called by `select_actions' of `top_alignment_item'.
		deferred
		end
	
	vertically_center_item_selected is
			-- Called by `select_actions' of `vertically_center_item'.
		deferred
		end
	
	bottom_alignment_item_selected is
			-- Called by `select_actions' of `bottom_alignment_item'.
		deferred
		end
	
	apply_vertical_alignment_column_button_selected is
			-- Called by `select_actions' of `apply_vertical_alignment_column_button'.
		deferred
		end
	
	apply_vertical_alignment_row_button_selected is
			-- Called by `select_actions' of `apply_vertical_alignment_row_button'.
		deferred
		end
	
	font_combo_selected is
			-- Called by `select_actions' of `font_combo'.
		deferred
		end
	
	font_size_combo_selected is
			-- Called by `select_actions' of `font_size_combo'.
		deferred
		end
	
	apply_font_row_button_selected is
			-- Called by `select_actions' of `apply_font_row_button'.
		deferred
		end
	
	apply_font_column_button_selected is
			-- Called by `select_actions' of `apply_font_column_button'.
		deferred
		end
	
	is_full_select_button_selected is
			-- Called by `select_actions' of `is_full_select_button'.
		deferred
		end
	
	apply_full_select_row_button_selected is
			-- Called by `select_actions' of `apply_full_select_row_button'.
		deferred
		end
	
	apply_full_select_column_button_selected is
			-- Called by `select_actions' of `apply_full_select_column_button'.
		deferred
		end
	
	apply_text_row_button_selected is
			-- Called by `select_actions' of `apply_text_row_button'.
		deferred
		end
	
	apply_text_column_button_selected is
			-- Called by `select_actions' of `apply_text_column_button'.
		deferred
		end
	
	remove_item_button_selected is
			-- Called by `select_actions' of `remove_item_button'.
		deferred
		end
	

end -- class ITEM_TAB_IMP
