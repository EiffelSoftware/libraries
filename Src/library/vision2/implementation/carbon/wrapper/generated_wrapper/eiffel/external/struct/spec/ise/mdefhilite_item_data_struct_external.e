-- This file has been generated by EWG. Do not edit. Changes will be lost!
-- wrapper for struct: struct MDEFHiliteItemData

class MDEFHILITE_ITEM_DATA_STRUCT_EXTERNAL

feature {NONE} -- Implementation

	sizeof_external: INTEGER is
		external
			"C [macro <Carbon/Carbon.h>]: EIF_INTEGER"
		alias
			"sizeof(struct MDEFHiliteItemData)"
		end

	get_previousitem_external (an_item: POINTER): INTEGER is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_MDEFHiliteItemData_member_get_previousItem"
		end

	set_previousitem_external (an_item: POINTER; a_value: INTEGER) is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_MDEFHiliteItemData_member_set_previousItem"
		ensure
			a_value_set: a_value = get_previousitem_external (an_item)
		end

	get_newitem_external (an_item: POINTER): INTEGER is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_MDEFHiliteItemData_member_get_newItem"
		end

	set_newitem_external (an_item: POINTER; a_value: INTEGER) is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_MDEFHiliteItemData_member_set_newItem"
		ensure
			a_value_set: a_value = get_newitem_external (an_item)
		end

	get_context_external (an_item: POINTER): POINTER is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_MDEFHiliteItemData_member_get_context"
		end

	set_context_external (an_item: POINTER; a_value: POINTER) is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_MDEFHiliteItemData_member_set_context"
		ensure
			a_value_set: a_value = get_context_external (an_item)
		end

end

