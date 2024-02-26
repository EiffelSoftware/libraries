Note
	description: "[
					Object representing a PDB stream
				
				Offset	Size	Field						Description
				0		20		PDB id						A byte sequence uniquely representing the debugging metadata blob content.	
				20		4		EntryPoint					Entry point MethodDef token, or 0 if not applicable. The same value as stored in CLI header of the PE file. See ECMA-335-II 15.4.1.2.
				24		8		ReferencedTypeSystemTables	Bit vector of referenced type system metadata tables, let n be the number of bits that are 1.
				32		4*n		TypeSystemTableRows			Array of n 4-byte unsigned integers indicating the number of rows for each referenced type system metadata table.
		]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=pdb stream", "src=https://github.com/dotnet/runtime/blob/main/docs/design/specs/PortablePdb-Metadata.md#pdb-stream", "protocol=uri"

class
	CLI_PDB_STREAM

feature -- Access

	pdb_id: detachable ARRAY [NATURAL_32]
			-- A byte sequence uniquely representing the debugging metadata blob content.
			-- size 20 (5 bytes)

	entry_point: INTEGER_32
			-- Entry point MethodDef token, or 0 if not applicable. The same value as stored in CLI header of the PE file.
			-- See ECMA-335-II 15.4.1.2.

	referenced_type_system_tables: detachable ARRAY [NATURAL_32]
			-- Bit vector of referenced type system metadata tables, let n be the number of bits that are 1.
			-- Size 8 (2 bytes)

	type_system_table_rows: detachable ARRAY [NATURAL_32]
			-- Array of n 4-byte unsigned integers indicating the number of rows for each referenced type system metadata table.

end
