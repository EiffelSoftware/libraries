indexing
	description: "Implemented `IDropSource' Interface."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	IDROP_SOURCE_IMPL_PROXY

inherit
	IDROP_SOURCE_INTERFACE

	ECOM_QUERIABLE

creation
	make_from_other,
	make_from_pointer

feature {NONE}  -- Initialization

	make_from_pointer (cpp_obj: POINTER) is
			-- Make from pointer
		do
			initializer := ccom_create_idrop_source_impl_proxy_from_pointer(cpp_obj)
			item := ccom_item (initializer)
		end

feature -- Basic Operations

	query_continue_drag (f_escape_pressed: INTEGER; grf_key_state: INTEGER) is
			-- No description available.
			-- `f_escape_pressed' [in].  
			-- `grf_key_state' [in].  
		do
			ccom_query_continue_drag (initializer, f_escape_pressed, grf_key_state)
		end

	give_feedback (dw_effect: INTEGER) is
			-- No description available.
			-- `dw_effect' [in].  
		do
			ccom_give_feedback (initializer, dw_effect)
		end

feature {NONE}  -- Implementation

	delete_wrapper is
			-- Delete wrapper
		do
			ccom_delete_idrop_source_impl_proxy(initializer)
		end

feature {NONE}  -- Externals

	ccom_query_continue_drag (cpp_obj: POINTER; f_escape_pressed: INTEGER; grf_key_state: INTEGER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IDropSource_impl_proxy %"ecom_control_library_IDropSource_impl_proxy_s.h%"](EIF_INTEGER,EIF_INTEGER)"
		end

	ccom_give_feedback (cpp_obj: POINTER; dw_effect: INTEGER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IDropSource_impl_proxy %"ecom_control_library_IDropSource_impl_proxy_s.h%"](EIF_INTEGER)"
		end

	ccom_delete_idrop_source_impl_proxy (a_pointer: POINTER) is
			-- Release resource
		external
			"C++ [delete ecom_control_library::IDropSource_impl_proxy %"ecom_control_library_IDropSource_impl_proxy_s.h%"]()"
		end

	ccom_create_idrop_source_impl_proxy_from_pointer (a_pointer: POINTER): POINTER is
			-- Create from pointer
		external
			"C++ [new ecom_control_library::IDropSource_impl_proxy %"ecom_control_library_IDropSource_impl_proxy_s.h%"](IUnknown *)"
		end

	ccom_item (cpp_obj: POINTER): POINTER is
			-- Item
		external
			"C++ [ecom_control_library::IDropSource_impl_proxy %"ecom_control_library_IDropSource_impl_proxy_s.h%"]():EIF_POINTER"
		end

end -- IDROP_SOURCE_IMPL_PROXY

