note
	description: "[
		An real binding argument value for use with executing a SQLite statement.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SQLITE_DOUBLE_ARG

inherit
	SQLITE_BIND_ARG [REAL_64]

create
	make

feature {SQLITE_STATEMENT} -- Basic operations

	bind_to_statement (a_statement: SQLITE_STATEMENT; a_index: INTEGER)
			-- <Precursor>
		do
			sqlite_raise_on_failure (c_sqlite3_bind_double (sqlite_api.api_pointer (sqlite3_bind_double_api), a_statement.internal_stmt, a_index, value))
		end

feature {NONE} -- Implemention: Internal cache

	internal_value: REAL_64
			-- Cached version of `value'.

feature {NONE} -- Externals

	c_sqlite3_bind_double (a_fptr: POINTER; a_stmt: POINTER; a_index: INTEGER; a_value: REAL_64): INTEGER
		require
			not_a_fptr_is_null: a_fptr /= default_pointer
			not_a_stmt_is_null: a_stmt /= default_pointer
			a_index_positive: a_index > 0
		external
			"C inline use <sqlite3.h>"
		alias
			"[
				return (EIF_INTEGER)(FUNCTION_CAST(int, (sqlite3_stmt *, int, double)) $a_fptr) (
					(sqlite3_stmt *)$a_stmt, (int)$a_index, (double)$a_value);
			]"
		end

feature {NONE} -- Constants

	sqlite3_bind_double_api: STRING = "sqlite3_bind_double"

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
