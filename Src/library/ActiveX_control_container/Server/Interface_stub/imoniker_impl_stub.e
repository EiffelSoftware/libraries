indexing
	description: "Implemented `IMoniker' Interface."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	IMONIKER_IMPL_STUB

inherit
	IMONIKER_INTERFACE

	ECOM_STUB

feature -- Basic Operations

	get_class_id (p_class_id: ECOM_GUID) is
			-- No description available.
			-- `p_class_id' [out].  
		do
			-- Put Implementation here.
		end

	is_dirty is
			-- No description available.
		do
			-- Put Implementation here.
		end

	load (pstm: ISTREAM_INTERFACE) is
			-- No description available.
			-- `pstm' [in].  
		do
			-- Put Implementation here.
		end

	save (pstm: ISTREAM_INTERFACE; f_clear_dirty: INTEGER) is
			-- No description available.
			-- `pstm' [in].  
			-- `f_clear_dirty' [in].  
		do
			-- Put Implementation here.
		end

	get_size_max (pcb_size: X_ULARGE_INTEGER_RECORD) is
			-- No description available.
			-- `pcb_size' [out].  
		do
			-- Put Implementation here.
		end

	remote_bind_to_object (pbc: IBIND_CTX_INTERFACE; pmk_to_left: IMONIKER_INTERFACE; riid_result: ECOM_GUID; ppv_result: CELL [ECOM_INTERFACE]) is
			-- No description available.
			-- `pbc' [in].  
			-- `pmk_to_left' [in].  
			-- `riid_result' [in].  
			-- `ppv_result' [out].  
		do
			-- Put Implementation here.
		end

	remote_bind_to_storage (pbc: IBIND_CTX_INTERFACE; pmk_to_left: IMONIKER_INTERFACE; riid: ECOM_GUID; ppv_obj: CELL [ECOM_INTERFACE]) is
			-- No description available.
			-- `pbc' [in].  
			-- `pmk_to_left' [in].  
			-- `riid' [in].  
			-- `ppv_obj' [out].  
		do
			-- Put Implementation here.
		end

	reduce (pbc: IBIND_CTX_INTERFACE; dw_reduce_how_far: INTEGER; ppmk_to_left: CELL [IMONIKER_INTERFACE]; ppmk_reduced: CELL [IMONIKER_INTERFACE]) is
			-- No description available.
			-- `pbc' [in].  
			-- `dw_reduce_how_far' [in].  
			-- `ppmk_to_left' [in, out].  
			-- `ppmk_reduced' [out].  
		do
			-- Put Implementation here.
		end

	compose_with (pmk_right: IMONIKER_INTERFACE; f_only_if_not_generic: INTEGER; ppmk_composite: CELL [IMONIKER_INTERFACE]) is
			-- No description available.
			-- `pmk_right' [in].  
			-- `f_only_if_not_generic' [in].  
			-- `ppmk_composite' [out].  
		do
			-- Put Implementation here.
		end

	enum (f_forward: INTEGER; ppenum_moniker: CELL [IENUM_MONIKER_INTERFACE]) is
			-- No description available.
			-- `f_forward' [in].  
			-- `ppenum_moniker' [out].  
		do
			-- Put Implementation here.
		end

	is_equal1 (pmk_other_moniker: IMONIKER_INTERFACE) is
			-- No description available.
			-- `pmk_other_moniker' [in].  
		do
			-- Put Implementation here.
		end

	hash (pdw_hash: INTEGER_REF) is
			-- No description available.
			-- `pdw_hash' [out].  
		do
			-- Put Implementation here.
		end

	is_running (pbc: IBIND_CTX_INTERFACE; pmk_to_left: IMONIKER_INTERFACE; pmk_newly_running: IMONIKER_INTERFACE) is
			-- No description available.
			-- `pbc' [in].  
			-- `pmk_to_left' [in].  
			-- `pmk_newly_running' [in].  
		do
			-- Put Implementation here.
		end

	get_time_of_last_change (pbc: IBIND_CTX_INTERFACE; pmk_to_left: IMONIKER_INTERFACE; pfiletime: X_FILETIME_RECORD) is
			-- No description available.
			-- `pbc' [in].  
			-- `pmk_to_left' [in].  
			-- `pfiletime' [out].  
		do
			-- Put Implementation here.
		end

	inverse (ppmk: CELL [IMONIKER_INTERFACE]) is
			-- No description available.
			-- `ppmk' [out].  
		do
			-- Put Implementation here.
		end

	common_prefix_with (pmk_other: IMONIKER_INTERFACE; ppmk_prefix: CELL [IMONIKER_INTERFACE]) is
			-- No description available.
			-- `pmk_other' [in].  
			-- `ppmk_prefix' [out].  
		do
			-- Put Implementation here.
		end

	relative_path_to (pmk_other: IMONIKER_INTERFACE; ppmk_rel_path: CELL [IMONIKER_INTERFACE]) is
			-- No description available.
			-- `pmk_other' [in].  
			-- `ppmk_rel_path' [out].  
		do
			-- Put Implementation here.
		end

	get_display_name (pbc: IBIND_CTX_INTERFACE; pmk_to_left: IMONIKER_INTERFACE; ppsz_display_name: CELL [STRING]) is
			-- No description available.
			-- `pbc' [in].  
			-- `pmk_to_left' [in].  
			-- `ppsz_display_name' [out].  
		do
			-- Put Implementation here.
		end

	parse_display_name (pbc: IBIND_CTX_INTERFACE; pmk_to_left: IMONIKER_INTERFACE; psz_display_name: STRING; pch_eaten: INTEGER_REF; ppmk_out: CELL [IMONIKER_INTERFACE]) is
			-- No description available.
			-- `pbc' [in].  
			-- `pmk_to_left' [in].  
			-- `psz_display_name' [in].  
			-- `pch_eaten' [out].  
			-- `ppmk_out' [out].  
		do
			-- Put Implementation here.
		end

	is_system_moniker (pdw_mksys: INTEGER_REF) is
			-- No description available.
			-- `pdw_mksys' [out].  
		do
			-- Put Implementation here.
		end

	create_item is
			-- Initialize `item'
		do
			item := ccom_create_item (Current)
		end

feature {NONE}  -- Externals

	ccom_create_item (eif_object: IMONIKER_IMPL_STUB): POINTER is
			-- Initialize `item'
		external
			"C++ [new ecom_control_library::IMoniker_impl_stub %"ecom_control_library_IMoniker_impl_stub_s.h%"](EIF_OBJECT)"
		end

end -- IMONIKER_IMPL_STUB

