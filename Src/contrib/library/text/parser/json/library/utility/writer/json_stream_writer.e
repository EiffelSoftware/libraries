note
	description: "[
			Stream JSON writer interface.
			Useful to write JSON content progressively, without keeping all in memory.
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	JSON_STREAM_WRITER

feature -- Reset

	reset
			-- Reset writer
			--| Could be useful to recover from exception
		do
		end

feature -- Write: object, array

	enter_object
			-- Start a JSON Object.
		deferred
		ensure
			active_is_object
		end

	leave_object
			-- End a JSON Object.	
		require
			active_is_object
		deferred
		end

	enter_array
			-- Start a JSON array.	
		deferred
		ensure
			active_is_array
		end

	leave_array
			-- End a JSON array.	
		require
			active_is_array
		deferred
		end

	leave
			-- End a JSON object or array.
		require
			 in_array_or_object: active_is_object or active_is_array
		do
			if active_is_object then
				leave_object
			elseif active_is_array then
				leave_array
			else
				check in_array_or_object: False end
			end
		end

feature -- Write: property, value

	put_property_name (a_name: READABLE_STRING_GENERAL)
			-- Put a JSON property name `a_name`.
		require
			active_is_object
		deferred
		end

	put_string_value (a_value: READABLE_STRING_GENERAL)
			-- Put a JSON string value `a_value`.
		require
			active_is_property or active_is_array
		deferred
		end

	put_integer_64_value (a_value: INTEGER_64)
			-- Put a JSON (integer 64) number value `a_value`.
		require
			active_is_property or active_is_array
		deferred
		end

	put_real_64_value (a_value: REAL_64)
			-- Put a JSON (real 64) number value `a_value`.	
		require
			active_is_property or active_is_array
		deferred
		end

	put_boolean_value (a_value: BOOLEAN)
			-- Put a JSON boolean value `a_value`.		
		require
			active_is_property or active_is_array
		deferred
		end

	put_null_value
			-- Put a JSON null value.
		require
			active_is_property or active_is_array
		deferred
		end

feature -- Status report

	active_is_object: BOOLEAN
			-- Is active stack item is for a JSON object?
		deferred
		end

	active_is_array: BOOLEAN
			-- Is active stack item is for a JSON array?	
		deferred
		end

	active_is_property: BOOLEAN
			-- Is active stack item is for a JSON property?	
		deferred
		end

	active_count: INTEGER
			-- Count of active stack item (if any).
		deferred
		end

note
	copyright: "2010-2022, Javier Velilla, Jocelyn Fiat, Eiffel Software and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end
