indexing
	description: "Control interfaces. Help file: "
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	TAG_REM_STGMEDIUM_RECORD

inherit
	ECOM_STRUCTURE
		redefine
			make
		end

creation
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

	tymed: INTEGER is
			-- No description available.
		do
			Result := ccom_tag_rem_stgmedium_tymed (item)
		end

	dw_handle_type: INTEGER is
			-- No description available.
		do
			Result := ccom_tag_rem_stgmedium_dw_handle_type (item)
		end

	p_data: INTEGER is
			-- No description available.
		do
			Result := ccom_tag_rem_stgmedium_p_data (item)
		end

	p_unk_for_release: INTEGER is
			-- No description available.
		do
			Result := ccom_tag_rem_stgmedium_p_unk_for_release (item)
		end

	cb_data: INTEGER is
			-- No description available.
		do
			Result := ccom_tag_rem_stgmedium_cb_data (item)
		end

	data: CHARACTER_REF is
			-- No description available.
		do
			Result := ccom_tag_rem_stgmedium_data (item)
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size of structure
		do
			Result := c_size_of_tag_rem_stgmedium
		end

feature -- Basic Operations

	set_tymed (a_tymed: INTEGER) is
			-- Set `tymed' with `a_tymed'.
		do
			ccom_tag_rem_stgmedium_set_tymed (item, a_tymed)
		end

	set_dw_handle_type (a_dw_handle_type: INTEGER) is
			-- Set `dw_handle_type' with `a_dw_handle_type'.
		do
			ccom_tag_rem_stgmedium_set_dw_handle_type (item, a_dw_handle_type)
		end

	set_p_data (a_p_data: INTEGER) is
			-- Set `p_data' with `a_p_data'.
		do
			ccom_tag_rem_stgmedium_set_p_data (item, a_p_data)
		end

	set_p_unk_for_release (a_p_unk_for_release: INTEGER) is
			-- Set `p_unk_for_release' with `a_p_unk_for_release'.
		do
			ccom_tag_rem_stgmedium_set_p_unk_for_release (item, a_p_unk_for_release)
		end

	set_cb_data (a_cb_data: INTEGER) is
			-- Set `cb_data' with `a_cb_data'.
		do
			ccom_tag_rem_stgmedium_set_cb_data (item, a_cb_data)
		end

	set_data (a_data: CHARACTER_REF) is
			-- Set `data' with `a_data'.
		require
			non_void_a_data: a_data /= Void
		do
			ccom_tag_rem_stgmedium_set_data (item, a_data)
		end

feature {NONE}  -- Externals

	c_size_of_tag_rem_stgmedium: INTEGER is
			-- Size of structure
		external
			"C [macro %"ecom_control_library_tagRemSTGMEDIUM_s.h%"]"
		alias
			"sizeof(ecom_control_library::tagRemSTGMEDIUM)"
		end

	ccom_tag_rem_stgmedium_tymed (a_pointer: POINTER): INTEGER is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagRemSTGMEDIUM_s_impl.h%"](ecom_control_library::tagRemSTGMEDIUM *):EIF_INTEGER"
		end

	ccom_tag_rem_stgmedium_set_tymed (a_pointer: POINTER; arg2: INTEGER) is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagRemSTGMEDIUM_s_impl.h%"](ecom_control_library::tagRemSTGMEDIUM *, ULONG)"
		end

	ccom_tag_rem_stgmedium_dw_handle_type (a_pointer: POINTER): INTEGER is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagRemSTGMEDIUM_s_impl.h%"](ecom_control_library::tagRemSTGMEDIUM *):EIF_INTEGER"
		end

	ccom_tag_rem_stgmedium_set_dw_handle_type (a_pointer: POINTER; arg2: INTEGER) is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagRemSTGMEDIUM_s_impl.h%"](ecom_control_library::tagRemSTGMEDIUM *, ULONG)"
		end

	ccom_tag_rem_stgmedium_p_data (a_pointer: POINTER): INTEGER is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagRemSTGMEDIUM_s_impl.h%"](ecom_control_library::tagRemSTGMEDIUM *):EIF_INTEGER"
		end

	ccom_tag_rem_stgmedium_set_p_data (a_pointer: POINTER; arg2: INTEGER) is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagRemSTGMEDIUM_s_impl.h%"](ecom_control_library::tagRemSTGMEDIUM *, ULONG)"
		end

	ccom_tag_rem_stgmedium_p_unk_for_release (a_pointer: POINTER): INTEGER is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagRemSTGMEDIUM_s_impl.h%"](ecom_control_library::tagRemSTGMEDIUM *):EIF_INTEGER"
		end

	ccom_tag_rem_stgmedium_set_p_unk_for_release (a_pointer: POINTER; arg2: INTEGER) is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagRemSTGMEDIUM_s_impl.h%"](ecom_control_library::tagRemSTGMEDIUM *, ULONG)"
		end

	ccom_tag_rem_stgmedium_cb_data (a_pointer: POINTER): INTEGER is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagRemSTGMEDIUM_s_impl.h%"](ecom_control_library::tagRemSTGMEDIUM *):EIF_INTEGER"
		end

	ccom_tag_rem_stgmedium_set_cb_data (a_pointer: POINTER; arg2: INTEGER) is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagRemSTGMEDIUM_s_impl.h%"](ecom_control_library::tagRemSTGMEDIUM *, ULONG)"
		end

	ccom_tag_rem_stgmedium_data (a_pointer: POINTER): CHARACTER_REF is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagRemSTGMEDIUM_s_impl.h%"](ecom_control_library::tagRemSTGMEDIUM *):EIF_REFERENCE"
		end

	ccom_tag_rem_stgmedium_set_data (a_pointer: POINTER; arg2: CHARACTER_REF) is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagRemSTGMEDIUM_s_impl.h%"](ecom_control_library::tagRemSTGMEDIUM *, EIF_OBJECT)"
		end

end -- TAG_REM_STGMEDIUM_RECORD

