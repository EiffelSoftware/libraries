indexing
	description: "Implemented `IOleInPlaceObjectWindowless' Interface."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	IOLE_IN_PLACE_OBJECT_WINDOWLESS_IMPL_PROXY

inherit
	IOLE_IN_PLACE_OBJECT_WINDOWLESS_INTERFACE

	ECOM_QUERIABLE

creation
	make_from_other,
	make_from_pointer

feature {NONE}  -- Initialization

	make_from_pointer (cpp_obj: POINTER) is
			-- Make from pointer
		do
			initializer := ccom_create_iole_in_place_object_windowless_impl_proxy_from_pointer(cpp_obj)
			item := ccom_item (initializer)
		end

feature -- Basic Operations

	get_window (phwnd: CELL [POINTER]) is
			-- No description available.
			-- `phwnd' [out].  
		do
			ccom_get_window (initializer, phwnd)
		end

	context_sensitive_help (f_enter_mode: INTEGER) is
			-- No description available.
			-- `f_enter_mode' [in].  
		do
			ccom_context_sensitive_help (initializer, f_enter_mode)
		end

	in_place_deactivate is
			-- No description available.
		do
			ccom_in_place_deactivate (initializer)
		end

	uideactivate is
			-- No description available.
		do
			ccom_uideactivate (initializer)
		end

	set_object_rects (lprc_pos_rect: TAG_RECT_RECORD; lprc_clip_rect: TAG_RECT_RECORD) is
			-- No description available.
			-- `lprc_pos_rect' [in].  
			-- `lprc_clip_rect' [in].  
		do
			ccom_set_object_rects (initializer, lprc_pos_rect.item, lprc_clip_rect.item)
		end

	reactivate_and_undo is
			-- No description available.
		do
			ccom_reactivate_and_undo (initializer)
		end

	on_window_message (msg: INTEGER; w_param: INTEGER; l_param: INTEGER; pl_result: INTEGER_REF) is
			-- No description available.
			-- `msg' [in].  
			-- `w_param' [in].  
			-- `l_param' [in].  
			-- `pl_result' [out].  
		do
			ccom_on_window_message (initializer, msg, w_param, l_param, pl_result)
		end

	get_drop_target (pp_drop_target: CELL [IDROP_TARGET_INTERFACE]) is
			-- No description available.
			-- `pp_drop_target' [out].  
		do
			ccom_get_drop_target (initializer, pp_drop_target)
		end

feature {NONE}  -- Implementation

	delete_wrapper is
			-- Delete wrapper
		do
			ccom_delete_iole_in_place_object_windowless_impl_proxy(initializer)
		end

feature {NONE}  -- Externals

	ccom_get_window (cpp_obj: POINTER; phwnd: CELL [POINTER]) is
			-- No description available.
		external
			"C++ [ecom_control_library::IOleInPlaceObjectWindowless_impl_proxy %"ecom_control_library_IOleInPlaceObjectWindowless_impl_proxy_s.h%"](EIF_OBJECT)"
		end

	ccom_context_sensitive_help (cpp_obj: POINTER; f_enter_mode: INTEGER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IOleInPlaceObjectWindowless_impl_proxy %"ecom_control_library_IOleInPlaceObjectWindowless_impl_proxy_s.h%"](EIF_INTEGER)"
		end

	ccom_in_place_deactivate (cpp_obj: POINTER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IOleInPlaceObjectWindowless_impl_proxy %"ecom_control_library_IOleInPlaceObjectWindowless_impl_proxy_s.h%"]()"
		end

	ccom_uideactivate (cpp_obj: POINTER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IOleInPlaceObjectWindowless_impl_proxy %"ecom_control_library_IOleInPlaceObjectWindowless_impl_proxy_s.h%"]()"
		end

	ccom_set_object_rects (cpp_obj: POINTER; lprc_pos_rect: POINTER; lprc_clip_rect: POINTER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IOleInPlaceObjectWindowless_impl_proxy %"ecom_control_library_IOleInPlaceObjectWindowless_impl_proxy_s.h%"](ecom_control_library::tagRECT *,ecom_control_library::tagRECT *)"
		end

	ccom_reactivate_and_undo (cpp_obj: POINTER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IOleInPlaceObjectWindowless_impl_proxy %"ecom_control_library_IOleInPlaceObjectWindowless_impl_proxy_s.h%"]()"
		end

	ccom_on_window_message (cpp_obj: POINTER; msg: INTEGER; w_param: INTEGER; l_param: INTEGER; pl_result: INTEGER_REF) is
			-- No description available.
		external
			"C++ [ecom_control_library::IOleInPlaceObjectWindowless_impl_proxy %"ecom_control_library_IOleInPlaceObjectWindowless_impl_proxy_s.h%"](EIF_INTEGER,EIF_INTEGER,EIF_INTEGER,EIF_OBJECT)"
		end

	ccom_get_drop_target (cpp_obj: POINTER; pp_drop_target: CELL [IDROP_TARGET_INTERFACE]) is
			-- No description available.
		external
			"C++ [ecom_control_library::IOleInPlaceObjectWindowless_impl_proxy %"ecom_control_library_IOleInPlaceObjectWindowless_impl_proxy_s.h%"](EIF_OBJECT)"
		end

	ccom_delete_iole_in_place_object_windowless_impl_proxy (a_pointer: POINTER) is
			-- Release resource
		external
			"C++ [delete ecom_control_library::IOleInPlaceObjectWindowless_impl_proxy %"ecom_control_library_IOleInPlaceObjectWindowless_impl_proxy_s.h%"]()"
		end

	ccom_create_iole_in_place_object_windowless_impl_proxy_from_pointer (a_pointer: POINTER): POINTER is
			-- Create from pointer
		external
			"C++ [new ecom_control_library::IOleInPlaceObjectWindowless_impl_proxy %"ecom_control_library_IOleInPlaceObjectWindowless_impl_proxy_s.h%"](IUnknown *)"
		end

	ccom_item (cpp_obj: POINTER): POINTER is
			-- Item
		external
			"C++ [ecom_control_library::IOleInPlaceObjectWindowless_impl_proxy %"ecom_control_library_IOleInPlaceObjectWindowless_impl_proxy_s.h%"]():EIF_POINTER"
		end

end -- IOLE_IN_PLACE_OBJECT_WINDOWLESS_IMPL_PROXY

