indexing
	description: "Base for dialogs to edit properties."
	date: "$Date$"
	revision: "$Revision$"

class
	PROPERTY_DIALOG [G]

inherit
	EV_DIALOG
		export
			{NONE} data, set_data
		redefine
			initialize
		end

	PROPERTY_GRID_LAYOUT
		undefine
			default_create,
			copy
		end

create
	default_create,
	make_with_title

feature {NONE} -- Initialization

	initialize is
			-- Initialize.
		local
			vb: EV_VERTICAL_BOX
			hb1, hb: EV_HORIZONTAL_BOX
			cl: EV_CELL
		do
			create data_change_actions.make (1)

			Precursor {EV_DIALOG}
			set_size (dialog_width, dialog_height)
			create hb1
			extend (hb1)
			append_margin (hb1)
			create vb
			hb1.extend (vb)
			append_margin (vb)
			create element_container
			vb.extend (element_container)
			append_small_margin (vb)

			create hb
			vb.extend (hb)
			vb.disable_item_expand (hb)
			create cl
			hb.extend (cl)
			create ok_button.make_with_text_and_action ("Ok", agent on_ok)
			hb.extend (ok_button)
			hb.disable_item_expand (ok_button)
			ok_button.set_minimum_width (button_width)
			create cancel_button.make_with_text_and_action ("Cancel", agent on_cancel)
			hb.extend (cancel_button)
			hb.disable_item_expand (cancel_button)
			cancel_button.set_minimum_width (button_width)

			append_margin (vb)
			append_margin (hb1)

			set_default_cancel_button (cancel_button)
		end

feature -- Access

	is_ok: BOOLEAN
			-- Did the dialog close with an ok?

	value: G
			-- Value.

feature -- Update

	set_value (a_value: like value) is
			-- Set value to change.
		local
			l_changed: BOOLEAN
		do
			l_changed := not equal (value, a_value)
			value := a_value
			if l_changed then
				data_change_actions.do_all (agent {PROCEDURE [ANY, TUPLE [like value]]}.call ([value]))
			end
		end

feature -- Events

	data_change_actions: ARRAYED_LIST [PROCEDURE [ANY, TUPLE [like value]]]
			-- Called if `value' changes.


feature {NONE} -- GUI elements

	element_container: EV_VERTICAL_BOX
			-- Container to add new elements.

	cancel_button: EV_BUTTON
			-- Cancel button.

	ok_button: EV_BUTTON
			-- Ok Button.

feature {NONE} -- Agents

	on_ok is
			-- Ok was pressed.
		require
			is_initialized: is_initialized
		do
			is_ok := True
			hide
		end

	on_cancel is
			-- Cancel was pressed.
		require
			is_initialized: is_initialized
		do
			is_ok := False
			hide
		end

feature {NONE} -- Layout constants

	dialog_width: INTEGER is 400
	dialog_height: INTEGER is 400

invariant
	elements: is_initialized implies ok_button /= Void and cancel_button /= Void
	events: is_initialized implies data_change_actions /= Void

end
