note
	description: "Summary description for {STRING_TABLE_OF_STRING_INSPECTOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STRING_TABLE_OF_STRING_INSPECTOR

inherit
	TEMPLATE_INSPECTOR
		redefine
			internal_data
		end

create
	register

feature {TEMPLATE_ROUTINES}

	internal_data (field_name: STRING; obj: detachable ANY): detachable CELL [detachable ANY]
			-- Return object in a cell
			-- If not handled by this inspector, return Void
		local
			l_fn: STRING
		do
			if attached {STRING_TABLE [STRING]} obj as l_regions then
				l_fn := field_name.as_lower
				if l_fn.is_case_insensitive_equal ("count") then
					Result := cell_of (l_regions.count)
				elseif attached l_regions.item (l_fn) as v then
					Result := cell_of (v)
				end
			end
		end

note
	copyright: "2011-2014, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
