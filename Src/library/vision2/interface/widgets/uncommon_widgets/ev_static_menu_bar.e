indexing
	description: "EiffelVision static menu bar. Implementation interface."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_STATIC_MENU_BAR

inherit
	EV_MENU_ITEM_CONTAINER 
		redefine
			implementation
		end

creation
	
	make
	
feature {NONE} -- Initialization
	
	make (par: EV_WINDOW) is         
			-- Create a menu widget with `par' as parent window.
		require
			parent_exists: not par.destroyed
		do
			!EV_STATIC_MENU_BAR_IMP!implementation.make (par)
--			implementation.set_interface (Current)
--			implementation.test_and_set_parent (par)
--			implementation.build
--			managed := par.manager
--			widget_make (par)
		end	

feature -- Access
	
	parent: EV_WIDGET is
			-- The parent of the Current widget
			-- If the widget is an EV_WINDOW without parent,
			-- this attribute will be `Void'
		require
			exists: not destroyed
		do
			Result := implementation.parent
		end
	
feature -- Status report

	destroyed: BOOLEAN is
			-- Is the current menu destroyed ?
		do
			Result := implementation.destroyed
		end

feature -- Status setting

	destroy is
			-- Destroy the actual static menu-bar.
		require
			exists: not destroyed
		do
			implementation.destroy
		end

feature {NONE} -- Implementation
	
	implementation: EV_STATIC_MENU_BAR_I	

end -- class EV_MENU_BAR

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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
--|---------------------------------------------------------------
