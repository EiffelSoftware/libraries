
indexing
	description: "Generated by MATISSE ODL tool (release 4.0.0 of mt_odl)";

class 
	PARAGRAPH

inherit

-- BEGIN generation of inheritance by mt_odl
-- DO NOT MODIFY UNTIL THE 'END of mt_odl generation' MARK BELOW
	DOC_CONTENT
-- END of mt_odl generation of inheritance

create
	make

feature
	make(a_text: STRING) is
		do
			set_text(a_text)
		end
		
-- BEGIN generation of accessors by mt_odl
-- DO NOT MODIFY UNTIL THE 'END of mt_odl generation' MARK BELOW
-- generated with release 4.0.0 of mt_odl (c) from ADB MATISSE
-- Date: Thu Oct 22 19:23:51 1998

feature {NONE}

	text: STRING
	of_section: SECTION
	hyperlinks: MT_LINKED_LIST[DOC_CONTENT]

feature -- Access

	get_text: STRING is
		do
			if is_obsolete or else text = Void then
				text := mt_get_string_by_position(field_position_of_text)
			end
			Result := text
		end

	get_of_section: SECTION is
		do
			if is_obsolete or else of_section = Void then
				of_section ?= mt_get_successor_by_position(field_position_of_of_section)
			end
			Result := of_section
		end

	get_hyperlinks: LINKED_LIST[DOC_CONTENT] is
		do
			if is_persistent then
				hyperlinks.load_successors
			end
			Result := hyperlinks
		end


feature -- Modification

	set_text(new_text: STRING) is
		do
			text := clone(new_text)
			mt_set_string(field_position_of_text)
		end

	set_of_section(new_of_section: SECTION) is
		do
			check_persistence(new_of_section)
			of_section := new_of_section
			mt_set_successor(field_position_of_of_section)
		end



feature {NONE} -- Implementation

	field_position_of_text: INTEGER is
		once
			Result := field_position_of("text")
		end

	field_position_of_of_section: INTEGER is
		once
			Result := field_position_of("of_section")
		end


-- END of mt_odl generation of accessors

--
-- You may add your own code here...
--

end -- class PARAGRAPH

