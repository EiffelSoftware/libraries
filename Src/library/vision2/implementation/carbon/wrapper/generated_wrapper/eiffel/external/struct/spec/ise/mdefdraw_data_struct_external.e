-- This file has been generated by EWG. Do not edit. Changes will be lost!
-- wrapper for struct: struct MDEFDrawData

class MDEFDRAW_DATA_STRUCT_EXTERNAL

feature {NONE} -- Implementation

	sizeof_external: INTEGER is
		external
			"C [macro <Carbon/Carbon.h>]: EIF_INTEGER"
		alias
			"sizeof(struct MDEFDrawData)"
		end

	get_trackingdata_external (an_item: POINTER): POINTER is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_MDEFDrawData_member_get_trackingData"
		end

	set_trackingdata_external (an_item: POINTER; a_value: POINTER) is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_MDEFDrawData_member_set_trackingData"
		end

	get_context_external (an_item: POINTER): POINTER is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_MDEFDrawData_member_get_context"
		end

	set_context_external (an_item: POINTER; a_value: POINTER) is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_MDEFDrawData_member_set_context"
		ensure
			a_value_set: a_value = get_context_external (an_item)
		end

end

