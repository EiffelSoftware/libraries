-- This file has been generated by EWG. Do not edit. Changes will be lost!
-- wrapper for struct: struct GetGrowImageRegionRec

class GET_GROW_IMAGE_REGION_REC_STRUCT_EXTERNAL

feature {NONE} -- Implementation

	sizeof_external: INTEGER is
		external
			"C [macro <Carbon/Carbon.h>]: EIF_INTEGER"
		alias
			"sizeof(struct GetGrowImageRegionRec)"
		end

	get_growrect_external (an_item: POINTER): POINTER is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_GetGrowImageRegionRec_member_get_growRect"
		end

	set_growrect_external (an_item: POINTER; a_value: POINTER) is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_GetGrowImageRegionRec_member_set_growRect"
		end

	get_growimageregion_external (an_item: POINTER): POINTER is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_GetGrowImageRegionRec_member_get_growImageRegion"
		end

	set_growimageregion_external (an_item: POINTER; a_value: POINTER) is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_GetGrowImageRegionRec_member_set_growImageRegion"
		ensure
			a_value_set: a_value = get_growimageregion_external (an_item)
		end

end

