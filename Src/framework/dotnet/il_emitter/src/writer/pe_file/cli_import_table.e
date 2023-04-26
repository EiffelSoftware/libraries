﻿note
	description: "Representation of PE import table for CLI"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=II.25.3.1 Import Table and Import Address Table (IAT)", "src=https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#%%5B%%7B%%22num%%22%%3A3068%%2C%%22gen%%22%%3A0%%7D%%2C%%7B%%22name%%22%%3A%%22XYZ%%22%%7D%%2C87%%2C770%%2C0%%5D", "protocol=uri"

class
	CLI_IMPORT_TABLE

create
	make

feature {NONE} -- Initialization

	make (is_dll: BOOLEAN)
			-- Allocate `item'.
		local
			str: POINTER
			l_name: ARRAY [NATURAL_8]
		do
			set_time_date_stamp (0)
			set_forwarder_chain (0)

				-- Set `entry_point_name'.
			if is_dll then
				set_entry_point_name (dll_entry_point_name)
			else
				set_entry_point_name (exe_entry_point_name)
			end

				-- Set `library_name'.
			set_library_name (library_name_dll)

		end

feature -- Access

	import_lookup_table: INTEGER_32
			-- RVA to ImportLookupTable

	time_date_stamp: INTEGER_32
			-- Default 0

	forwarder_chain: INTEGER_32
			-- Default 0

	name_rva: INTEGER_32
			--  RVA to null terminated ASCII string "mscoree.dll"

	iat_rva: INTEGER_32
			-- RVA to IAT

	import_by_name_rva: INTEGER_32
			-- RVA to null terminated ASCII string "_CorDllMain" or "_CorExeMain"

	entry_point_name: ARRAY [NATURAL_8]
			-- count = 12

	library_name: ARRAY [NATURAL_8]
			-- count = 12

feature -- Status Report

	count: INTEGER
			--  Number of elements that Current can hold.
		do
			Result := size_of
		end

feature -- Debug

	debug_header (a_name: STRING_32)
		local
			l_file: RAW_FILE
		do
			create l_file.make_create_read_write (a_name + ".bin")
			l_file.put_managed_pointer (item, 0, count)
			l_file.close
		end

feature -- Settings

	set_rvas (section_rva, current_location: INTEGER)
			-- Knowing that current lies in a section at `section_rva'
			-- and that its current RVA is `current_location', updates
			-- attributes of current to match those.
		do
			set_import_lookup_table (current_location + 40)
			set_name_rva (current_location + 62)
			set_iat_rva (section_rva)
			set_import_by_name_rva (current_location + size_to_import_by_name)
		end

feature -- Element Change

	set_import_lookup_table (a_value: INTEGER_32)
			-- Set the RVA to ImportLookupTable.
		do
			import_lookup_table := a_value
		ensure
			import_lookup_table_set: import_lookup_table = a_value
		end

	set_time_date_stamp (a_value: INTEGER_32)
			-- Set the time and date that the import was added.
		do
			time_date_stamp := a_value
		ensure
			time_date_stamp_set: time_date_stamp = a_value
		end

	set_forwarder_chain (a_value: INTEGER_32)
			-- Set the index of the first forwarder reference.
		do
			forwarder_chain := a_value
		ensure
			forwarder_chain_set: forwarder_chain = a_value
		end

	set_name_rva (a_value: INTEGER_32)
			-- Set the RVA to the null-terminated ASCII string that contains the name of the DLL.
		do
			name_rva := a_value
		ensure
			name_rva_set: name_rva = a_value
		end

	set_iat_rva (a_value: INTEGER_32)
			-- Set the RVA to the import address table (IAT).
		do
			iat_rva := a_value
		ensure
			iat_rva_set: iat_rva = a_value
		end

	set_import_by_name_rva (a_value: INTEGER_32)
			-- Set the RVA to the null-terminated ASCII string that contains the import symbol name.
		do
			import_by_name_rva := a_value
		ensure
			import_by_name_rva_set: import_by_name_rva = a_value
		end

	set_entry_point_name (a_value: STRING)
			-- Set the EntryPointName attribute to `a_value`.
		require
			valid_entry_point_name: a_value.count <= 12
		do
			entry_point_name := string_to_array_8 (a_value, 12)
		ensure
			entry_point_name_set: entry_point_name.same_items (string_to_array_8 (a_value, 12))
		end

	set_library_name (a_value: STRING)
			-- Set the LibraryName attribute to `a_value`.
		require
			valid_library_name: a_value.count <= 12
		do
			library_name := string_to_array_8 (a_value, 12)
		ensure
			library_name_set: library_name.same_items (string_to_array_8 (a_value, 12))
		end

feature {NONE} -- Implementation

	string_to_array_8 (a_name: STRING; n: INTEGER): ARRAY [NATURAL_8]
			-- Set the `name` attribute with `a_name`, padding with null characters if necessary.
		local
			l_name: ARRAY [NATURAL_8]
			l_name_length: INTEGER_32
			l_index: INTEGER_32
		do
			create l_name.make_filled ({NATURAL_8} 0, 1, n)
			l_name_length := a_name.count
			from
				l_index := 1
			until
				l_index > l_name_length
			loop
				l_name [l_index] := a_name.item_code (l_index).to_natural_8
				l_index := l_index + 1
			end

			Result := l_name
		end

feature -- Constants

	size_to_import_by_name: INTEGER = 48
			-- Location of import by name table from top of structure.

	dll_entry_point_name: STRING = "_CorDllMain"
	exe_entry_point_name: STRING = "_CorExeMain"
			-- Entry point names for `dll' or `exe'.

	library_name_dll: STRING = "mscoree.dll"
			-- Name of library containing above entry points.

feature -- Managed Pointer

	item: CLI_MANAGED_POINTER
			-- Write the item attributes to the buffer in little-endian format.
		do
			create Result.make (size_of)
			Result.put_integer_32 (import_lookup_table) -- import_lookup_table
			Result.put_integer_32 (time_date_stamp) -- time_date_stamp
			Result.put_integer_32 (forwarder_chain) -- forwarder_chain
			Result.put_integer_32 (name_rva) -- name_rva
			Result.put_integer_32 (iat_rva) -- iat_rva
			Result.put_padding (20, 0) -- End of Import Table. Shall, be filled with zeros
			Result.put_integer_32 (import_by_name_rva) -- import_by_name_rva
				-- this fields seems to be Hint/Name Table RVA

				-- FIXME: where is it specified?
				-- JV:
				-- It seems to be specified in the following two tables
				-- Offset Size Field            Description
				--	0      4   Hint/Name Table  RVA A 31-bit RVA into the Hint/Name Table. Bit 31
				-- 								shall be set to 0 indicating import by name.
				--  4      4                     End of table, shall be filled with zeros.

				-- The IAT should be in an executable and writable section as the loader will replace the pointers into the
				-- Hint/Name table by the actual entry points of the imported symbols.
				-- The Hint/Name table contains the name of the dll-entry that is imported.
				-- Offset Size   Field      Description
				--	0      2      Hint      Shall be 0.
				--  2   variable  Name 		Case sensitive, null-terminated ASCII string containing name to
				--							import. Shall be “_CorExeMain” for a .exe file and
				--							“_CorDllMain” for a .dll file.

				-- So the value 6 is 4 end of the table + 2 of the Hint field.
			Result.put_padding (6, 0) -- Padding of 6

			Result.put_natural_8_array (entry_point_name) -- entry_point_name
				-- This seems to be the field Name in The Hint/Name table.

				--TODO: Where is this specifed?
			Result.put_natural_8_array (library_name) -- library_name

			Result.put_padding (2, 0)

		end

	size_of: INTEGER
			-- Size of the structure
		local
			s: CLI_MANAGED_POINTER_SIZE
		do
			create s.make
			s.put_integer_32 -- import_lookup_table
			s.put_integer_32 -- time_date_stamp
			s.put_integer_32 -- forwarder_chain
			s.put_integer_32 -- name_rva
			s.put_integer_32 -- iat_rva
			s.put_natural_8_array (20) -- padding_1
			check s.size = 40 end


			s.put_integer_32 -- import_by_name_rva
			s.put_natural_8_array (6) -- padding_3
			s.put_natural_8_array (12) -- entry_point_name
			s.put_natural_8_array (12) -- library_name

			s.put_padding (2) -- FIXME: Check why this is needed?
			Result := s
		ensure
			Result = 76
		end

end
