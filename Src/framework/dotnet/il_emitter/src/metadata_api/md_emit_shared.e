﻿note
	description: "Summary description for {MD_EMIT_SHARED}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MD_EMIT_SHARED

inherit

	MD_TOKEN_TYPES

feature -- Access

	tables: SPECIAL [MD_TABLE]
			--  in-memory metadata tables
		deferred
		end

	pe_writer: PE_WRITER
			-- class to generate the PE file.
			--| using as a helper class to access needed features.
			--| TODO, we don't need the full class we need to extract the needed features.
		deferred
		end

	pe_index: NATURAL_32
			-- metatable index in the PE file for this data container.

--	Heap_size_: INTEGER = 0x1_0000
			--   If the maximum size of the heap is less than 2^16, then the heap offset size is 2 bytes (16 bits), otherwise it is 4 bytes

feature -- Status report

	us_heap_size: NATURAL_32
			-- User string heap size.
		do
			Result := pe_writer.us.size
		end

	guid_heap_size: NATURAL_32
			-- Guid heap size
		do
			Result := pe_writer.guid.size
		end

	blob_heap_size: NATURAL_32
			-- Blob heap size
		do
			Result := pe_writer.blob.size
		end

	strings_heap_size: NATURAL_32
			-- String heap size
		do
			Result := pe_writer.strings.size
		end

feature {NONE} -- Change tables

	add_table_entry (a_entry: PE_TABLE_ENTRY_BASE): NATURAL_32
			-- Index in related MD_TABLE
			-- add an entry to one of the tables
			-- note the data for the table will be a class inherited from TableEntryBase,
			--  and this class will self-report the table index to use
		require
			valid_entry_table_index: tables.valid_index (a_entry.table_index.to_integer_32)
		local
			n: INTEGER
			l_md_table: MD_TABLE
		do
			n := a_entry.table_index.to_integer_32
			l_md_table := tables [n]

			inspect a_entry.table_index
			when
				{PE_TABLES}.tmethoddef,
				{PE_TABLES}.tparam,
				{PE_TABLES}.tfield,
				{PE_TABLES}.tassemblydef,
				{PE_TABLES}.tClassLayout, -- Not used.
				{PE_TABLES}.tconstant, -- Not used.
				{PE_TABLES}.tcustomattribute,
				{PE_TABLES}.tfieldmarshal,
				{PE_TABLES}.tfieldrva,
				{PE_TABLES}.tGenericParam, -- Not used.
				{PE_TABLES}.tImplMap,
				{PE_TABLES}.tMethodSemantics,
				{PE_TABLES}.tMethodSpec, -- Not used
				{PE_TABLES}.tNestedClass, -- Not used
				{PE_TABLES}.tStandaloneSig
			then
				-- No duplication checking
			else
				Result := a_entry.token_from_table (l_md_table)
			end
			if Result = 0 then
				l_md_table.force (a_entry)
				Result := l_md_table.size
			end
			last_token := (n |<< 24).to_natural_32 | Result
		ensure
			entry_added: a_entry.token_from_table (tables [a_entry.table_index.to_integer_32]) > 0
		end

	last_token: NATURAL_32

feature {NONE} -- Helper

	extract_table_type_and_row (a_token: INTEGER): TUPLE [table_type_index: NATURAL_32; table_row_index: NATURAL_32]
			-- Given a token `a_token' return a TUPLE with the table_type_index and the
			-- table_row_index.
			--| Metadata tokens
			--| Many CIL instructions are followed by a "metadata token". This is a 4-byte value, that specifies a
			--| row in a metadata table, or a starting byte offset in the User String heap. The most-significant
			--| byte of the token specifies the table or heap. For example, a value of 0x02 specifies the TypeDef
			--| table; a value of 0x70 specifies the User String heap. The value corresponds to the number
			--| assigned to that metadata table (see Partition II for the full list of tables) or to 0x70 for the User
			--| String heap. The least-significant 3 bytes specify the target row within that metadata table, or
			--| starting byte offset within the User String heap. The rows within metadata tables are numbered
			--| one upwards, whilst offsets in the heap are numbered zero upwards. (So, for example, the
			--| metadata token with value 0x02000007 specifies row number 7 in the TypeDef table)
		local
			l_table_type_index: NATURAL_32
			l_table_row_index: NATURAL_32
		do
				-- 2^8 -1 = 255 = 0xFF
			l_table_type_index := ((a_token |>> 24) & 0xFF).to_natural_32
				-- 2^ 24 -1 = 16777215 = 0xFF_FFFF
			l_table_row_index := (a_token & 0xFF_FFFF).to_natural_32
			Result := [l_table_type_index, l_table_row_index]
		end

feature -- Factory		

	create_method_def_or_ref (a_token: INTEGER; a_index: NATURAL_32): PE_METHOD_DEF_OR_REF
			 -- Create a new PE_METHOD_DEF_OR_REF instance with the given `a_token' and `a_index'.
		local
			l_tag: INTEGER
		do
			if a_token & Md_mask = Md_method_def then
				l_tag := {PE_METHOD_DEF_OR_REF}.methoddef
			elseif a_token & Md_mask = Md_member_ref then
				l_tag := {PE_METHOD_DEF_OR_REF}.memberref
			else
				check should_not_occur: False end
			end
			create Result.make_with_tag_and_index (l_tag, a_index)
		end

	create_type_def_or_ref (a_token: INTEGER; a_index: NATURAL_32): PE_TYPEDEF_OR_REF
			-- Create a new PE_TYPEDEF_OR_REF instance with the given `a_token' and `a_index'.
		local
			l_tag: INTEGER
		do
			if a_token & Md_mask = Md_type_def then
				l_tag := {PE_TYPEDEF_OR_REF}.typedef
			elseif a_token & Md_mask = Md_type_ref then
				l_tag := {PE_TYPEDEF_OR_REF}.typeref
			elseif a_token & Md_mask = Md_type_spec then
				l_tag := {PE_TYPEDEF_OR_REF}.typespec
			else
				check should_not_occur: False end
			end
			create Result.make_with_tag_and_index (l_tag, a_index)
		end

	create_member_ref (a_token: INTEGER; a_index: NATURAL_32): PE_MEMBER_REF_PARENT
			-- Create a new PE_MEMBER_REF_PARENT instance with the given `a_token' and `a_index'.
		local
			l_tag: INTEGER
		do
			if a_token & Md_mask = Md_type_def then
				l_tag := {PE_MEMBER_REF_PARENT}.typedef
			elseif a_token & Md_mask = Md_type_ref then
				l_tag := {PE_MEMBER_REF_PARENT}.typeref
			elseif a_token & Md_mask = Md_type_spec then
				l_tag := {PE_MEMBER_REF_PARENT}.typespec
			elseif a_token & Md_mask = Md_module_ref then
				l_tag := {PE_MEMBER_REF_PARENT}.moduleref
			elseif a_token & Md_mask = Md_method_def then
				l_tag := {PE_MEMBER_REF_PARENT}.methoddef
			else
				check should_not_occur: False end
			end
			create Result.make_with_tag_and_index (l_tag, a_index)
		end

	create_implementation (a_token: INTEGER; a_index: NATURAL_32): PE_IMPLEMENTATION
			-- Create a new PE_IMPLEMENTATION instance with the given `a_token' and `a_index'.
		local
			l_tag: INTEGER
		do
			if a_token & Md_mask = Md_file then
				l_tag := {PE_IMPLEMENTATION}.File
			elseif a_token & Md_mask = Md_assembly_ref then
				l_tag := {PE_IMPLEMENTATION}.AssemblyRef
			else
				check should_not_occur: False end
			end
			create Result.make_with_tag_and_index (l_tag, a_index)
		end

	create_pe_custom_attribute (a_token: INTEGER; a_index: NATURAL_32): PE_CUSTOM_ATTRIBUTE
		 	-- Create a new PE_CUSTOM_ATTRIBUTE instance with the given `a_token' and `a_index'.
		local
			l_tag: INTEGER
		do
			if a_token & Md_mask = Md_method_def then
				l_tag := {PE_CUSTOM_ATTRIBUTE}.MethodDef
			elseif a_token & Md_mask = Md_field_def then
				l_tag := {PE_CUSTOM_ATTRIBUTE}.FieldDef
			elseif a_token & Md_mask = Md_type_ref then
				l_tag := {PE_CUSTOM_ATTRIBUTE}.TypeRef
			elseif a_token & Md_mask = Md_type_def then
				l_tag := {PE_CUSTOM_ATTRIBUTE}.TypeDef
			elseif a_token & Md_mask = Md_param_def then
				l_tag := {PE_CUSTOM_ATTRIBUTE}.ParamDef
			elseif a_token & Md_mask = Md_interface_impl then
				l_tag := {PE_CUSTOM_ATTRIBUTE}.InterfaceImpl
			elseif a_token & Md_mask = Md_member_ref then
				l_tag := {PE_CUSTOM_ATTRIBUTE}.MemberRef
			elseif a_token & Md_mask = Md_module then
				l_tag := {PE_CUSTOM_ATTRIBUTE}.Module
			elseif a_token & Md_mask = Md_permission then
				l_tag := {PE_CUSTOM_ATTRIBUTE}.Permission
			elseif a_token & Md_mask = Md_property then
				l_tag := {PE_CUSTOM_ATTRIBUTE}.Property
			elseif a_token & Md_mask = Md_event then
				l_tag := {PE_CUSTOM_ATTRIBUTE}.Event
			elseif a_token & Md_mask = Md_signature then
				l_tag := {PE_CUSTOM_ATTRIBUTE}.StandaloneSig
			elseif a_token & Md_mask = Md_module_ref then
				l_tag := {PE_CUSTOM_ATTRIBUTE}.ModuleRef
			elseif a_token & Md_mask = Md_type_spec then
				l_tag := {PE_CUSTOM_ATTRIBUTE}.TypeSpec
			elseif a_token & Md_mask = Md_assembly then
				l_tag := {PE_CUSTOM_ATTRIBUTE}.Assembly
			elseif a_token & Md_mask = Md_assembly_ref then
				l_tag := {PE_CUSTOM_ATTRIBUTE}.AssemblyRef
			elseif a_token & Md_mask = Md_file then
				l_tag := {PE_CUSTOM_ATTRIBUTE}.File
			elseif a_token & Md_mask = Md_exported_type then
				l_tag := {PE_CUSTOM_ATTRIBUTE}.ExportedType
			elseif a_token & Md_mask = Md_manifest_resource then
				l_tag := {PE_CUSTOM_ATTRIBUTE}.ManifestResource
			else
				check should_not_occur: False end
			end
			create Result.make_with_tag_and_index (l_tag, a_index)
		end

	create_pe_custom_attribute_type (a_token: INTEGER; a_index: NATURAL_32): PE_CUSTOM_ATTRIBUTE_TYPE
			-- Create a new PE_CUSTOM_ATTRIBUTE_TYPE instance with the given `a_token' and `a_index'.
		local
			l_tag: INTEGER
		do
			if a_token & Md_mask = Md_method_def then
				l_tag := {PE_CUSTOM_ATTRIBUTE_TYPE}.MethodDef
			elseif a_token & Md_mask = md_member_ref then
				l_tag := {PE_CUSTOM_ATTRIBUTE_TYPE}.MemberRef
			else
				check should_not_occur: False end
			end
			create Result.make_with_tag_and_index (l_tag, a_index)
		end

	create_field_marshal (a_token: INTEGER; a_index: NATURAL_32): PE_FIELD_MARSHAL
			-- Create a new `PE_FIELD_MARSHAL` instance with the specified `a_token` and `a_index`.
		local
			l_tag: INTEGER
		do
			if a_token & Md_mask = md_field_def then
				l_tag := {PE_FIELD_MARSHAL}.Field
			elseif a_token & Md_mask = md_param_def then
				l_tag := {PE_FIELD_MARSHAL}.Param
			else
				check should_not_occur: False end
			end
			create Result.make_with_tag_and_index (l_tag, a_index)
		end

feature -- Access

	next_table_index (a_table_id: NATURAL_32): NATURAL_32
			-- Table for id `a_table_id`
			-- See `{PE_TABLES}` for table ids.
		require
			valid_table_index: tables.valid_index (a_table_id.to_integer_32)
		do
			Result := tables [a_table_id.to_integer_32].size + 1
		end

feature -- Metadata Table Sizes

	module_table_entry_size: NATURAL_32
		note
			EIS: "name={PE_MODULE_TABLE_ENTRY}.name_index", "src=eiffel:?class=PE_MODULE_TABLE_ENTRY&feature=name_index", "protocol=uri"
			EIS: "name={PE_MODULE_TABLE_ENTRY}.guid_index", "src=eiffel:?class=PE_MODULE_TABLE_ENTRY&feature=guid_index"
		local
			string_index_size, guid_index_size, blob_index_size: NATURAL_32
		do
			if strings_heap_size < 0x1_0000 then
				string_index_size := 2
			else
				string_index_size := 4
			end

			if guid_heap_size < 0x1_0000 then
				guid_index_size := 2
			else
				guid_index_size := 4
			end

			if blob_heap_size < 0x1_0000 then
				blob_index_size := 2
			else
				blob_index_size := 4
			end

			Result := 2 + string_index_size + 3 * guid_index_size
		end

	type_ref_entry_size: NATURAL_32
			-- Compute the table entry size for the TypeRef table
		note
			EIS: "name={PE_TYPE_REF_TABLE_ENTRY}.resolution", "protocol=uri", "src=eiffel:?class=PE_TYPE_REF_ENTRY&feature=resolution"
			EIS: "name={PE_TYPE_REF_TABLE_ENTRY}.type_name_index", "protocol=uri", "src=eiffel:?class=PE_TYPE_REF_ENTRY&feature=type_name_index"
			EIS: "name={PE_TYPE_REF_TABLE_ENTRY}.type_name_space_index", "protocol=uri", "src=eiffel:?class=PE_TYPE_REF_ENTRY&feature=type_name_space_index"

		local
			index_size, index_string_size: NATURAL_32
		do
				-- Resolution scope
			if pe_index < 0x1_0000 then
				index_size := 2
			else
				index_size := 4
			end

				-- Type name index and type_name_space_index
			if strings_heap_size < 0x1_0000 then
				index_string_size := 2
			else
				index_string_size := 4
			end

				--	II.22.38 TypeRef : 0x01
				--	The TypeRef table has the following columns:
				--	index: ResolutionScope (an index into a Module, ModuleRef, AssemblyRef or TypeRef table,
				--			or null; more precisely, a ResolutionScope (§II.24.2.6) coded index)
				--	string: TypeName (an index into the String heap)
				--	string: TypeNamespace (an index into the String heap)

			Result := index_size + 2 * index_string_size
		end

	type_def_table_entry_size: NATURAL_32
			-- Compute the table entry size for the TypeDef table
		note
			EIS: "name={PE_TYPE_DEF_TABLE_ENTRY}.type_name_index", "protocol=uri", "src=eiffel:?class=PE_TYPE_DEF_TABLE_ENTRY&feature=type_name_index"
			EIS: "name={PE_TYPE_DEF_TABLE_ENTRY}.type_name_space_index", "protocol=uri", "src=eiffel:?class=PE_TYPE_DEF_TABLE_ENTRY&feature=type_name_space_index"
			EIS: "name={PE_TYPE_DEF_TABLE_ENTRY}.extends", "protocol=uri", "src=eiffel:?class=PE_TYPE_DEF_TABLE_ENTRY&feature=extends"
			EIS: "name={PE_TYPE_DEF_TABLE_ENTRY}.fields", "protocol=uri", "src=eiffel:?class=PE_TYPE_DEF_TABLE_ENTRY&feature=fields"
			EIS: "name={PE_TYPE_DEF_TABLE_ENTRY}.methods", "protocol=uri", "src=eiffel:?class=PE_TYPE_DEF_TABLE_ENTRY&feature=methods"
		local
			index_size, index_string_size: NATURAL_32
		do
				-- extends, fields and methods
			if pe_index < 0x1_0000 then
				index_size := 2
			else
				index_size := 4
			end

				-- type_name_index and type_name_space_index
			if strings_heap_size < 0x1_0000 then
				index_string_size := 2
			else
				index_string_size := 4
			end

				--	II.22.37 TypeDef : 0x02
				--	The TypeDef table has the following columns:
				--	4 : Flags (a 4-byte bitmask of type TypeAttributes, §II.23.1.15)
				--	string: TypeName (an index into the String heap)
				--	string: TypeNamespace (an index into the String heap)
				--	index: Extends (an index into the TypeDef, TypeRef, or TypeSpec table; more precisely, a
				--			TypeDefOrRef (§II.24.2.6) coded index)
				--	index: FieldList (an index into the Field table; it marks the first of a contiguous run of
				--		Fields owned by this Type). The run continues to the smaller of:
				--		- the last row of the Field table
				--		- the next run of Fields, found by inspecting the FieldList of the next row
				--			in this TypeDef table
				--	index: MethodList (an index into the MethodDef table; it marks the first of a continguous
				--		run of Methods owned by this Type). The run continues to the smaller of:
				--		- the last row of the MethodDef table
				--		- the next run of Methods, found by inspecting the MethodList of the next
				--			row in this TypeDef table

				-- 4 is the size of the flags
			Result := 4 + 2 * index_string_size + 3 * index_size
		end

	field_table_entry_size: NATURAL_32
			-- Compute the table entry size for the Field table
		note
			EIS: "name={PE_FIELD_TABLE_ENTRY}.flags", "src=eiffel:?class=PE_FIELD_TABLE_ENTRY&feature=flags"
			EIS: "name={PE_FIELD_TABLE_ENTRY}.name_index", "src=eiffel:?class=PE_FIELD_TABLE_ENTRY&feature=name_index"
			EIS: "name={PE_FIELD_TABLE_ENTRY}.signature_index", "src=eiffel:?class=PE_FIELD_TABLE_ENTRY&feature=signature_index"

		local
			string_offset_size, blob_offset_size: NATURAL_32
		do
				-- Name
			if strings_heap_size < 0x1_0000 then
				string_offset_size := 2
			else
				string_offset_size := 4
			end

				-- Signature
			if blob_heap_size < 0x1_0000 then
				blob_offset_size := 2
			else
				blob_offset_size := 4
			end

				-- II.22.15 Field : 0x04
				-- The Field table has the following columns:
				-- 2 : Flags (a 2-byte bitmask of type FieldAttributes, §II.23.1.5)
				-- size of Name (an index into the String heap)
				-- size of Signature (an index into the Blob heap)				
			Result := 2 + string_offset_size + blob_offset_size
		end

	method_def_table_entry_size: NATURAL_32
			-- Compute the table entry size for the MethodDef table
		note
			EIS: "name={PE_METHOD_DEF_TABLE_ENTRY}.rva", "protocol=uri", "src=eiffel:?class=PE_METHOD_DEF_TABLE_ENTRY&feature=rva"
			EIS: "name={PE_METHOD_DEF_TABLE_ENTRY}.impl_flags", "protocol=uri", "src=eiffel:?class=PE_METHOD_DEF_TABLE_ENTRY&feature=impl_flags"
			EIS: "name={PE_METHOD_DEF_TABLE_ENTRY}.flags", "protocol=uri", "src=eiffel:?class=PE_METHOD_DEF_TABLE_ENTRY&feature=flags"
			EIS: "name={PE_METHOD_DEF_TABLE_ENTRY}.name_index", "protocol=uri", "src=eiffel:?class=PE_METHOD_DEF_TABLE_ENTRY&feature=name_index"
			EIS: "name={PE_METHOD_DEF_TABLE_ENTRY}.signature_index", "protocol=uri", "src=eiffel:?class=PE_METHOD_DEF_TABLE_ENTRY&feature=signature_index"
			EIS: "name={PE_METHOD_DEF_TABLE_ENTRY}.param_index", "protocol=uri", "src=eiffel:?class=PE_METHOD_DEF_TABLE_ENTRY&feature=param_index"
		local
			index_size, string_heap_offset_size, blob_heap_offset_size: NATURAL_32
		do
				-- param_index
			if pe_index < 0x1_0000 then
				index_size := 2
			else
				index_size := 4
			end

				-- name_index
			if strings_heap_size < 0x1_0000 then
				string_heap_offset_size := 2
			else
				string_heap_offset_size := 4
			end

				-- signature_index
			if blob_heap_size < 0x1_0000 then
				blob_heap_offset_size := 2
			else
				blob_heap_offset_size := 4
			end
				-- Size of rva column 4
				-- Size of impl_flags column 2
				-- Size of flags column 2
				-- 8
				-- II.22.26 MethodDef : 0x06
				-- The MethodDef table has the following columns:
				-- 4: RVA (a 4-byte constant)
				-- 2:  ImplFlags (a 2-byte bitmask of type MethodImplAttributes, §II.23.1.10)
				-- 2: Flags (a 2-byte bitmask of type MethodAttributes, §II.23.1.10)
				-- Name (an index into the String heap)
				-- Signature (an index into the Blob heap)
				-- ParamList (an index into the Param table).
				--		It marks the first of a contiguous run of Parameters owned by this method.
				--		The run continues to the smaller of:
				--  	 - the last row of the Param table
				--  	 - the next run of Parameters, found by inspecting the ParamList of the next row in the MethodDef table

			Result := (4 + 2 + 2).to_natural_32
					+ string_heap_offset_size
					+ blob_heap_offset_size
					+ index_size
		end

	param_table_entry_size: NATURAL_32
			-- Compute the table entry size for the Param table
		note
			EIS: "name={PE_PARAM_TABLE_ENTRY}.flags", "protocol=uri", "src=eiffel:?class=PE_PARAM_TABLE_ENTRY&feature=flags"
			EIS: "name={PE_PARAM_TABLE_ENTRY}.sequence_index", "protocol=uri", "src=eiffel:?class=PE_PARAM_TABLE_ENTRY&feature=sequence_index"
			EIS: "name={PE_PARAM_TABLE_ENTRY}.name_index", "protocol=uri", "src=eiffel:?class=PE_PARAM_TABLE_ENTRY&feature=name_index"
		local
			string_index_size: NATURAL_32
		do
				-- name_index
			if strings_heap_size < 0x1_0000 then
				string_index_size := 2
			else
				string_index_size := 4
			end

				--	II.22.33 Param : 0x08
				--	The Param table has the following columns:
				--	2 : Flags (a 2-byte bitmask of type ParamAttributes, §II.23.1.13)
				--	2 : Sequence (a 2-byte constant)
				--	size of Name (an index into the String heap)

			Result := (2 + 2).to_natural_32 + string_index_size
		end

	interface_impl_table_entry_size: NATURAL_32
			-- Compute the table entry size for the InterfaceImpl table
		note
			EIS: "name={PE_INTERFACE_IMPL_TABLE_ENTRY}.class_", "protocol=uri", "src=eiffel:?class=PE_INTERFACE_IMPL_TABLE_ENTRY&feature=class_"
			EIS: "name={PE_INTERFACE_IMPL_TABLE_ENTRY}.interface", "protocol=uri", "src=eiffel:?class=PE_INTERFACE_IMPL_TABLE_ENTRY&feature=interface"
			-- Compute the table entry size for the InterfaceImpl table
		local
			index_size: NATURAL_32
		do
			if pe_index < 0x1_0000 then
				index_size := 2
			else
				index_size := 4
			end

				-- II.22.23 InterfaceImpl : 0x09
				-- The InterfaceImpl table has the following columns:
				--  size of Class (an index into the TypeDef table)
				--  size of Interface (an index into the TypeDef, TypeRef, or TypeSpec table; more precisely, a TypeDefOrRef (§II.24.2.6) coded index)				
			Result := 2 * index_size
		end

	member_ref_table_entry_size: NATURAL_32
			-- Compute the table entry size for the MemberRef table
		note
			EIS: "name={PE_MEMBER_REF_TABLE_ENTRY}.parent_index", "protocol=uri", "src=eiffel:?class=PE_MEMBER_REF_TABLE_ENTRY&feature=parent_index"
			EIS: "name={PE_MEMBER_REF_TABLE_ENTRY}.name_index", "protocol=uri", "src=eiffel:?class=PE_MEMBER_REF_TABLE_ENTRY&feature=name_index"
			EIS: "name={PE_MEMBER_REF_TABLE_ENTRY}.signature", "protocol=uri", "src=eiffel:?class=PE_MEMBER_REF_TABLE_ENTRY&feature=signature"
		local
			index_size, string_heap_offset_size, blob_heap_offset_size: NATURAL_32
		do
				-- parent_index or class_index see spec.
			if pe_index < 0x1_0000 then
				index_size := 2
			else
				index_size := 4
			end

				-- name_index
			if strings_heap_size < 0x1_0000 then
				string_heap_offset_size := 2
			else
				string_heap_offset_size := 4
			end

				-- signature_index
			if blob_heap_size < 0x1_0000 then
				blob_heap_offset_size := 2
			else
				blob_heap_offset_size := 4
			end

				-- II.22.25 MemberRef : 0x0A
				-- The MemberRef table combines two sorts of references, to Methods and to Fields of a class,
				-- known as ‘MethodRef’ and ‘FieldRef’, respectively.
				-- The MemberRef table has the following columns:
				--   Class (an index into the MethodDef, ModuleRef,TypeDef, TypeRef, or TypeSpec tables;
				--			more precisely, a MemberRefParent (§II.24.2.6) coded index)
				--   Name (an index into the String heap)
				--   Signature (an index into the Blob heap)			

			Result := index_size + string_heap_offset_size + blob_heap_offset_size
		end

	constant_table_entry_size: NATURAL_32
			-- Compute the table entry size for the Constant table
		note
			EIS: "name={PE_CONSTANT_TABLE_ENTRY}.type", "protocol=uri", "src=eiffel:?class=PE_CONSTANT_TABLE_ENTRY&feature=type"
			EIS: "name={PE_CONSTANT_TABLE_ENTRY}.parent_index", "protocol=uri", "src=eiffel:?class=PE_CONSTANT_TABLE_ENTRY&feature=parent_index"
			EIS: "name={PE_CONSTANT_TABLE_ENTRY}.value_index", "protocol=uri", "src=eiffel:?class=PE_CONSTANT_TABLE_ENTRY&feature=value_index"
		local
			index_size, blob_heap_offset_size: NATURAL_32
		do
				-- parent_index
			if pe_index < 0x1_0000 then
				index_size := 2
			else
				index_size := 4
			end

				-- value_index
			if blob_heap_size < 0x1_0000 then
				blob_heap_offset_size := 2
			else
				blob_heap_offset_size := 4
			end

				-- Size of type column 2 (1 byte for the constant and 1 byte for padding)
				-- 2
			Result := 2 + index_size + blob_heap_offset_size
		end

	custom_attribute_table_entry_size: NATURAL_32
			-- Compute the table entry size for the CustomAttribute table
		note
			EIS: "name={PE_CUSTOM_ATTRIBUTE_TABLE_ENTRY}.parent_index", "protocol=uri", "src=eiffel:?class=PE_CUSTOM_ATTRIBUTE_TABLE_ENTRY&feature=parent_index"
			EIS: "name={PE_CUSTOM_ATTRIBUTE_TABLE_ENTRY}.type_index", "protocol=uri", "src=eiffel:?class=PE_CUSTOM_ATTRIBUTE_TABLE_ENTRY&feature=type_index"
			EIS: "name={PE_CUSTOM_ATTRIBUTE_TABLE_ENTRY}.value_index", "protocol=uri", "src=eiffel:?class=PE_CUSTOM_ATTRIBUTE_TABLE_ENTRY&feature=value_index"
		local
			index_size, blob_heap_offset_size: NATURAL_32
		do
				-- parent_index and type_index
			if pe_index < 0x1_0000 then
				index_size := 2
			else
				index_size := 4
			end

				-- value_index
			if blob_heap_size < 0x1_0000 then
				blob_heap_offset_size := 2
			else
				blob_heap_offset_size := 4
			end

				-- II.22.10 CustomAttribute : 0x0C
				-- The CustomAttribute table has the following columns:
				-- size of Parent (an index into a metadata table that has an associated HasCustomAttribute (§II.24.2.6) coded index).
				-- size of Type (an index into the MethodDef or MemberRef table; more precisely, a CustomAttributeType (§II.24.2.6) coded index).
				-- size of Value (an index into the Blob heap)

			Result := 2 * index_size + blob_heap_offset_size
		end

	field_marshal_table_entry_size: NATURAL_32
			-- Compute the table entry size for the FieldMarshal table
		note
			EIS: "name={PE_FIELD_MARSHAL_TABLE_ENTRY}.parent", "protocol=uri", "src=eiffel:?class=PE_FIELD_MARSHAL_TABLE_ENTRY&feature=parent"
			EIS: "name={PE_FIELD_MARSHAL_TABLE_ENTRY}.native_type", "protocol=uri", "src=eiffel:?class=PE_FIELD_MARSHAL_TABLE_ENTRY&feature=native_type"
		local
			index_size, blob_heap_offset_size: NATURAL_32
		do
			if pe_index < 0x1_0000 then
				index_size := 2
			else
				index_size := 4
			end

				-- native_type
			if blob_heap_size < 0x1_0000 then
				blob_heap_offset_size := 2
			else
				blob_heap_offset_size := 4
			end

			Result := index_size + blob_heap_offset_size
		end

	decl_security_table_entry_size: NATURAL_32
			-- Compute the table entry size for the DeclSecurity table
		note
			EIS: "name={PE_DECL_SECURITY_TABLE_ENTRY}.action", "protocol=uri", "src=eiffel:?class=PE_DECL_SECURITY_TABLE_ENTRY&feature=action"
			EIS: "name={PE_DECL_SECURITY_TABLE_ENTRY}.parent", "protocol=uri", "src=eiffel:?class=PE_DECL_SECURITY_TABLE_ENTRY&feature=parent"
			EIS: "name={PE_DECL_SECURITY_TABLE_ENTRY}.permission_set", "protocol=uri", "src=eiffel:?class=PE_DECL_SECURITY_TABLE_ENTRY&feature=permission_set"
		local
			index_size, blob_heap_offset_size: NATURAL_32
		do
			if pe_index < 0x1_0000 then
				index_size := 2
			else
				index_size := 4
			end
				-- permission_set
			if blob_heap_size < 0x1_0000 then
				blob_heap_offset_size := 2
			else
				blob_heap_offset_size := 4
			end

				-- 2 bytes for action column + sizes of parent and permissionSet columns
			Result := 2 + index_size + blob_heap_offset_size
		end

	class_layout_table_entry_size: NATURAL_32
			-- Compute the table entry size for the ClassLayout table
		note
			EIS: "name={PE_CLASS_LAYOUT_TABLE_ENTRY}.pack", "protocol=uri", "src=eiffel:?class=PE_CLASS_LAYOUT_TABLE_ENTRY&feature=pack"
			EIS: "name={PE_CLASS_LAYOUT_TABLE_ENTRY}.size", "protocol=uri", "src=eiffel:?class=PE_CLASS_LAYOUT_TABLE_ENTRY&feature=size"
			EIS: "name={PE_CLASS_LAYOUT_TABLE_ENTRY}.parent", "protocol=uri", "src=eiffel:?class=PE_CLASS_LAYOUT_TABLE_ENTRY&feature=parent"
		local
			index_size: NATURAL_32
		do
			if pe_index < 0x1_0000 then
				index_size := 2
			else
				index_size := 4
			end

				-- -- 2 bytes for pack column + 4 bytes for size (class size) column + size of parent column
			Result := {NATURAL_32} 2 + 4 + index_size
		end

	field_layout_table_entry_size: NATURAL_32
			-- Compute the table entry size for the FieldLayout table
		note
			EIS: "name={PE_FIELD_LAYOUT_TABLE_ENTRY}.offset", "protocol=uri", "src=eiffel:?class=PE_FIELD_LAYOUT_TABLE_ENTRY&feature=offset"
			EIS: "name={PE_FIELD_LAYOUT_TABLE_ENTRY}.parent", "protocol=uri", "src=eiffel:?class=PE_FIELD_LAYOUT_TABLE_ENTRY&feature=parent"
		local
			index_size: NATURAL_32
		do
			if pe_index < 0x1_0000 then
				index_size := 2
			else
				index_size := 4
			end
				-- 4 bytes for offset column + size of parent column
			Result := 4 + index_size
		end

	standalone_sig_table_entry_size: NATURAL_32
			-- Compute the table entry size for the StandAloneSig table.
		note
			EIS: "name={PE_STANDALONE_SIG_TABLE_ENTRY}.signature_index", "protocol=uri", "src=eiffel:?class=PE_STANDALONE_SIG_TABLE_ENTRY&feature=signature_index"
		local
			index_blob_size: NATURAL_32
		do
			if blob_heap_size < 0x1_0000 then
				index_blob_size := 2
			else
				index_blob_size := 4
			end
			Result := index_blob_size
		end

	property_map_table_entry_size: NATURAL_32
			-- Compute the size of a single entry in the PropertyMap table
		note
			EIS: "name={PE_PROPERTY_MAP_TABLE_ENTRY}.parent", "protocol=uri", "src=eiffel:?class=PE_PROPERTY_MAP_TABLE_ENTRY&feature=parent"
			EIS: "name={PE_PROPERTY_MAP_TABLE_ENTRY}.property_list", "protocol=uri", "src=eiffel:?class=PE_PROPERTY_MAP_TABLE_ENTRY&feature=property_list"
		local
			index_size: NATURAL_32
		do
				-- parent and property_list
			if pe_index < 0x1_0000 then
				index_size := 2
			else
				index_size := 4
			end

			Result := 2 * index_size
		end

	property_table_entry_size: NATURAL_32
			-- Compute the size of a single entry in the Property table
		note
			EIS: "name={PE_PROPERTY_TABLE_ENTRY}.flags", "protocol=uri", "src=eiffel:?class=PE_PROPERTY_TABLE_ENTRY&feature=flags"
			EIS: "name={PE_PROPERTY_TABLE_ENTRY}.name", "protocol=uri", "src=eiffel:?class=PE_PROPERTY_TABLE_ENTRY&feature=name"
			EIS: "name={PE_PROPERTY_TABLE_ENTRY}.property_type", "protocol=uri", "src=eiffel:?class=PE_PROPERTY_TABLE_ENTRY&feature=property_type"

		local
			name_index_size, type_index_size: NATURAL_32
		do
			if strings_heap_size < 0x1_0000 then
				name_index_size := 2
			else
				name_index_size := 4
			end

			if blob_heap_size < 0x1_0000 then
				type_index_size := 2
			else
				type_index_size := 4
			end
				-- 2 bytes for flag	+ name index and type index

				--	The Property ( 0x17 ) table has the following columns:
				--	2 : Flags (a 2-byte bitmask of type PropertyAttributes, §II.23.1.14)
				--	size of Name (an index into the String heap)
				--	size of Type (an index into the Blob heap) (The name of this column is misleading. It does
				--			not index a TypeDef or TypeRef table—instead it indexes the signature in the Blob
				--			heap of the Property)				
			Result := 2 + name_index_size + type_index_size
		end

	method_semantics_table_entry_size: NATURAL_32
			-- Compute the size of a single entry in the MethodSemantics table
		note
			EIS: "name={PE_METHOD_SEMANTICS_TABLE_ENTRY}.semantics", "protocol=uri", "src=eiffel:?class=PE_METHOD_SEMANTICS_TABLE_ENTRY&feature=semantics"
			EIS: "name={PE_METHOD_SEMANTICS_TABLE_ENTRY}.method", "protocol=uri", "src=eiffel:?class=PE_METHOD_SEMANTICS_TABLE_ENTRY&feature=method"
			EIS: "name={PE_METHOD_SEMANTICS_TABLE_ENTRY}.association", "protocol=uri", "src=eiffel:?class=PE_METHOD_SEMANTICS_TABLE_ENTRY&feature=association"

		local
			index_size: NATURAL_32
		do
				-- method and association
			if pe_index < 0x1_0000 then
				index_size := 2
			else
				index_size := 4
			end
				-- 2 bytes for semantics column.
			Result := 2 + 2 * index_size
		end

	method_impl_table_entry_size: NATURAL_32
			-- Compute the size of a single entry in the MethodImpl table
		note
			EIS: "name={PE_METHOD_IMPL_TABLE_ENTRY}.class_", "protocol=uri", "src=eiffel:?class=PE_METHOD_IMPL_TABLE_ENTRY&feature=class_"
			EIS: "name={PE_METHOD_IMPL_TABLE_ENTRY}.method_body", "protocol=uri", "src=eiffel:?class=PE_METHOD_IMPL_TABLE_ENTRY&feature=method_body"
			EIS: "name={PE_METHOD_IMPL_TABLE_ENTRY}.method_declaration", "protocol=uri", "src=eiffel:?class=PE_METHOD_IMPL_TABLE_ENTRY&feature=method_declaration"

		local
			index_size: NATURAL_32
		do
			if pe_index < 0x1_0000 then
				index_size := 2
			else
				index_size := 4
			end

				--II.22.27 MethodImpl : 0x19
				-- Class (an index into the TypeDef table)
				-- MethodBody (an index into the MethodDef or MemberRef table; more precisely, a MethodDefOrRef (§II.24.2.6) coded index)
				-- MethodDeclaration (an index into the MethodDef or MemberRef table; more precisely, a MethodDefOrRef (§II.24.2.6) coded index)

			Result := 3 * index_size
		end

	module_ref_table_entry_size: NATURAL_32
			-- Compute the size of a single entry in the ModuleRef table.
		note
			EIS: "name={PE_MODULE_REF_TABLE_ENTRY}.name_index", "protocol=uri", "src=eiffel:?class=PE_MODULE_REF_TABLE_ENTRY&feature=name_index"
		local
			name_index_size: NATURAL_32
		do
			if strings_heap_size < 0x1_0000 then
				name_index_size := 2
			else
				name_index_size := 4
			end
				-- II.22.31 ModuleRef : 0x1A
				-- The ModuleRef table has the following column:
				--  Name (an index into the String heap)			
			Result := name_index_size
		end

	type_spec_table_entry_size: NATURAL_32
			-- Compute the table entry size for the TypeSpec table
		note
			EIS: "name={PE_TYPE_SPEC_TABLE_ENTRY}.signature_index", "protocol=uri", "src=eiffel:?class=PE_TYPE_SPEC_TABLE_ENTRY&feature=signature_index"
		local
			index_size: NATURAL_32
		do
			if blob_heap_size < 0x1_0000 then
				index_size := 2
			else
				index_size := 4
			end
				-- size of Signature column (an index into the Blob heap)
			Result := index_size
		end

	impl_map_table_entry_size: NATURAL_32
			-- Compute the table entry size for the ImplMap table.
		note
			EIS: "name={PE_IMPL_MAP_TABLE_ENTRY}.flags", "protocol=uri", "src=eiffel:?class=PE_IMPL_MAP_TABLE_ENTRY&feature=flags"
			EIS: "name={PE_IMPL_MAP_TABLE_ENTRY}.method_index", "protocol=uri", "src=eiffel:?class=PE_IMPL_MAP_TABLE_ENTRY&feature=method_index"
			EIS: "name={PE_IMPL_MAP_TABLE_ENTRY}.import_name_index", "protocol=uri", "src=eiffel:?class=PE_IMPL_MAP_TABLE_ENTRY&feature=import_name_index"
			EIS: "name={PE_IMPL_MAP_TABLE_ENTRY}.module_index", "protocol=uri", "src=eiffel:?class=PE_IMPL_MAP_TABLE_ENTRY&feature=module_index"
		local
			index_size, string_index_size: NATURAL_32
		do
				-- method_index MemberForwarded and
				-- module_index ImportScope
			if pe_index < 0x1_0000 then
				index_size := 2
			else
				index_size := 4
			end

				-- import_name_index Index ImportName
			if strings_heap_size < 0x1_0000 then
				string_index_size := 2
			else
				string_index_size := 4
			end

				-- 2 bytes for MappingFlags column + size of MemberForwarded column + size of ImportName column + size of ImportScope column
			Result := 2 + 2 * index_size + string_index_size
		end

	field_rva_table_entry_size: NATURAL_32
			-- Compute the table entry size for the FieldRVA table
		note
			EIS: "name={PE_FIELD_RVA_TABLE_ENTRY}.rva", "protocol=uri", "src=eiffel:?class=PE_FIELD_RVA_TABLE_ENTRY&feature=rva"
			EIS: "name={PE_FIELD_RVA_TABLE_ENTRY}.field_index", "protocol=uri", "src=eiffel:?class=PE_FIELD_RVA_TABLE_ENTRY&feature=field_index"
		local
			index_size: NATURAL_32
		do
			if pe_index < 0x1_0000 then
				index_size := 2
			else
				index_size := 4
			end
				-- -- 4 bytes for RVA column + size of Field column
			Result := 4 + index_size
		end

	assembly_table_entry_size: NATURAL_32
			-- Compute the table entry size for the Assembly table
			-- II.22.2 Assembly : 0x20
		note
			EIS: "name={PE_ASSEMBLY_TABLE_ENTRY}.hash_alg_id", "protocol=uri", "src=eiffel:?class=PE_ASSEMBLY_TABLE_ENTRY&feature=hash_alg_id"
			EIS: "name={PE_ASSEMBLY_TABLE_ENTRY}.major", "protocol=uri", "src=eiffel:?class=PE_ASSEMBLY_TABLE_ENTRY&feature=major"
			EIS: "name={PE_ASSEMBLY_TABLE_ENTRY}.minor", "protocol=uri", "src=eiffel:?class=PE_ASSEMBLY_TABLE_ENTRY&feature=minor"
			EIS: "name={PE_ASSEMBLY_TABLE_ENTRY}.build", "protocol=uri", "src=eiffel:?class=PE_ASSEMBLY_TABLE_ENTRY&feature=build"
			EIS: "name={PE_ASSEMBLY_TABLE_ENTRY}.revision", "protocol=uri", "src=eiffel:?class=PE_ASSEMBLY_TABLE_ENTRY&feature=revision"
			EIS: "name={PE_ASSEMBLY_TABLE_ENTRY}.flags", "protocol=uri", "src=eiffel:?class=PE_ASSEMBLY_TABLE_ENTRY&feature=flags"
			EIS: "name={PE_ASSEMBLY_TABLE_ENTRY}.public_key", "protocol=uri", "src=eiffel:?class=PE_ASSEMBLY_TABLE_ENTRY&feature=public_key"
			EIS: "name={PE_ASSEMBLY_TABLE_ENTRY}.name_index", "protocol=uri", "src=eiffel:?class=PE_ASSEMBLY_TABLE_ENTRY&feature=name_index"
			EIS: "name={PE_ASSEMBLY_TABLE_ENTRY}.culture_index", "protocol=uri", "src=eiffel:?class=PE_ASSEMBLY_TABLE_ENTRY&feature=culture_index"
		local
			blob_index_size, string_index_size: NATURAL_32
		do
				-- PublicKey
			if blob_heap_size < 0x1_0000 then
				blob_index_size := 2
			else
				blob_index_size := 4
			end
				-- Name and Culture.
			if strings_heap_size < 0x1_0000 then
				string_index_size := 2
			else
				string_index_size := 4
			end
				-- II.22.2 Assembly : 0x20
				-- The Assembly table has the following columns:
				-- 4 : HashAlgId (a 4-byte constant of type AssemblyHashAlgorithm, §II.23.1.1)
				-- 4 * 2: MajorVersion, MinorVersion, BuildNumber, RevisionNumber (each being 2-byte constants)
				-- 4 : Flags (a 4-byte bitmask of type AssemblyFlags, §II.23.1.2)
				-- size of PublicKey (an index into the Blob heap)
				-- size of Name (an index into the String heap)
				-- size of Culture (an index into the String heap)
			Result := (4 + (2 * 4) + 4).to_natural_32 + blob_index_size + 2 * string_index_size
		end

	assembly_ref_table_entry_size: NATURAL_32
			-- Compute the table entry size for the AssemblyRef table
		note
			EIS: "name={PE_ASSEMBLY_REF_TABLE_ENTRY}.major", "protocol=uri", "src=eiffel:?class=PE_ASSEMBLY_REF_TABLE_ENTRY&feature=major"
			EIS: "name={PE_ASSEMBLY_REF_TABLE_ENTRY}.minor", "protocol=uri", "src=eiffel:?class=PE_ASSEMBLY_REF_TABLE_ENTRY&feature=minor"
			EIS: "name={PE_ASSEMBLY_REF_TABLE_ENTRY}.build", "protocol=uri", "src=eiffel:?class=PE_ASSEMBLY_REF_TABLE_ENTRY&feature=build"
			EIS: "name={PE_ASSEMBLY_REF_TABLE_ENTRY}.revision", "protocol=uri", "src=eiffel:?class=PE_ASSEMBLY_REF_TABLE_ENTRY&feature=revision"
			EIS: "name={PE_ASSEMBLY_REF_TABLE_ENTRY}.flags", "protocol=uri", "src=eiffel:?class=PE_ASSEMBLY_REF_TABLE_ENTRY&feature=flags"
			EIS: "name={PE_ASSEMBLY_REF_TABLE_ENTRY}.public_key_index", "protocol=uri", "src=eiffel:?class=PE_ASSEMBLY_REF_TABLE_ENTRY&feature=public_key_index"
			EIS: "name={PE_ASSEMBLY_REF_TABLE_ENTRY}.name_index", "protocol=uri", "src=eiffel:?class=PE_ASSEMBLY_REF_TABLE_ENTRY&feature=name_index"
			EIS: "name={PE_ASSEMBLY_REF_TABLE_ENTRY}.culture_index", "protocol=uri", "src=eiffel:?class=PE_ASSEMBLY_REF_TABLE_ENTRY&feature=culture_index"
			EIS: "name={PE_ASSEMBLY_REF_TABLE_ENTRY}.hash_index", "protocol=uri", "src=eiffel:?class=PE_ASSEMBLY_REF_TABLE_ENTRY&feature=hash_index"
		local
			blob_index_size, string_index_size: NATURAL_32
		do
				-- public_key_index
				-- hash_index
			if blob_heap_size < 0x1_0000 then
				blob_index_size := 2
			else
				blob_index_size := 4
			end
				-- name_index
				-- culture_index
			if strings_heap_size < 0x1_0000 then
				string_index_size := 2
			else
				string_index_size := 4
			end

				-- II.22.5 AssemblyRef : 0x23
				-- The AssemblyRef table has the following columns:
				-- 4 * 2 : MajorVersion, MinorVersion, BuildNumber, RevisionNumber (each being 2-byte constants)
				-- 4 : Flags (a 4-byte bitmask of type AssemblyFlags, §II.23.1.2)
				-- size of PublicKeyOrToken (an index into the Blob heap, indicating the public key or token that identifies the author of this Assembly)
				-- size of Name (an index into the String heap)
				-- size of Culture (an index into the String heap)
				-- size of HashValue (an index into the Blob heap)				

			Result := (4 * 2 + 4).to_natural_32
					+ 2 * blob_index_size
					+ 2 * string_index_size
		end

	file_table_entry_size: NATURAL_32
			-- Compute the table entry size for the File table
		note
			EIS: "name={PE_FILE_TABLE_ENTRY}.flags", "protocol=uri", "src=eiffel:?class=PE_FILE_TABLE_ENTRY&feature=flags"
			EIS: "name={PE_FILE_TABLE_ENTRY}.name", "protocol=uri", "src=eiffel:?class=PE_FILE_TABLE_ENTRY&feature=name"
			EIS: "name={PE_FILE_TABLE_ENTRY}.hash", "protocol=uri", "src=eiffel:?class=PE_FILE_TABLE_ENTRY&feature=hash"
		local
			blob_offset_size, string_offset_size: NATURAL_32
		do
				-- Name
			if strings_heap_size < 0x1_0000 then
				string_offset_size := 2
			else
				string_offset_size := 4
			end

				-- Hash Value
			if blob_heap_size < 0x1_0000 then
				blob_offset_size := 2
			else
				blob_offset_size := 4
			end

				-- Flags (a 4-byte bitmask of type FileAttributes)
				-- Name (an index into the String heap)
				-- HashValue (an index into the Blob heap)
			Result := 4 + string_offset_size + blob_offset_size
		end

	exported_type_table_entry_size: NATURAL_32
			-- Compute the table entry size for the ExportedType table
		note
			EIS: "name={PE_EXPORTED_TYPE_TABLE_ENTRY}.flags", "protocol=uri", "src=eiffel:?class=PE_EXPORTED_TYPE_TABLE_ENTRY&feature=flags"
			EIS: "name={PE_EXPORTED_TYPE_TABLE_ENTRY}.type_def_id", "protocol=uri", "src=eiffel:?class=PE_EXPORTED_TYPE_TABLE_ENTRY&feature=type_def_id"
			EIS: "name={PE_EXPORTED_TYPE_TABLE_ENTRY}.type_name", "protocol=uri", "src=eiffel:?class=PE_EXPORTED_TYPE_TABLE_ENTRY&feature=type_name"
			EIS: "name={PE_EXPORTED_TYPE_TABLE_ENTRY}.type_name_space", "protocol=uri", "src=eiffel:?class=PE_EXPORTED_TYPE_TABLE_ENTRY&feature=type_name_space"
			EIS: "name={PE_EXPORTED_TYPE_TABLE_ENTRY}.implementation", "protocol=uri", "src=eiffel:?class=PE_EXPORTED_TYPE_TABLE_ENTRY&feature=implementation"
		local
			string_offset_size, index_size: NATURAL_32
		do
				-- TypeName and TypeNamespace
			if strings_heap_size < 0x1_0000 then
				string_offset_size := 2
			else
				string_offset_size := 4
			end

				-- Implementation
			if pe_index < 0x1_0000 then
				index_size := 2
			else
				index_size := 4
			end

				-- II.22.14 ExportedType : 0x27
				-- The ExportedType table has the following columns:
				-- 4: Flags (a 4-byte bitmask of type TypeAttributes, §II.23.1.15)
				-- 4: TypeDefId (a 4-byte index into a TypeDef table of another module in this Assembly).
				-- 		This column is used as a hint only. If the entry in the target TypeDef table matches
				-- 		the TypeName and TypeNamespace entries in this table, resolution has succeeded.
				-- 		But if there is a mismatch, the CLI shall fall back to a search of the target TypeDef
				-- 		table. Ignored and should be zero if Flags has IsTypeForwarder set.
				-- size of TypeName (an index into the String heap)
				-- size of TypeNamespace (an index into the String heap)
				-- size of Implementation. This is an index (more precisely, an Implementation (§II.24.2.6) coded index)
				--     into either of the following tables:
				--   - File table, where that entry says which module in the current assembly holds the TypeDef
				--   - ExportedType table, where that entry is the enclosing Type of the current nested Type
				--   - AssemblyRef table, where that entry says in which assembly the type may now be found (Flags must have the IsTypeForwarder flag set).				

			Result := (4 + 4).to_natural_32
						+ 2 * string_offset_size -- TypeName, TypeNamespace
						+ index_size -- Implementation
		end

	manifest_resource_table_entry_size: NATURAL_32
			-- Compute the table entry size for the ManifestResource table
		note
			EIS: "name={PE_MANIFEST_RESOURCE_TABLE_ENTRY}.offset", "protocol=uri", "src=eiffel:?class=PE_MANIFEST_RESOURCE_TABLE_ENTRY&feature=offset"
			EIS: "name={PE_MANIFEST_RESOURCE_TABLE_ENTRY}.flags", "protocol=uri", "src=eiffel:?class=PE_MANIFEST_RESOURCE_TABLE_ENTRY&feature=flags"
			EIS: "name={PE_MANIFEST_RESOURCE_TABLE_ENTRY}.name", "protocol=uri", "src=eiffel:?class=PE_MANIFEST_RESOURCE_TABLE_ENTRY&feature=name"
			EIS: "name={PE_MANIFEST_RESOURCE_TABLE_ENTRY}.implementation", "protocol=uri", "src=eiffel:?class=PE_MANIFEST_RESOURCE_TABLE_ENTRY&feature=implementation"

		local
			string_offset_size, index_size: NATURAL_32
		do
				-- Name
			if strings_heap_size < 0x1_0000 then
				string_offset_size := 2
			else
				string_offset_size := 4
			end

				-- Implementation
			if pe_index < 0x1_0000 then
				index_size := 2
			else
				index_size := 4
			end

				-- Offset (a 4-byte constant)
				-- Flags (a 4-byte bitmask of type ManifestResourceAttributes)
				-- Name (an index into the String heap)
				-- Implementation (an Implementation coded index into either the File table,
				-- the AssemblyRef table, or null)
			Result := {NATURAL_32} 4 + 4 + string_offset_size + index_size
		end

	nested_class_table_entry_size: NATURAL_32
			-- Compute the table entry size for the NestedClass table
		note
			EIS: "name={PE_NESTED_CLASS_TABLE_ENTRY}.nested_index", "protocol=uri", "src=eiffel:?class=PE_NESTED_CLASS_TABLE_ENTRY&feature=nested_index"
			EIS: "name={PE_NESTED_CLASS_TABLE_ENTRY}.enclosing_index", "protocol=uri", "src=eiffel:?class=PE_NESTED_CLASS_TABLE_ENTRY&feature=enclosing_index"
		local
			index_size: NATURAL_32
		do
				-- NestedClass and EnclosingClass
			if pe_index < 0x1_0000 then
				index_size := 2
			else
				index_size := 4
			end

				-- NestedClass (an index into the TypeDef table)
				-- EnclosingClass (an index into the TypeDef table)
			Result := 2 * index_size
		end

	generic_param_table_entry_size: NATURAL_32
			-- Compute the table entry size for the GenericParam table
		note
			EIS: "name={PE_GENERIC_PARAM_TABLE_ENTRY}.number", "protocol=uri", "src=eiffel:?class=PE_GENERIC_PARAM_TABLE_ENTRY&feature=number"
			EIS: "name={PE_GENERIC_PARAM_TABLE_ENTRY}.flags", "protocol=uri", "src=eiffel:?class=PE_GENERIC_PARAM_TABLE_ENTRY&feature=flags"
			EIS: "name={PE_GENERIC_PARAM_TABLE_ENTRY}.owner", "protocol=uri", "src=eiffel:?class=PE_GENERIC_PARAM_TABLE_ENTRY&feature=owner"
			EIS: "name={PE_GENERIC_PARAM_TABLE_ENTRY}.name", "protocol=uri", "src=eiffel:?class=PE_GENERIC_PARAM_TABLE_ENTRY&feature=name"
		local
			string_offset_size, index_size: NATURAL_32
		do
				-- Name
			if strings_heap_size < 0x1_0000 then
				string_offset_size := 2
			else
				string_offset_size := 4
			end

				-- Owner
			if pe_index < 0x1_0000 then
				index_size := 2
			else
				index_size := 4
			end

				-- Number (a 2-byte index of the generic parameter)
				-- Flags (a 2-byte bitmask of type GenericParamAttributes)
				-- Owner (a TypeOrMethodDef coded index into the TypeDef or MethodDef table)
				-- Name (an index into the String heap)
			Result := {NATURAL_32} 2 + 2 + index_size + string_offset_size
		end

	method_spec_table_entry_size: NATURAL_32
			-- Compute the table entry size for the MethodSpec table
		note
			EIS: "name={PE_METHOD_SPEC_TABLE_ENTRY}.method", "protocol=uri", "src=eiffel:?class=PE_METHOD_SPEC_TABLE_ENTRY&feature=method"
			EIS: "name={PE_METHOD_SPEC_TABLE_ENTRY}.instantiation", "protocol=uri", "src=eiffel:?class=PE_METHOD_SPEC_TABLE_ENTRY&feature=instantiation"
		local
			blob_offset_size, index_size: NATURAL_32
		do
				-- Instantiation
			if blob_heap_size < 0x1_0000 then
				blob_offset_size := 2
			else
				blob_offset_size := 4
			end

				-- Method
			if pe_index < 0x1_0000 then
				index_size := 2
			else
				index_size := 4
			end

				-- Method (a MethodDefOrRef coded index into the MethodDef or MemberRef table)
				-- Instantiation (an index into the Blob heap)
			Result := index_size + blob_offset_size
		end

	generic_param_constraint_table_entry_size: NATURAL_32
			-- Compute the table entry size for the GenericParamConstraint table
		note
			EIS: "name={PE_GENERIC_PARAM_CONSTRAINTS_TABLE_ENTRY}.owner", "protocol=uri", "src=eiffel:?class=PE_GENERIC_PARAM_CONSTRAINTS_TABLE_ENTRY&feature=owner"
			EIS: "name={PE_GENERIC_PARAM_CONSTRAINTS_TABLE_ENTRY}.constraint", "protocol=uri", "src=eiffel:?class=PE_GENERIC_PARAM_CONSTRAINTS_TABLE_ENTRY&feature=constraint"
		local
			index_size: NATURAL_32
		do
				-- Owner and Constraint
			if pe_index < 0x1_0000 then
				index_size := 2
			else
				index_size := 4
			end

				-- Owner (an index into the GenericParam table)
				-- Constraint (a TypeDefOrRef coded index into the TypeDef, TypeRef, or TypeSpec tables)
			Result := 2 * index_size
		end

feature -- Heaps

	hash_blob (a_blob_data: ARRAY [NATURAL_8]; a_blob_len: NATURAL_32): NATURAL_32
			-- Computes the hash of a blob `a_blob_data'
			-- if the blob already exists in a heap, returns the index of the existing blob
			-- otherwise computes the hash and returns the index of the new blob.
		do
			Result := check_blob (pe_writer.blob, a_blob_data)
			if Result = 0 then
				Result := pe_writer.hash_blob (a_blob_data, a_blob_len)
			end
		ensure
			hashed: Result = check_blob (pe_writer.blob, a_blob_data)
		end

	hash_us (a_str: STRING_32; a_len: INTEGER): NATURAL_32
			-- Converts a UTF-16 string `a_str` to UTF-8, checks for an existing hash value,
			-- and calculates a new hash value if necessary.
			-- To replace the use of {PE_WRITER}.hash_us
		local
			l_converter: BYTE_ARRAY_CONVERTER
		do
			create l_converter.make_from_string ({UTF_CONVERTER}.utf_32_string_to_utf_16le_string_8 (a_str))
			Result := check_us (pe_writer.us, l_converter.to_natural_8_array)
			if Result = 0 then
				Result := pe_writer.hash_us (a_str, a_len)
			end
		ensure
			hashed: check_us (pe_writer.us, (create {BYTE_ARRAY_CONVERTER}.make_from_string ({UTF_CONVERTER}.utf_32_string_to_utf_16le_string_8 (a_str))).to_natural_8_array) = Result
		end

	check_blob (blob: PE_POOL; target_blob: ARRAY [NATURAL_8]): NATURAL_32
			-- Check if `target_blob` exists in `blob_heap` and return its index if found, otherwise return 0.
		local
			blob_heap: SPECIAL [NATURAL_8]
			blob_size: NATURAL_32
			i, j, k, target_size, current_size: INTEGER
		do
--			Result := 0 -- not found (yet)
			blob_heap := blob.base
			blob_size := blob.size
			target_size := target_blob.count
			from
				i := 1 --| 2 - 1  Special are 0-based
			until
				i.to_natural_32 >= blob_size or else Result /= 0
			loop
					-- Check if the blob header matches the target blob size.
				if blob_heap [i] < 0x80 then
					-- 128 = 0x80 = 1000 0000
					current_size := blob_heap [i]
					j := i + 1
				elseif blob_heap [i] < 0xC0 then -- 0xC0 = 1100 0000
					-- 192 = 0xC0  =   1100 0000
					-- 256 = 0x100 = 1 0000 0000
					current_size := (blob_heap [i] - 0x80) * 0x100
									+ blob_heap [i + 1]
					j := i + 2
				else
					-- 16777216 = 0x100 0000 = 1 00000000 00000000 00000000
					-- 65 536 	=   0x1 0000 =          1 00000000 00000000
					-- 256 		=      0x100 =                   1 00000000
					current_size := (blob_heap [i] - 0xC0) * 0x100_0000
									+ blob_heap [i + 1] * 0x1_0000
									+ blob_heap [i + 2] * 0x100
									+ blob_heap [i + 3]
					j := i + 4
				end
					-- Check if the current blob matches the target blob.
				if current_size = target_size then
					from
						k := 1
					until
						(j + k - 1).to_natural_32 > blob_size
						or else k > target_size
						or else target_blob [k] /= blob_heap [j + k - 1]
					loop
						k := k + 1
					end
					if (k - 1) = target_size then
							-- Found a match.
						Result := i.to_natural_32
					end
				end
				i := j + current_size
			end
		ensure
			valid_result: Result >= 0
		end

	check_us (us: PE_POOL; target_us: ARRAY [NATURAL_8]): NATURAL_32
			-- Check if `target_us` exists in `us` and return its index if found, otherwise return 0.
		local
			us_heap: SPECIAL [NATURAL_8]
			us_size: NATURAL_32;
			i, j, k, target_size, current_size: INTEGER
		do
			us_heap := us.base
			us_size := us.size

--			Result := 0 -- not found (yet)

			target_size := target_us.count
			from
					-- note: The first entry in both these heaps is the empty 'blob' that consists of the single byte 0x00.
					-- SPECIAL are 0-based, skip first entry.
				i := 1
			until
				i.to_natural_32 >= us_size or else Result > 0
			loop
					-- Check if the current user string matches the target user string.
				if us_heap [i] < 0x80 then
					-- 128 = 0x80 = 1000 0000
					current_size := us_heap [i]
					j := i + 1
				elseif us_heap [i] < 0xC0 then -- 0xC0 = 1100 0000
					-- 192 = 0xC0  =   1100 0000
					-- 256 = 0x100 = 1 0000 0000
					current_size := (us_heap [i] - 0x80) * 0x100
									+ us_heap [i + 1]
					j := i + 2
				else
					-- 16777216 = 0x100_0000 = 1 00000000 00000000 00000000
					-- 65 536  	=   0x1_0000 =          1 00000000 00000000
					-- 256 		=      0x100 =                   1 00000000
					current_size := (us_heap [i] - 0xC0) * 0x100_0000
									+ us_heap [i + 1] * 0x1_0000
									+ us_heap [i + 2] * 0x100
									+ us_heap [i + 3]
					j := i + 4
				end

					-- Note: the `current_size` for #US includes the final byte 0 or 1.
				if current_size - 1 = target_size then
						-- Exclude the final byte from the comparison: 0 or 1
					from
						k := 1
					until
						(j + k - 1).to_natural_32 >= us_size
						or else k > target_size
						or else target_us [k] /= us_heap [j + k - 1]
					loop
						k := k + 1
					end
					if (k - 1) = target_size then
							-- Found a match.
						Result := i.to_natural_32
					end
				end
				i := j + current_size
			end
		ensure
			valid_result: Result >= 0
		end

end

