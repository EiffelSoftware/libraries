indexing
	description: "Implemented `IOleContainer' Interface."
	date: "$Date$"
	revision: "$Revision$"

class
	IOLE_CONTAINER_IMPL

inherit
	IOLE_CONTAINER_INTERFACE

	OLE_CONTROL_PROXY

feature -- Basic Operations

	parse_display_name (pbc: IBIND_CTX_INTERFACE; psz_display_name: STRING; pch_eaten: INTEGER_REF; ppmk_out: CELL [IMONIKER_INTERFACE]) is
			-- No description available.
			-- `pbc' [in].  
			-- `psz_display_name' [in].  
			-- `pch_eaten' [out].  
			-- `ppmk_out' [out].  
		do
			-- Put Implementation here.
		end

	enum_objects (grf_flags: INTEGER; ppenum: CELL [IENUM_UNKNOWN_INTERFACE]) is
			-- No description available.
			-- `grf_flags' [in].  
			-- `ppenum' [out].  
		do
			-- Put Implementation here.
		end

	lock_container (f_lock: INTEGER) is
			-- No description available.
			-- `f_lock' [in].  
		do
			-- Put Implementation here.
		end


end -- IOLE_CONTAINER_IMPL

