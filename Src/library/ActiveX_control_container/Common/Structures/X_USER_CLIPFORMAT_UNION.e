indexing
	description: "Control interfaces. Help file: "
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	X_USER_CLIPFORMAT_UNION

inherit
	ECOM_STRUCTURE
		redefine
			make
		end

create
	make,
	make_from_pointer

feature {NONE}  -- Initialization

	make is
			-- Make.
		do
			Precursor {ECOM_STRUCTURE}
		end

	make_from_pointer (a_pointer: POINTER) is
			-- Make from pointer.
		do
			make_by_pointer (a_pointer)
		end

feature -- Access

	pwsz_name: STRING is
			-- No description available.
		do
			Result := ccom_x__midl_iwin_types_0001_pwsz_name (item)
		end

	dw_value: INTEGER is
			-- No description available.
		do
			Result := ccom_x__midl_iwin_types_0001_dw_value (item)
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size of structure
		do
			Result := c_size_of_x__midl_iwin_types_0001
		end

feature -- Basic Operations

	set_pwsz_name (a_pwsz_name: STRING) is
			-- Set `pwsz_name' with `a_pwsz_name'.
		do
			ccom_x__midl_iwin_types_0001_set_pwsz_name (item, a_pwsz_name)
		end

	set_dw_value (a_dw_value: INTEGER) is
			-- Set `dw_value' with `a_dw_value'.
		do
			ccom_x__midl_iwin_types_0001_set_dw_value (item, a_dw_value)
		end

feature {NONE}  -- Externals

	c_size_of_x__midl_iwin_types_0001: INTEGER is
			-- Size of structure
		external
			"C [macro %"ecom_control_library___MIDL_IWinTypes_0001_s.h%"]"
		alias
			"sizeof(ecom_control_library::__MIDL_IWinTypes_0001)"
		end

	ccom_x__midl_iwin_types_0001_pwsz_name (a_pointer: POINTER): STRING is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library___MIDL_IWinTypes_0001_s_impl.h%"](ecom_control_library::__MIDL_IWinTypes_0001 *):EIF_REFERENCE"
		end

	ccom_x__midl_iwin_types_0001_set_pwsz_name (a_pointer: POINTER; arg2: STRING) is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library___MIDL_IWinTypes_0001_s_impl.h%"](ecom_control_library::__MIDL_IWinTypes_0001 *, EIF_OBJECT)"
		end

	ccom_x__midl_iwin_types_0001_dw_value (a_pointer: POINTER): INTEGER is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library___MIDL_IWinTypes_0001_s_impl.h%"](ecom_control_library::__MIDL_IWinTypes_0001 *):EIF_INTEGER"
		end

	ccom_x__midl_iwin_types_0001_set_dw_value (a_pointer: POINTER; arg2: INTEGER) is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library___MIDL_IWinTypes_0001_s_impl.h%"](ecom_control_library::__MIDL_IWinTypes_0001 *, ULONG)"
		end

end -- X_USER_CLIPFORMAT_UNION

