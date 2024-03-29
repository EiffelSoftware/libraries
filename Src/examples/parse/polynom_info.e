note
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Information storage for the Polynomial language

class
	POLYNOM_INFO 

create
	make

feature 

	make
		do
			create id_table.make;
			create id_value.make
		end -- make

	end_session: BOOLEAN

	child_value: INTEGER

feature {NONE}

	id_table: SORTED_TWO_WAY_LIST [STRING]
			-- List of identifiers in the polynom

	id_value: LINKED_LIST [INTEGER]
			-- List of values of the variables of the polynom

feature 

	set_child_value (i: INTEGER)
		do
			child_value := i
		end

	cons_id_table (s: STRING)
			-- Fill the id_table with the identifiers found
			-- in the declarations list.
		do
			if not id_table.has (s) then
				id_table.extend (s)
				id_value.put_right (0)
			end
		end

	print_id_table
		do
			io.putstring ("id_table:%N")
			if not id_table.is_empty then
				from
					id_table.start
				until
					id_table.after
				loop
					io.putstring ("%T")
					io.putstring (id_table.item)
					io.putstring ("%N")
					id_table.forth
				end
			end
		end

	set_value
		do
			if not id_table.is_empty then
				io.putstring ("Enter the integer values (9999 to end):")
				id_value.wipe_out
				id_value.forth
				io.new_line
				from
					id_table.start
				until
					id_table.after
				loop
					io.putstring (id_table.item)
					io.putstring (": ")
					io.readint
					id_value.put_left (io.lastint)
					end_session := io.lastint = 9999
					id_table.forth
				end
			end
		end

	int_value (s: STRING): INTEGER
		do
			id_table.start
			id_table.compare_objects
			id_table.search (s)
			if not (id_table.is_empty or id_table.after) then
				id_value.go_i_th (id_table.index)
				Result := id_value.item
			else
				io.putstring ("The variable ")
				io.putstring (s)
				io.putstring (" is not declared")
				io.new_line
			end
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- POLYNOM_INFO

