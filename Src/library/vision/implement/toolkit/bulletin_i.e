indexing

	description: "General bulletin implementation";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	BULLETIN_I 

inherit

	MANAGER_I

feature -- Status setting
	
	set_default_position (flag: BOOLEAN) is
			-- Set default position.
		require
			valid_flag: flag /= Void;
		deferred
		end;

	allow_recompute_size is
			-- Allow Current bulletin to recompute its size
			-- according to its children.
		deferred
		end;

	forbid_recompute_size is
			-- Forbid Current bulletin to recompute its size
			-- according to its children.
		deferred
		end;

	circulate_up is
			-- Circulate the children of the bulletin up
		deferred
		end;

	circulate_down is
			--circulate the children of the bulletin down
		deferred
		end;

	restack_children (a_stackable_array: ARRAY [STACKABLE]) is
			-- Stack the children of the bulletin in the 
			-- order that they are in the array.
			-- Each item in the argument array must have the same
			--parent
		deferred
		end;

end -- class BULLETIN_I

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------

