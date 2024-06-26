note
	description: "Representation of PE import table for CLI"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CLI_IMPORT_TABLE

inherit
	MANAGED_POINTER
		rename
			make as managed_pointer_make
		end

create
	make

feature {NONE} -- Initialization

	make (is_dll: BOOLEAN)
			-- Allocate `item'.
		local
			str: POINTER
			ascii_str: C_STRING
		do
			managed_pointer_make (structure_size)
			c_set_time_date_stamp (item, 0)
			c_set_forwarder_chain (item, 0)

				-- Set `entry_point_name'.
			str := c_entry_point_name (item)
			if is_dll then
				create ascii_str.make (dll_entry_point_name)
			else
				create ascii_str.make (exe_entry_point_name)
			end
			str.memory_copy (ascii_str.item, ascii_str.count)

				-- Set `library_name'.
			str := c_library_name (item)
			create ascii_str.make (library_name)
			str.memory_copy (ascii_str.item, ascii_str.count)
		end

feature -- Settings

	set_rvas (section_rva, current_location: INTEGER)
			-- Knowing that current lies in a section at `section_rva'
			-- and that its current RVA is `current_location', updates
			-- attributes of current to match those.
		do
			c_set_import_lookup_table (item, current_location + 40)
			c_set_name_rva (item, current_location + 62)
			c_set_iat_rva (item, section_rva)
			c_set_import_by_name_rva (item, current_location + size_to_import_by_name)
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size of CLI_IMPORT_TABLE.
		external
			"C macro use %"cli_writer.h%""
		alias
			"sizeof(CLI_IMPORT_TABLE)"
		end

	size_to_import_by_name: INTEGER = 48
			-- Location of import by name table from top of structure.

feature -- Constants



	dll_entry_point_name: STRING = "_CorDllMain"
	exe_entry_point_name: STRING = "_CorExeMain"
			-- Entry point names for `dll' or `exe'.

	library_name: STRING = "mscoree.dll"
			-- Name of library containing above entry points.

feature -- Debug

	debug_header (a_name: STRING_32)
		local
			l_file: RAW_FILE
		do
			create l_file.make_create_read_write (a_name + ".bin")
			l_file.put_managed_pointer (Current, 0, count)
			l_file.close
		end

feature {NONE} -- Settings

	c_set_import_lookup_table (an_item: POINTER; i: INTEGER)
			-- Set `ImportLookupTable' to `i'.
		external
			"C struct CLI_IMPORT_TABLE access ImportLookupTable type DWORD use %"cli_writer.h%""
		end

	c_set_time_date_stamp (an_item: POINTER; i: INTEGER)
			-- Set `TimeDateStamp' to `i'.
		external
			"C struct CLI_IMPORT_TABLE access TimeDateStamp type DWORD use %"cli_writer.h%""
		end

	c_set_forwarder_chain (an_item: POINTER; i: INTEGER)
			-- Set `ForwarderChain' to `i'.
		external
			"C struct CLI_IMPORT_TABLE access ForwarderChain type DWORD use %"cli_writer.h%""
		end

	c_set_name_rva (an_item: POINTER; i: INTEGER)
			-- Set `NameRVA' to `i'.
		external
			"C struct CLI_IMPORT_TABLE access NameRVA type DWORD use %"cli_writer.h%""
		end

	c_set_iat_rva (an_item: POINTER; i: INTEGER)
			-- Set `IatRVA' to `i'.
		external
			"C struct CLI_IMPORT_TABLE access IatRVA type DWORD use %"cli_writer.h%""
		end

	c_set_import_by_name_rva (an_item: POINTER; i: INTEGER)
			-- Set `ImportByNameRVA' to `i'.
		external
			"C struct CLI_IMPORT_TABLE access ImportByNameRVA type DWORD use %"cli_writer.h%""
		end

	c_entry_point_name (an_item: POINTER): POINTER
			-- Access `EntryPointName'.
		external
			"C struct CLI_IMPORT_TABLE access EntryPointName use %"cli_writer.h%""
		end

	c_library_name (an_item: POINTER): POINTER
			-- Access `LibraryName'.
		external
			"C struct CLI_IMPORT_TABLE access LibraryName use %"cli_writer.h%""
		end

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
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

end -- class CLI_IMPORT_TABLE
