--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing 
	description: "EiffelVision password field, implementation interface"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PASSWORD_FIELD_IMP

inherit
	EV_PASSWORD_FIELD_I

	EV_TEXT_FIELD_IMP
		redefine
			default_style
		end
creation
	make,
	make_with_text

feature -- Access

	character: CHARACTER is
			-- Displayed character instead of the text.
		do
			Result := (cwin_send_message_result (item,
				Em_getpasswordchar, 0, 0)).ascii_char
		end

feature -- Element change

	set_character (char: CHARACTER) is
			-- Make `char' the new character displayed in the
			-- password field.
		do
			cwin_send_message (item, Em_setpasswordchar,
				char.code, 0)
		end

feature {NONE} -- Implementation

	default_style: INTEGER is
			-- We specified the Es_autovscroll style otherwise
			-- the system keep on beeping when we press the
			-- return key.
		do
			Result := {EV_TEXT_FIELD_IMP} Precursor + Es_password
		end

end -- class EV_PASSWORD_FIELD_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.3  2000/02/14 11:40:44  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.2.10.2  2000/01/27 19:30:28  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.2.10.1  1999/11/24 17:30:33  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.2.6.2  1999/11/02 17:20:09  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
