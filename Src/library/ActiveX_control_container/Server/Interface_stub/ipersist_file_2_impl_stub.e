indexing
	description: "Implemented `IPersistFile_2' Interface."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	IPERSIST_FILE_2_IMPL_STUB

inherit
	IPERSIST_FILE_2_INTERFACE

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

	load (psz_file_name: STRING; dw_mode: INTEGER) is
			-- No description available.
			-- `psz_file_name' [in].  
			-- `dw_mode' [in].  
		do
			-- Put Implementation here.
		end

	save (psz_file_name: STRING; f_remember: INTEGER) is
			-- No description available.
			-- `psz_file_name' [in].  
			-- `f_remember' [in].  
		do
			-- Put Implementation here.
		end

	save_completed (psz_file_name: STRING) is
			-- No description available.
			-- `psz_file_name' [in].  
		do
			-- Put Implementation here.
		end

	get_cur_file (ppsz_file_name: CELL [STRING]) is
			-- No description available.
			-- `ppsz_file_name' [out].  
		do
			-- Put Implementation here.
		end

	create_item is
			-- Initialize `item'
		do
			item := ccom_create_item (Current)
		end

feature {NONE}  -- Externals

	ccom_create_item (eif_object: IPERSIST_FILE_2_IMPL_STUB): POINTER is
			-- Initialize `item'
		external
			"C++ [new ecom_control_library::IPersistFile_2_impl_stub %"ecom_control_library_IPersistFile_2_impl_stub_s.h%"](EIF_OBJECT)"
		end

end -- IPERSIST_FILE_2_IMPL_STUB

