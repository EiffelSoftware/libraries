indexing
	description: "Control interfaces. Help file: "
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	TAG_DVTARGETDEVICE_RECORD

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

	td_size: INTEGER is
			-- No description available.
		do
			Result := ccom_tag_dvtargetdevice_td_size (item)
		end

	td_driver_name_offset: INTEGER is
			-- No description available.
		do
			Result := ccom_tag_dvtargetdevice_td_driver_name_offset (item)
		end

	td_device_name_offset: INTEGER is
			-- No description available.
		do
			Result := ccom_tag_dvtargetdevice_td_device_name_offset (item)
		end

	td_port_name_offset: INTEGER is
			-- No description available.
		do
			Result := ccom_tag_dvtargetdevice_td_port_name_offset (item)
		end

	td_ext_devmode_offset: INTEGER is
			-- No description available.
		do
			Result := ccom_tag_dvtargetdevice_td_ext_devmode_offset (item)
		end

	td_data: CHARACTER_REF is
			-- No description available.
		do
			Result := ccom_tag_dvtargetdevice_td_data (item)
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size of structure
		do
			Result := c_size_of_tag_dvtargetdevice
		end

feature -- Basic Operations

	set_td_size (a_td_size: INTEGER) is
			-- Set `td_size' with `a_td_size'.
		do
			ccom_tag_dvtargetdevice_set_td_size (item, a_td_size)
		end

	set_td_driver_name_offset (a_td_driver_name_offset: INTEGER) is
			-- Set `td_driver_name_offset' with `a_td_driver_name_offset'.
		do
			ccom_tag_dvtargetdevice_set_td_driver_name_offset (item, a_td_driver_name_offset)
		end

	set_td_device_name_offset (a_td_device_name_offset: INTEGER) is
			-- Set `td_device_name_offset' with `a_td_device_name_offset'.
		do
			ccom_tag_dvtargetdevice_set_td_device_name_offset (item, a_td_device_name_offset)
		end

	set_td_port_name_offset (a_td_port_name_offset: INTEGER) is
			-- Set `td_port_name_offset' with `a_td_port_name_offset'.
		do
			ccom_tag_dvtargetdevice_set_td_port_name_offset (item, a_td_port_name_offset)
		end

	set_td_ext_devmode_offset (a_td_ext_devmode_offset: INTEGER) is
			-- Set `td_ext_devmode_offset' with `a_td_ext_devmode_offset'.
		do
			ccom_tag_dvtargetdevice_set_td_ext_devmode_offset (item, a_td_ext_devmode_offset)
		end

	set_td_data (a_td_data: CHARACTER_REF) is
			-- Set `td_data' with `a_td_data'.
		require
			non_void_a_td_data: a_td_data /= Void
		do
			ccom_tag_dvtargetdevice_set_td_data (item, a_td_data)
		end

feature {NONE}  -- Externals

	c_size_of_tag_dvtargetdevice: INTEGER is
			-- Size of structure
		external
			"C [macro %"ecom_control_library_tagDVTARGETDEVICE_s.h%"]"
		alias
			"sizeof(ecom_control_library::tagDVTARGETDEVICE)"
		end

	ccom_tag_dvtargetdevice_td_size (a_pointer: POINTER): INTEGER is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagDVTARGETDEVICE_s_impl.h%"](ecom_control_library::tagDVTARGETDEVICE *):EIF_INTEGER"
		end

	ccom_tag_dvtargetdevice_set_td_size (a_pointer: POINTER; arg2: INTEGER) is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagDVTARGETDEVICE_s_impl.h%"](ecom_control_library::tagDVTARGETDEVICE *, ULONG)"
		end

	ccom_tag_dvtargetdevice_td_driver_name_offset (a_pointer: POINTER): INTEGER is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagDVTARGETDEVICE_s_impl.h%"](ecom_control_library::tagDVTARGETDEVICE *):EIF_INTEGER"
		end

	ccom_tag_dvtargetdevice_set_td_driver_name_offset (a_pointer: POINTER; arg2: INTEGER) is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagDVTARGETDEVICE_s_impl.h%"](ecom_control_library::tagDVTARGETDEVICE *, USHORT)"
		end

	ccom_tag_dvtargetdevice_td_device_name_offset (a_pointer: POINTER): INTEGER is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagDVTARGETDEVICE_s_impl.h%"](ecom_control_library::tagDVTARGETDEVICE *):EIF_INTEGER"
		end

	ccom_tag_dvtargetdevice_set_td_device_name_offset (a_pointer: POINTER; arg2: INTEGER) is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagDVTARGETDEVICE_s_impl.h%"](ecom_control_library::tagDVTARGETDEVICE *, USHORT)"
		end

	ccom_tag_dvtargetdevice_td_port_name_offset (a_pointer: POINTER): INTEGER is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagDVTARGETDEVICE_s_impl.h%"](ecom_control_library::tagDVTARGETDEVICE *):EIF_INTEGER"
		end

	ccom_tag_dvtargetdevice_set_td_port_name_offset (a_pointer: POINTER; arg2: INTEGER) is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagDVTARGETDEVICE_s_impl.h%"](ecom_control_library::tagDVTARGETDEVICE *, USHORT)"
		end

	ccom_tag_dvtargetdevice_td_ext_devmode_offset (a_pointer: POINTER): INTEGER is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagDVTARGETDEVICE_s_impl.h%"](ecom_control_library::tagDVTARGETDEVICE *):EIF_INTEGER"
		end

	ccom_tag_dvtargetdevice_set_td_ext_devmode_offset (a_pointer: POINTER; arg2: INTEGER) is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagDVTARGETDEVICE_s_impl.h%"](ecom_control_library::tagDVTARGETDEVICE *, USHORT)"
		end

	ccom_tag_dvtargetdevice_td_data (a_pointer: POINTER): CHARACTER_REF is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagDVTARGETDEVICE_s_impl.h%"](ecom_control_library::tagDVTARGETDEVICE *):EIF_REFERENCE"
		end

	ccom_tag_dvtargetdevice_set_td_data (a_pointer: POINTER; arg2: CHARACTER_REF) is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagDVTARGETDEVICE_s_impl.h%"](ecom_control_library::tagDVTARGETDEVICE *, EIF_OBJECT)"
		end

end -- TAG_DVTARGETDEVICE_RECORD

