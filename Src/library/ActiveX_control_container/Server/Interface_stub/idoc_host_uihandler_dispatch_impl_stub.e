indexing
	description: "Implemented `IDocHostUIHandlerDispatch' Interface."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	IDOC_HOST_UIHANDLER_DISPATCH_IMPL_STUB

inherit
	IDOC_HOST_UIHANDLER_DISPATCH_INTERFACE

	ECOM_STUB

feature -- Basic Operations

	show_context_menu (dw_id: INTEGER; x: INTEGER; y: INTEGER; pcmdt_reserved: ECOM_INTERFACE; pdisp_reserved: ECOM_INTERFACE): ECOM_HRESULT is
			-- No description available.
			-- `dw_id' [in].  
			-- `x' [in].  
			-- `y' [in].  
			-- `pcmdt_reserved' [in].  
			-- `pdisp_reserved' [in].  
		do
			-- Put Implementation here.
		end

	get_host_info (pdw_flags: INTEGER_REF; pdw_double_click: INTEGER_REF) is
			-- No description available.
			-- `pdw_flags' [in, out].  
			-- `pdw_double_click' [in, out].  
		do
			-- Put Implementation here.
		end

	show_ui (dw_id: INTEGER; p_active_object: ECOM_INTERFACE; p_command_target: ECOM_INTERFACE; p_frame: ECOM_INTERFACE; p_doc: ECOM_INTERFACE): ECOM_HRESULT is
			-- No description available.
			-- `dw_id' [in].  
			-- `p_active_object' [in].  
			-- `p_command_target' [in].  
			-- `p_frame' [in].  
			-- `p_doc' [in].  
		do
			-- Put Implementation here.
		end

	hide_ui is
			-- No description available.
		do
			-- Put Implementation here.
		end

	update_ui is
			-- No description available.
		do
			-- Put Implementation here.
		end

	enable_modeless (f_enable: BOOLEAN) is
			-- No description available.
			-- `f_enable' [in].  
		do
			-- Put Implementation here.
		end

	on_doc_window_activate (f_activate: BOOLEAN) is
			-- No description available.
			-- `f_activate' [in].  
		do
			-- Put Implementation here.
		end

	on_frame_window_activate (f_activate: BOOLEAN) is
			-- No description available.
			-- `f_activate' [in].  
		do
			-- Put Implementation here.
		end

	resize_border (left: INTEGER; top: INTEGER; right: INTEGER; bottom: INTEGER; p_uiwindow: ECOM_INTERFACE; f_frame_window: BOOLEAN) is
			-- No description available.
			-- `left' [in].  
			-- `top' [in].  
			-- `right' [in].  
			-- `bottom' [in].  
			-- `p_uiwindow' [in].  
			-- `f_frame_window' [in].  
		do
			-- Put Implementation here.
		end

	translate_accelerator (h_wnd: INTEGER; n_message: INTEGER; w_param: INTEGER; l_param: INTEGER; bstr_guid_cmd_group: STRING; n_cmd_id: INTEGER): ECOM_HRESULT is
			-- No description available.
			-- `h_wnd' [in].  
			-- `n_message' [in].  
			-- `w_param' [in].  
			-- `l_param' [in].  
			-- `bstr_guid_cmd_group' [in].  
			-- `n_cmd_id' [in].  
		do
			-- Put Implementation here.
		end

	get_option_key_path (pbstr_key: CELL [STRING]; dw: INTEGER) is
			-- No description available.
			-- `pbstr_key' [out].  
			-- `dw' [in].  
		do
			-- Put Implementation here.
		end

	get_drop_target (p_drop_target: ECOM_INTERFACE; pp_drop_target: CELL [ECOM_INTERFACE]) is
			-- No description available.
			-- `p_drop_target' [in].  
			-- `pp_drop_target' [out].  
		do
			-- Put Implementation here.
		end

	get_external (pp_dispatch: CELL [ECOM_INTERFACE]) is
			-- No description available.
			-- `pp_dispatch' [out].  
		do
			-- Put Implementation here.
		end

	translate_url (dw_translate: INTEGER; bstr_urlin: STRING; pbstr_urlout: CELL [STRING]) is
			-- No description available.
			-- `dw_translate' [in].  
			-- `bstr_urlin' [in].  
			-- `pbstr_urlout' [out].  
		do
			-- Put Implementation here.
		end

	filter_data_object (p_do: ECOM_INTERFACE; pp_doret: CELL [ECOM_INTERFACE]) is
			-- No description available.
			-- `p_do' [in].  
			-- `pp_doret' [out].  
		do
			-- Put Implementation here.
		end

	create_item is
			-- Initialize `item'
		do
			item := ccom_create_item (Current)
		end

feature {NONE}  -- Externals

	ccom_create_item (eif_object: IDOC_HOST_UIHANDLER_DISPATCH_IMPL_STUB): POINTER is
			-- Initialize `item'
		external
			"C++ [new ecom_control_library::IDocHostUIHandlerDispatch_impl_stub %"ecom_control_library_IDocHostUIHandlerDispatch_impl_stub_s.h%"](EIF_OBJECT)"
		end

end -- IDOC_HOST_UIHANDLER_DISPATCH_IMPL_STUB

