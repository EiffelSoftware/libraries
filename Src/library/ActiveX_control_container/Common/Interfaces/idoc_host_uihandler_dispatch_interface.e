indexing
	description: "IDocHostUIHandlerDispatch Interface Control interfaces. Help file: "
	Note: "Automatically generated by the EiffelCOM Wizard."

deferred class
	IDOC_HOST_UIHANDLER_DISPATCH_INTERFACE

inherit
	ECOM_INTERFACE

feature -- Status Report

	show_context_menu_user_precondition (dw_id: INTEGER; x: INTEGER; y: INTEGER; pcmdt_reserved: ECOM_INTERFACE; pdisp_reserved: ECOM_INTERFACE): BOOLEAN is
			-- User-defined preconditions for `show_context_menu'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	get_host_info_user_precondition (pdw_flags: INTEGER_REF; pdw_double_click: INTEGER_REF): BOOLEAN is
			-- User-defined preconditions for `get_host_info'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	show_ui_user_precondition (dw_id: INTEGER; p_active_object: ECOM_INTERFACE; p_command_target: ECOM_INTERFACE; p_frame: ECOM_INTERFACE; p_doc: ECOM_INTERFACE): BOOLEAN is
			-- User-defined preconditions for `show_ui'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	hide_ui_user_precondition: BOOLEAN is
			-- User-defined preconditions for `hide_ui'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	update_ui_user_precondition: BOOLEAN is
			-- User-defined preconditions for `update_ui'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	enable_modeless_user_precondition (f_enable: BOOLEAN): BOOLEAN is
			-- User-defined preconditions for `enable_modeless'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	on_doc_window_activate_user_precondition (f_activate: BOOLEAN): BOOLEAN is
			-- User-defined preconditions for `on_doc_window_activate'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	on_frame_window_activate_user_precondition (f_activate: BOOLEAN): BOOLEAN is
			-- User-defined preconditions for `on_frame_window_activate'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	resize_border_user_precondition (left: INTEGER; top: INTEGER; right: INTEGER; bottom: INTEGER; p_uiwindow: ECOM_INTERFACE; f_frame_window: BOOLEAN): BOOLEAN is
			-- User-defined preconditions for `resize_border'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	translate_accelerator_user_precondition (h_wnd: INTEGER; n_message: INTEGER; w_param: INTEGER; l_param: INTEGER; bstr_guid_cmd_group: STRING; n_cmd_id: INTEGER): BOOLEAN is
			-- User-defined preconditions for `translate_accelerator'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	get_option_key_path_user_precondition (pbstr_key: CELL [STRING]; dw: INTEGER): BOOLEAN is
			-- User-defined preconditions for `get_option_key_path'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	get_drop_target_user_precondition (p_drop_target: ECOM_INTERFACE; pp_drop_target: CELL [ECOM_INTERFACE]): BOOLEAN is
			-- User-defined preconditions for `get_drop_target'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	get_external_user_precondition (pp_dispatch: CELL [ECOM_INTERFACE]): BOOLEAN is
			-- User-defined preconditions for `get_external'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	translate_url_user_precondition (dw_translate: INTEGER; bstr_urlin: STRING; pbstr_urlout: CELL [STRING]): BOOLEAN is
			-- User-defined preconditions for `translate_url'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	filter_data_object_user_precondition (p_do: ECOM_INTERFACE; pp_doret: CELL [ECOM_INTERFACE]): BOOLEAN is
			-- User-defined preconditions for `filter_data_object'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

feature -- Basic Operations

	show_context_menu (dw_id: INTEGER; x: INTEGER; y: INTEGER; pcmdt_reserved: ECOM_INTERFACE; pdisp_reserved: ECOM_INTERFACE): ECOM_HRESULT is
			-- No description available.
			-- `dw_id' [in].  
			-- `x' [in].  
			-- `y' [in].  
			-- `pcmdt_reserved' [in].  
			-- `pdisp_reserved' [in].  
		require
			show_context_menu_user_precondition: show_context_menu_user_precondition (dw_id, x, y, pcmdt_reserved, pdisp_reserved)
		deferred

		end

	get_host_info (pdw_flags: INTEGER_REF; pdw_double_click: INTEGER_REF) is
			-- No description available.
			-- `pdw_flags' [in, out].  
			-- `pdw_double_click' [in, out].  
		require
			non_void_pdw_flags: pdw_flags /= Void
			non_void_pdw_double_click: pdw_double_click /= Void
			get_host_info_user_precondition: get_host_info_user_precondition (pdw_flags, pdw_double_click)
		deferred

		end

	show_ui (dw_id: INTEGER; p_active_object: ECOM_INTERFACE; p_command_target: ECOM_INTERFACE; p_frame: ECOM_INTERFACE; p_doc: ECOM_INTERFACE): ECOM_HRESULT is
			-- No description available.
			-- `dw_id' [in].  
			-- `p_active_object' [in].  
			-- `p_command_target' [in].  
			-- `p_frame' [in].  
			-- `p_doc' [in].  
		require
			show_ui_user_precondition: show_ui_user_precondition (dw_id, p_active_object, p_command_target, p_frame, p_doc)
		deferred

		end

	hide_ui is
			-- No description available.
		require
			hide_ui_user_precondition: hide_ui_user_precondition
		deferred

		end

	update_ui is
			-- No description available.
		require
			update_ui_user_precondition: update_ui_user_precondition
		deferred

		end

	enable_modeless (f_enable: BOOLEAN) is
			-- No description available.
			-- `f_enable' [in].  
		require
			enable_modeless_user_precondition: enable_modeless_user_precondition (f_enable)
		deferred

		end

	on_doc_window_activate (f_activate: BOOLEAN) is
			-- No description available.
			-- `f_activate' [in].  
		require
			on_doc_window_activate_user_precondition: on_doc_window_activate_user_precondition (f_activate)
		deferred

		end

	on_frame_window_activate (f_activate: BOOLEAN) is
			-- No description available.
			-- `f_activate' [in].  
		require
			on_frame_window_activate_user_precondition: on_frame_window_activate_user_precondition (f_activate)
		deferred

		end

	resize_border (left: INTEGER; top: INTEGER; right: INTEGER; bottom: INTEGER; p_uiwindow: ECOM_INTERFACE; f_frame_window: BOOLEAN) is
			-- No description available.
			-- `left' [in].  
			-- `top' [in].  
			-- `right' [in].  
			-- `bottom' [in].  
			-- `p_uiwindow' [in].  
			-- `f_frame_window' [in].  
		require
			resize_border_user_precondition: resize_border_user_precondition (left, top, right, bottom, p_uiwindow, f_frame_window)
		deferred

		end

	translate_accelerator (h_wnd: INTEGER; n_message: INTEGER; w_param: INTEGER; l_param: INTEGER; bstr_guid_cmd_group: STRING; n_cmd_id: INTEGER): ECOM_HRESULT is
			-- No description available.
			-- `h_wnd' [in].  
			-- `n_message' [in].  
			-- `w_param' [in].  
			-- `l_param' [in].  
			-- `bstr_guid_cmd_group' [in].  
			-- `n_cmd_id' [in].  
		require
			translate_accelerator_user_precondition: translate_accelerator_user_precondition (h_wnd, n_message, w_param, l_param, bstr_guid_cmd_group, n_cmd_id)
		deferred

		end

	get_option_key_path (pbstr_key: CELL [STRING]; dw: INTEGER) is
			-- No description available.
			-- `pbstr_key' [out].  
			-- `dw' [in].  
		require
			non_void_pbstr_key: pbstr_key /= Void
			get_option_key_path_user_precondition: get_option_key_path_user_precondition (pbstr_key, dw)
		deferred

		ensure
			valid_pbstr_key: pbstr_key.item /= Void
		end

	get_drop_target (p_drop_target: ECOM_INTERFACE; pp_drop_target: CELL [ECOM_INTERFACE]) is
			-- No description available.
			-- `p_drop_target' [in].  
			-- `pp_drop_target' [out].  
		require
			non_void_pp_drop_target: pp_drop_target /= Void
			get_drop_target_user_precondition: get_drop_target_user_precondition (p_drop_target, pp_drop_target)
		deferred

		ensure
			valid_pp_drop_target: pp_drop_target.item /= Void
		end

	get_external (pp_dispatch: CELL [ECOM_INTERFACE]) is
			-- No description available.
			-- `pp_dispatch' [out].  
		require
			non_void_pp_dispatch: pp_dispatch /= Void
			get_external_user_precondition: get_external_user_precondition (pp_dispatch)
		deferred

		ensure
			valid_pp_dispatch: pp_dispatch.item /= Void
		end

	translate_url (dw_translate: INTEGER; bstr_urlin: STRING; pbstr_urlout: CELL [STRING]) is
			-- No description available.
			-- `dw_translate' [in].  
			-- `bstr_urlin' [in].  
			-- `pbstr_urlout' [out].  
		require
			non_void_pbstr_urlout: pbstr_urlout /= Void
			translate_url_user_precondition: translate_url_user_precondition (dw_translate, bstr_urlin, pbstr_urlout)
		deferred

		ensure
			valid_pbstr_urlout: pbstr_urlout.item /= Void
		end

	filter_data_object (p_do: ECOM_INTERFACE; pp_doret: CELL [ECOM_INTERFACE]) is
			-- No description available.
			-- `p_do' [in].  
			-- `pp_doret' [out].  
		require
			non_void_pp_doret: pp_doret /= Void
			filter_data_object_user_precondition: filter_data_object_user_precondition (p_do, pp_doret)
		deferred

		ensure
			valid_pp_doret: pp_doret.item /= Void
		end

end -- IDOC_HOST_UIHANDLER_DISPATCH_INTERFACE

