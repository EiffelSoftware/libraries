indexing
	description: "Objects that represent an EV_TITLED_WINDOW.%
		%The original version of this class was generated by EiffelBuild."
	date: "$Date$"
	revision: "$Revision$"

class
	SELECTION_TAB

inherit
	SELECTION_TAB_IMP

	GRID_ACCESSOR
		undefine
			default_create, copy, is_equal
		end


feature {NONE} -- Initialization

	user_initialization is
			-- Called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
			item_finder.set_prompt ("Item Finder : ")
			item_finder.motion_actions.extend (agent finder_motion)
		end

feature {NONE} -- Implementation

	selection_on_click_selected is
			-- Called by `select_actions' of `selection_on_click'.
		do
			if selection_on_click.is_selected then
				grid.enable_selection_on_click
			else
				grid.disable_selection_on_click
			end
		end

	select_item_button_selected is
			-- Called by `select_actions' of `select_item_button'.
		local
			warning_dialog: EV_WARNING_DIALOG
		do
			if select_item_x_spin_button.value >= 1 and select_item_x_spin_button.value <= grid.column_count and 
			select_item_y_spin_button.value >= 1 and select_item_y_spin_button.value <= grid.row_count then
				grid.item (select_item_x_spin_button.value, select_item_y_spin_button.value).enable_select
			else
				create warning_dialog.make_with_text ("Unable to select item as you have not entered a valid coordinate.")
				warning_dialog.show_modal_to_window (main_window)
			end
		end
		
	selected_items_button_selected is
			-- Called by `select_actions' of `selected_items_button'.
		local
			show_selection_dialog: SHOW_SELECTION_DIALOG
			selected_items: ARRAYED_LIST [EV_GRID_ITEM]
			selected_item_texts: ARRAYED_LIST [STRING]
			l_string: STRING
			current_item: EV_GRID_ITEM
			grid_label_item: EV_GRID_LABEL_ITEM
		do
			selected_items := grid.selected_items
			create selected_item_texts.make (selected_items.count)
			from
				selected_items.start
			until
				selected_items.off
			loop
				current_item := selected_items.item
				l_string := "Item " + current_item.column.index.out + ", " + current_item.row.index.out
				grid_label_item ?= current_item
				if grid_label_item /= Void then
					l_string.append ("      text : " + grid_label_item.text.out)
				end
				selected_item_texts.extend (l_string)
				selected_items.forth
			end
			
			create show_selection_dialog
			show_selection_dialog.populate (selected_item_texts)
			show_selection_dialog.set_title ("Selected Items")
			show_selection_dialog.show_modal_to_window (main_window)
		end
	
	selected_rows_button_selected is
			-- Called by `select_actions' of `selected_rows_button'.
		local
			show_selection_dialog: SHOW_SELECTION_DIALOG
			selected_rows: ARRAYED_LIST [EV_GRID_ROW]
			selected_row_texts: ARRAYED_LIST [STRING]
			l_string: STRING
			current_row: EV_GRID_ROW
		do
			selected_rows := grid.selected_rows
			create selected_row_texts.make (selected_rows.count)
			from
				selected_rows.start
			until
				selected_rows.off
			loop
				current_row := selected_rows.item
				l_string := "Row " + current_row.index.out
				selected_row_texts.extend (l_string)
				selected_rows.forth
			end
			
			create show_selection_dialog
			show_selection_dialog.populate (selected_row_texts)
			show_selection_dialog.set_title ("Selected Rows")
			show_selection_dialog.show_modal_to_window (main_window)
		end

	clear_selection_button_selected is
			-- Called by `select_actions' of `clear_selection_button'.
		do
			grid.remove_selection
		end

	finder_motion (an_item: EV_GRID_ITEM) is
			--
		do
			if an_item /= Void then
				select_row_button.enable_sensitive
				select_item_button.enable_sensitive
				select_column_button.enable_sensitive
				select_item_x_spin_button.change_actions.block
				select_item_x_spin_button.set_value (an_item.column.index)
				select_item_x_spin_button.change_actions.resume
				select_item_y_spin_button.change_actions.block
				select_item_y_spin_button.set_value (an_item.row.index)
				select_item_y_spin_button.change_actions.resume
			else
				select_row_button.disable_sensitive
				select_item_button.disable_sensitive
				select_column_button.disable_sensitive
			end
		end

	item_x_position_changed (a_value: INTEGER) is
			-- Called by `change_actions' of `select_item_x_spin_button'.
		do
			finder_motion (grid.item (grid.column_count, select_item_y_spin_button.value))
		end

	item_y_position_changed (a_value: INTEGER) is
			-- Called by `change_actions' of `select_item_y_spin_button'.
		do
			finder_motion (grid.item (select_item_x_spin_button.value, grid.row_count))
		end
		
	select_row_button_selected is
			-- Called by `select_actions' of `select_row_button'.
		local
			warning_dialog: EV_WARNING_DIALOG
		do
			if select_item_y_spin_button.value >= 1 and select_item_y_spin_button.value <= grid.row_count then
				grid.select_row (select_item_y_spin_button.value)
			else
				create warning_dialog.make_with_text ("Unable to select row as you have not entered a valid row index.")
				warning_dialog.show_modal_to_window (main_window)
			end
		end

	select_column_button_selected is
			-- Called by `select_actions' of `select_column_button'.
		local
			warning_dialog: EV_WARNING_DIALOG
		do
			if select_item_x_spin_button.value >= 1 and select_item_x_spin_button.value <= grid.column_count then
				grid.select_column (select_item_x_spin_button.value)
			else
				create warning_dialog.make_with_text ("Unable to select column as you have not entered a valid column index.")
				warning_dialog.show_modal_to_window (main_window)
			end
		end

	single_item_selection_button_selected is
			-- Called by `select_actions' of `single_item_selection_button'.
		do
			grid.enable_single_item_selection
		end

	single_row_selection_button_selected is
			-- Called by `select_actions' of `single_row_selection_button'.
		do
			grid.enable_single_row_selection
		end

	multiple_item_selection_button_selected is
			-- Called by `select_actions' of `multiple_item_selection_button'.
		do
			grid.enable_multiple_item_selection
		end

	multiple_row_selection_button_selected is
			-- Called by `select_actions' of `multiple_row_selection_button'.
		do
			grid.enable_multiple_row_selection
		end

	always_selected_button_selected is
			-- Called by `select_actions' of `always_selected_button'.
		do
			if always_selected_button.is_selected then
				grid.enable_always_selected
			else
				grid.disable_always_selected
			end
		end

end -- class SELECTION_TAB

