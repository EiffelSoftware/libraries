indexing

	description: 
		"EiffelVision combo box, gtk implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_COMBO_BOX_IMP
	
inherit
	EV_COMBO_BOX_I
		redefine
			interface
		end

	EV_TEXT_FIELD_IMP
		undefine
			pointer_over_widget,
			create_focus_in_actions,
			create_focus_out_actions,
			has_focus
		redefine
			initialize,
			make,
			interface,
			set_foreground_color,
			foreground_color_pointer,
			visual_widget,
			set_text,
			set_focus,
			has_focus,
			destroy
		end

	EV_LIST_ITEM_LIST_IMP
		undefine
			set_default_colors,
			visual_widget
		redefine
			select_callback,
			remove_i_th,
			gtk_reorder_child,
			initialize,
			make,
			select_item,
			selected,
			add_to_container,
			interface,
			set_foreground_color,
			foreground_color_pointer,
			visual_widget,
			set_focus,
			has_focus,
			destroy
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a combo-box.
		do
			base_make (an_interface)


			-- create of the gtk object.
			set_c_object (C.gtk_event_box_new)
			container_widget := C.gtk_combo_new
			C.gtk_widget_show (container_widget)
			C.gtk_container_add (c_object, container_widget)

			-- Pointer to the text we see.
			entry_widget := C.gtk_combo_struct_entry (container_widget)

			-- Pointer to the list of items.
			list_widget := C.gtk_combo_struct_list (container_widget)
			C.gtk_combo_disable_activate (container_widget)
			C.gtk_combo_set_use_arrows_always (container_widget, 1)
		--	gtk_widget_set_flags (c_object, C.GTK_CAN_FOCUS_ENUM)
			real_signal_connect (entry_widget, "key_press_event", ~on_key_event, ~key_event_translate)
			real_signal_connect (entry_widget, "key_release_event", ~on_key_event, ~key_event_translate)
			
			create timer.make_with_interval (0)
			timer.actions.extend (~launch_select_actions)
		end

	container_widget: POINTER

	initialize is
			-- Connect action sequences to signals.
		local
			temp_sig_id: INTEGER
		do
			initialize_pixmaps
			{EV_LIST_ITEM_LIST_IMP} Precursor

			--| We don't call EV_TEXT_FIELD_IMP Precursor as this only
			--| adds two extra ones to what ev_list_imp Precursor calls
			--| already.
			C.gtk_list_set_selection_mode (
				list_widget,
				C.GTK_SELECTION_SINGLE_ENUM
			)
			selection_mode_is_single := True
			temp_sig_id := c_signal_connect (visual_widget, eiffel_to_c ("focus-in-event"), agent attain_focus)
			temp_sig_id := c_signal_connect (visual_widget, eiffel_to_c ("focus-out-event"), agent lose_focus)

		end

	avoid_callback: BOOLEAN
		-- Flag used to avoid repeated emission of select signal from combo box.

	select_callback (n: INTEGER; an_item: POINTER) is
			-- Redefined to counter repeated select signal of combo box. 
		do
			if not avoid_callback then
			--	Precursor (n, an_item)
			 	triggering_item ?= eif_object_from_c (
					gtk_value_pointer (an_item)
				)
				timer.reset_count
				timer.set_interval (1)
				avoid_callback := True
			else
				avoid_callback := False
			end
		end

	visual_widget: POINTER is
		do
			Result := c_object
		end

feature -- Access

	select_item (an_index: INTEGER) is
			-- Give the item of the list at the one-base index.
		do
			if selection_mode_is_single then
				C.gtk_list_set_selection_mode (
					list_widget,
					C.GTK_SELECTION_BROWSE_ENUM
				)
				selection_mode_is_single := False
			end
			C.gtk_list_select_item (list_widget, an_index - 1)
		end

feature -- Status report

	has_focus: BOOLEAN is
			-- Does widget have the keyboard focus?
		do
			--| Shift to put bit in least significant place then take mod 2.
			Result := ((
				(C.gtk_object_struct_flags (entry_widget)
				// C.GTK_HAS_FOCUS_ENUM) \\ 2) 
			) = 1
		end

	rows: INTEGER is
		 	-- Number of lines.
		do
			Result := C.g_list_length (
				C.gtk_list_struct_children (list_widget)
			)
		end

	selected: BOOLEAN is
			-- Is at least one item selected?
		do
			Result := C.g_list_length (
				C.gtk_list_struct_selection (list_widget)
			).to_boolean
		end

feature -- Status setting

	set_text (a_text: STRING) is
			-- Assign `a_text' to `text'.
		do
			avoid_callback := True
			Precursor {EV_TEXT_FIELD_IMP} (a_text)
		end
	
	set_focus is
		do
			C.gtk_widget_grab_focus (entry_widget)
		end

	set_maximum_text_length (len: INTEGER) is
		do
			C.gtk_entry_set_max_length (entry_widget, len)
		end

	set_foreground_color (a_color: EV_COLOR) is
		do
			real_set_foreground_color (list_widget, a_color)
		end

feature {NONE} -- Implementation

	add_to_container (v: like item) is
			-- Add `v' to container.
		local
			imp: EV_LIST_ITEM_IMP
			temp_sig_id: INTEGER
		do
			imp ?= v.implementation
			C.gtk_combo_set_item_string (container_widget,
				imp.c_object,
				eiffel_to_c (imp.text)
			)
			C.gtk_container_add (list_widget, imp.c_object)
			imp.set_parent_imp (Current)
			temp_sig_id := c_signal_connect (
				imp.c_object,
				eiffel_to_c ("button-press-event"),
				~on_item_clicked
				)
		end

	remove_i_th (a_position: INTEGER) is
			-- Remove item at position `a_position'.
		local
			imp: EV_LIST_ITEM_IMP
		do
			if not selection_mode_is_single then
				C.gtk_list_set_selection_mode (
					list_widget,
					C.GTK_SELECTION_SINGLE_ENUM
				)
				selection_mode_is_single := True
			end
			imp ?= i_th (a_position).implementation
			Precursor (a_position)
			imp.set_parent_imp (Void)
			if count = 0 then
				set_text (Void)
			end
		end

	gtk_reorder_child (a_container, a_child: POINTER; an_index: INTEGER) is
			-- Reorder `a_child' to `an_index' in `c_object'.
			-- `a_container' is ignored.
		do
			C.gtk_box_reorder_child (container_widget,
				a_child,
				an_index - 1
			)
		end

	foreground_color_pointer: POINTER is
		do
			Result := C.gtk_style_struct_fg (
				C.gtk_widget_struct_style (list_widget)
			)
		end
		
	timer: EV_TIMEOUT
	
	triggering_item: EV_LIST_ITEM_IMP
	
	launch_select_actions is
			-- 
		do
			timer.set_interval (0)
			if triggering_item /= Void then
				call_select_actions (triggering_item)
				triggering_item := Void
			end
		end
	
	destroy is
			-- 
		do
			timer.destroy
			timer := Void
			triggering_item := Void
			Precursor
		end
		
	switch_to_single_mode_if_necessary is
			-- Change selection mode if the last selected item is deselected.
		do
			if not selection_mode_is_single then
				C.gtk_list_set_selection_mode (list_widget, C.Gtk_selection_single_enum)
				selection_mode_is_single := True
			end
		end
		
	switch_to_browse_mode_if_necessary is
			-- Change selection mode to browse mode if necessary.
		do
			if selection_mode_is_single then
				C.gtk_list_set_selection_mode (list_widget, C.Gtk_selection_browse_enum)
				selection_mode_is_single := False
			end
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_COMBO_BOX

end -- class EV_COMBO_BOX_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable  components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.38  2001/06/13 16:35:57  etienne
--| Improved item selection in combo boxes and lists.
--|
--| Revision 1.37  2001/06/07 23:08:07  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.16.4.21  2001/06/05 22:44:42  king
--| Using arrow keys at all times
--|
--| Revision 1.16.4.20  2001/05/18 18:16:34  king
--| Integrated updated focus change implementation
--|
--| Revision 1.16.4.19  2001/04/26 19:04:30  king
--| Commented out disable activate
--|
--| Revision 1.16.4.18  2001/02/08 02:03:03  andrew
--| Fixed has_focus. Now checks correct component for focus
--|
--| Revision 1.16.4.17  2001/01/15 20:33:51  andrew
--| Fixed set_focus
--|
--| Revision 1.16.4.16  2000/12/09 00:32:38  etienne
--| Corrected remove_ith to set_text to void on empty
--|
--| Revision 1.16.4.15  2000/12/06 23:43:28  etienne
--| (Etienne committing Ian changes: ) `set_text' modified so that it does not call select actions.
--|
--| Revision 1.16.4.14  2000/11/30 19:29:39  king
--| Connected key events to entry widget
--|
--| Revision 1.16.4.13  2000/09/06 23:18:47  king
--| Reviewed
--|
--| Revision 1.16.4.12  2000/08/28 21:49:49  king
--| Redefining foreground color features
--|
--| Revision 1.16.4.11  2000/08/28 18:11:36  king
--| Undefining visual_widget from list_item_list
--|
--| Revision 1.16.4.10  2000/08/28 18:02:01  king
--| Visual widget now c_object as combo has no direct gdkwindow
--|
--| Revision 1.16.4.9  2000/08/28 16:40:53  king
--| Removed event_widget undefinition
--|
--| Revision 1.16.4.8  2000/08/03 20:14:12  king
--| Removed signal connection
--|
--| Revision 1.16.4.7  2000/07/19 20:04:39  king
--| Removed redundant features
--|
--| Revision 1.16.4.6  2000/07/18 22:28:47  rogers
--| Initialize now calls initialize_pixmaps.
--|
--| Revision 1.16.4.5  2000/06/29 02:12:42  king
--| Redefined visual_widget
--|
--| Revision 1.16.4.4  2000/06/28 00:09:03  king
--| Undefining event_widget from list_item_list
--|
--| Revision 1.16.4.3  2000/06/15 00:38:24  king
--| Made c_object event_box as combo box has not associating gdk window
--|
--| Revision 1.16.4.2  2000/05/10 18:50:35  king
--| Integrated ev_list_item_list
--|
--| Revision 1.16.4.1  2000/05/03 19:08:50  oconnor
--| mergred from HEAD
--|
--| Revision 1.35  2000/04/20 18:07:41  oconnor
--| Removed default_translate where not needed in sognal connect calls.
--|
--| Revision 1.34  2000/04/20 16:32:18  king
--| Removed reference to redundant ev_children LL
--|
--| Revision 1.33  2000/04/19 20:45:35  oconnor
--| no more externals used
--|
--| Revision 1.32  2000/04/06 22:16:26  brendel
--| Improved implementation.
--|
--| Revision 1.31  2000/04/05 21:16:10  brendel
--| Merged changes from LIST_REFACTOR_BRANCH.
--|
--| Revision 1.30  2000/04/04 20:54:08  oconnor
--| updated signal connection for new marshaling scheme
--|
--| Revision 1.29  2000/03/31 19:10:57  king
--| Accounted for rename of pebble_over_widget
--|
--| Revision 1.28.2.1  2000/04/04 16:24:52  brendel
--| remove_item_from_position -> remove_i_th.
--|
--| Revision 1.28  2000/03/22 22:01:30  king
--| Undefined pebble_over_widget from text_field
--|
--| Revision 1.27  2000/03/15 18:29:50  king
--| Uncommented disable_activate external
--|
--| Revision 1.26  2000/03/08 22:27:38  king
--| Accounted for name change of set_combo_parent_imp
--|
--| Revision 1.25  2000/03/08 21:37:53  king
--| Removed useless redefinition of entry widget functions
--|
--| Revision 1.24  2000/03/02 23:58:05  king
--| Indented external function calls
--|
--| Revision 1.23  2000/03/01 18:05:52  king
--| Changed XX to FIXME
--|
--| Revision 1.22  2000/02/25 17:50:02  king
--| Now using real_connect_signal_to_actions
--|
--| Revision 1.21  2000/02/22 18:39:38  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.20  2000/02/17 02:18:41  oconnor
--| released
--|
--| Revision 1.19  2000/02/15 19:23:51  king
--| Tidied up code in select_region
--|
--| Revision 1.18  2000/02/14 20:38:35  oconnor
--| mergerd from HACK-O-RAMA
--|
--| Revision 1.16.6.15  2000/02/14 20:21:18  king
--| Connected signals to entry widget in initialize
--|
--| Revision 1.16.6.14  2000/02/14 17:17:22  king
--| Connected change and activate signals
--|
--| Revision 1.16.6.13  2000/02/12 00:26:11  king
--| Implemented gtk_reorder_child
--|
--| Revision 1.16.6.12  2000/02/11 18:25:26  king
--| Added entry widget pointer in EV_TEXT_FIELD_IMP to accomodate the fact that
--| combo box is not an entry widget
--|
--| Revision 1.16.6.11  2000/02/11 01:30:50  king
--| Added fixme to precursor of initialize
--|
--| Revision 1.16.6.10  2000/02/11 00:55:26  king
--| Implemented combo box to allow assertion of items
--|
--| Revision 1.16.6.9  2000/01/27 19:29:46  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.16.6.8  2000/01/18 19:33:41  king
--| Added initialize, removed redefinition of now defunct features
--|
--| Revision 1.16.6.7  2000/01/15 00:53:19  oconnor
--| renamed is_multiple_selection -> multiple_selection_enabled,
--| set_multiple_selection -> enable_multiple_selection &
--| set_single_selection -> disable_multiple_selection
--|
--| Revision 1.16.6.6  1999/12/13 20:02:38  oconnor
--| commented out old command stuff
--|
--| Revision 1.16.6.5  1999/12/04 18:59:20  oconnor
--| moved externals into EV_C_EXTERNALS, accessed through EV_ANY_IMP.C
--|
--| Revision 1.16.6.4  1999/12/03 07:48:11  oconnor
--| fixed gaggle of typos
--|
--| Revision 1.16.6.3  1999/12/01 20:27:50  oconnor
--| tweaks for new externals
--|
--| Revision 1.16.6.2  1999/11/30 23:14:20  oconnor
--| rename widget to c_object
--| redefine interface to be of mreo refined type
--|
--| Revision 1.16.6.1  1999/11/24 17:29:56  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.16.2.3  1999/11/17 01:53:04  oconnor
--| removed "child packing" hacks and obsolete _ref _unref wrappers
--|
--| Revision 1.16.2.2  1999/11/02 17:20:04  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
