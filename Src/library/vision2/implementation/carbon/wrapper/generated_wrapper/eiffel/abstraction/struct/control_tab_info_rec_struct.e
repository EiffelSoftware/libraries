-- This file has been generated by EWG. Do not edit. Changes will be lost!

class CONTROL_TAB_INFO_REC_STRUCT

inherit

	EWG_STRUCT

	CONTROL_TAB_INFO_REC_STRUCT_EXTERNAL
		export
			{NONE} all
		end

create

	make_new_unshared,
	make_new_shared,
	make_unshared,
	make_shared

feature {ANY} -- Access

	sizeof: INTEGER is
		do
			Result := sizeof_external
		end

feature {ANY} -- Member Access

	version: INTEGER is
			-- Access member `version'
		require
			exists: exists
		do
			Result := get_version_external (item)
		ensure
			result_correct: Result = get_version_external (item)
		end

	set_version (a_value: INTEGER) is
			-- Set member `version'
		require
			exists: exists
		do
			set_version_external (item, a_value)
		ensure
			a_value_set: a_value = version
		end

	iconsuiteid: INTEGER is
			-- Access member `iconSuiteID'
		require
			exists: exists
		do
			Result := get_iconsuiteid_external (item)
		ensure
			result_correct: Result = get_iconsuiteid_external (item)
		end

	set_iconsuiteid (a_value: INTEGER) is
			-- Set member `iconSuiteID'
		require
			exists: exists
		do
			set_iconsuiteid_external (item, a_value)
		ensure
			a_value_set: a_value = iconsuiteid
		end

	name: POINTER is
			-- Access member `name'
		require
			exists: exists
		do
			Result := get_name_external (item)
		ensure
			result_correct: Result = get_name_external (item)
		end

end
