indexing

	description:
		"General mechanisms for building lexical analyzers";

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class LEX_BUILDER inherit

	PDFA
		rename
			make as pdfa_make,
			item as pdfa_item,
			put as pdfa_put,
			wipe_out as pdfa_wipe_out,
			move as pdfa_move
		redefine
			dfa_set_final
		end

creation

	make

feature

	make is
		do
			!!tool_list.make;
			!!tool_names.make
		end; -- make

	tool_list: LINKED_LIST [PDFA];
			-- Regular expressions used as tools
			-- to build the main one

	tool_names: LINKED_LIST [STRING];
			-- Names of the regular expressions
			-- in the tool list

	case_sensitive: BOOLEAN;
			-- Is the tool building case sensitive?

	keywords_case_sensitive: BOOLEAN;
			-- Are the keyword case sensitive?

	categories_table: ARRAY [INTEGER];
			-- Table with each input's category number

	keyword_h_table: HASH_TABLE [INTEGER, STRING];
			-- Keyword table

	error_list: ERROR_LIST is
			-- Error message list
		once
			!!Result.make
		end; -- error_list

	analyzer: LEXICAL;
			-- Lexical analyzer built

-- Routines used for tools (i.e. regular expressions) building:

	ignore_case is
			-- Ignore case in tool building.
			-- Do not change the existing tools.
		do
			case_sensitive := false
		end; -- ignore_case

	distinguish_case is
			-- Distinguish case in tool building.
			-- Do not change the existing tools.
			-- If neither ignore_case nor distinguish_case is
			-- used, then ignore_case is the default.
		do
			case_sensitive := true
		end; -- distinguish_case

	keywords_ignore_case is
			-- Ignore case for keywords.
		require
			none_of_the_tools_built: tool_list = Void or else tool_list.empty
		do
			keywords_case_sensitive := false
		end; -- keywords_ignore_case

	keywords_distinguish_case is
			-- Distinguish case for keywords. If neither
			-- keywords_ignore_case nor keywords_distinguish_case
			-- is used, then keywords_ignore_case is the default.
		require
			none_of_the_tools_built: tool_list.empty
		do
			keywords_case_sensitive := true
		end; -- keywords_distinguish_case

	interval (b, e: CHARACTER) is
			-- make a regular expression `b'..'e', or `b' if `b' = `e'.
		require
			not_built: not dfa_built;
			e_code_small_enough: charcode (e) <= Last_ascii;
			b_code_large_enough: charcode (b) >= 0;
			b_before_e: charcode (b) <= charcode (e)
		local
			i, ee, bb: INTEGER;
			fa: PDFA;
			c_name: STRING;
			list: LINKED_LIST [INTEGER]
		do
			!!fa.make (2, Last_ascii);
			bb := charcode (b);
			ee := charcode (e);
			from
				i := bb
			until
				i = ee + 1
			loop
				fa.set_transition (1, i, 2);
				i := i + 1
			end;
			if bb <= Lower_z and ee >= Upper_a and then
					(bb <= Upper_z or ee >= Lower_a) then
				fa.now_has_letters
			end;
			if not case_sensitive then
				fa.remove_case_sensitiveness
			end;
			last_created_tool := last_created_tool + 1;
			tool_list.finish;
			tool_list.add_right (fa);
			if bb /= ee then
				!!c_name.make (8);
				c_name.extend ('%'');
				c_name.append (readable_form (b));
				c_name.extend ('%'');
				c_name.append ("..");
				c_name.extend ('%'');
				c_name.append (readable_form (e));
				c_name.extend ('%'')
			else
				!!c_name.make (3);
				c_name.extend ('%'');
				c_name.append (readable_form (b));
				c_name.extend ('%'')
			end;
			tool_names.finish;
			tool_names.add_right (c_name)
		end; -- interval

	any_character is
			-- Create a regular expression $. including all characters.
		require
			dfa_not_built: not dfa_built
		local
			i: INTEGER;
			new_tool: PDFA
		do
			!!new_tool.make (2, Last_ascii);
			from
				i := -1
			until
				i = Last_ascii
			loop
				i := i + 1;
				new_tool.set_transition (1, i, 2)
			end;
			new_tool.now_has_letters;
			if not case_sensitive then
				new_tool.remove_case_sensitiveness
			end;
			last_created_tool := last_created_tool + 1;
			tool_list.finish;
			tool_list.add_right (new_tool);
			tool_names.finish;
			tool_names.add_right ("$.")
		end; -- any_character

	any_printable is
			-- Create a regular expression $P including all printable
			-- characters.
		require
			dfa_not_built: not dfa_built
		local
			i: INTEGER;
			new_tool: PDFA
		do
			!!new_tool.make (2, Last_ascii);
			from
				i := First_printable - 1
			until
				i = Last_printable
			loop
				i := i + 1;
				new_tool.set_transition (1, i, 2)
			end;
			new_tool.now_has_letters;
			if not case_sensitive then
				new_tool.remove_case_sensitiveness
			end;
			last_created_tool := last_created_tool + 1;
			tool_list.finish;
			tool_list.add_right (new_tool);
			tool_names.finish;
			tool_names.add_right ("$P")
		end; -- any_printable

	difference (r: INTEGER; c: CHARACTER) is
			-- Create a regular expression representing
			-- the difference `r' - `c'.
			-- `r' must be a simple category, such as `a'..`z',
			-- or a union of simple categories,
			-- such as `a'..`z' | '`0'..`9'.
		require
			dfa_not_built: not dfa_built;
			r_exists: r >= 1 and r <= last_created_tool;
			r_simple_category: tool_list.i_th (r).nb_states = 2
		local
			new: PDFA;
			cc: INTEGER;
			c_name: STRING
		do
			tool_list.go_i_th (r);
			!!new.make (tool_list.item.nb_states, Last_ascii);
			new.include (tool_list.item, 0);
			cc := charcode (c);
			new.delete_transition (1, cc, 2);
			if not case_sensitive then
				new.remove_case_sensitiveness
			end;
			last_created_tool := last_created_tool + 1;
			tool_list.finish;
			tool_list.add_right (new);
			!!c_name.make (0);
			tool_names.go_i_th (r);
			c_name.append (tool_names.item);
			c_name.extend ('-');
			c_name.extend ('%'');
			c_name.extend (c);
			c_name.extend ('%'');
			tool_names.finish;
			tool_names.add_right (c_name)
		end; -- difference

	append (p, s: INTEGER) is
			-- Create a regular expression `p'`s':
			-- `s' appended at end of `p'
		require
			dfa_not_built: not dfa_built;
			p_in_tool: p >= 1 and p <= last_created_tool;
			s_in_tool: s >= 1 and s <= last_created_tool
		local
			new: PDFA;
			c_name: STRING;
			p_length, s_length, length: INTEGER
		do
			tool_list.go_i_th (p);
			p_length := tool_list.item.nb_states;
			tool_list.go_i_th (s);
			s_length := tool_list.item.nb_states;
			length := p_length + s_length;
			!!new.make (length, Last_ascii);
			new.include (tool_list.item, p_length);
			tool_list.go_i_th (p);
			new.include (tool_list.item, 0);
			new.set_e_transition (p_length, p_length + 1);
			if not case_sensitive then
				new.remove_case_sensitiveness
			end;
			last_created_tool := last_created_tool + 1;
			tool_list.finish;
			tool_list.add_right (new);
			!!c_name.make (0);
			tool_names.go_i_th (p);
			c_name.append (tool_names.item);
			c_name.extend (' ');
			tool_names.go_i_th (s);
			c_name.append (tool_names.item);
			tool_names.finish;
			tool_names.add_right (c_name)
		end; -- append

	append_optional (p, s: INTEGER) is
			-- Create a regular expression `p'[`s']:
			-- `s' appended at end of `p', `s' is optional.
		require
			dfa_not_built: not dfa_built;
			p_in_tool: p >= 1 and p <= last_created_tool;
			s_in_tool: s >= 1 and s <= last_created_tool
		local
			new: PDFA;
			c_name: STRING;
			p_length, s_length, length: INTEGER
		do
			tool_list.go_i_th (p);
			p_length := tool_list.item.nb_states;
			tool_list.go_i_th (s);
			s_length := tool_list.item.nb_states;
			length := p_length + s_length;
			!!new.make (length, Last_ascii);
			new.include (tool_list.item, p_length);
			tool_list.go_i_th (p);
			new.include (tool_list.item, 0);
			new.set_e_transition (p_length, p_length + 1);
			new.set_e_transition (p_length, length);
			if not case_sensitive then
				new.remove_case_sensitiveness
			end;
			last_created_tool := last_created_tool + 1;
			tool_list.finish;
			tool_list.add_right (new);
			!!c_name.make (0);
			tool_names.go_i_th (p);
			c_name.append (tool_names.item);
			c_name.extend (' ');
			c_name.extend ('[');
			tool_names.go_i_th (s);
			c_name.append (tool_names.item);
			c_name.extend (']');
			tool_names.finish;
			tool_names.add_right (c_name)
		end; -- append_optional

	prepend_optional (p, s: INTEGER) is
			-- Create a regular expression [`p']`s':
			-- `s' appended at end of `p', `p' is optional.
		require
			dfa_not_built: not dfa_built;
			p_in_tool: p >= 1 and p <= last_created_tool;
			s_in_tool: s >= 1 and s <= last_created_tool
		local
			new: PDFA;
			c_name: STRING;
			p_length, s_length, length: INTEGER
		do
			tool_list.go_i_th (p);
			p_length := tool_list.item.nb_states;
			tool_list.go_i_th (s);
			s_length := tool_list.item.nb_states;
			length := p_length + s_length;
			!!new.make (length, Last_ascii);
			new.include (tool_list.item, p_length);
			tool_list.go_i_th (p);
			new.include (tool_list.item, 0);
			new.set_e_transition (1, p_length + 1);
			new.set_e_transition (p_length, p_length + 1);
			if not case_sensitive then
				new.remove_case_sensitiveness
			end;
			last_created_tool := last_created_tool + 1;
			tool_list.finish;
			tool_list.add_right (new);
			!!c_name.make (0);
			c_name.extend ('[');
			tool_names.go_i_th (p);
			c_name.append (tool_names.item);
			c_name.extend (']');
			c_name.extend (' ');
			tool_names.go_i_th (s);
			c_name.append (tool_names.item);
			tool_names.finish;
			tool_names.add_right (c_name)
		end; -- prepend_optional

	case_insensitive (c: INTEGER) is
			-- Create a regular expression ~(`c'), which is like `c',
			-- but case insensitive.
		require
			dfa_not_built: not dfa_built;
			z_possible: Last_ascii >= Lower_z;
			c_in_tool: c >= 1 and c <= last_created_tool
		local
			new: PDFA;
			c_name: STRING;
			in_put: INTEGER
		do
			tool_list.go_i_th (c);
			!!new.make (tool_list.item.nb_states, Last_ascii);
			new.include (tool_list.item, 0);
			new.remove_case_sensitiveness;
			last_created_tool := last_created_tool + 1;
			tool_list.finish;
			tool_list.add_right (new);
			tool_names.go_i_th (c);
			!!c_name.make (0);
			c_name.extend ('~');
			c_name.extend ('(');
			c_name.append (tool_names.item);
			c_name.extend (')');
			tool_names.finish;
			tool_names.add_right (c_name)
		end; -- case_insensitive

	optional (c: INTEGER) is
			-- Create a regular expression [`c'], which is same as `c'
			-- but optional.
		require
			dfa_not_built: not dfa_built;
			c_in_tool: c >= 1 and c <= last_created_tool
		local
			new: PDFA;
			c_name: STRING;
			length: INTEGER
		do
			tool_list.go_i_th (c);
			length := tool_list.item.nb_states;
			!!new.make (length, Last_ascii);
			new.include (tool_list.item, 0);
			new.set_e_transition (1, length);
			if not case_sensitive then
				new.remove_case_sensitiveness
			end;
			last_created_tool := last_created_tool + 1;
			tool_list.finish;
			tool_list.add_right (new);
			tool_names.go_i_th (c);
			!!c_name.make (0);
			c_name.extend ('[');
			c_name.append (tool_names.item);
			c_name.extend (']');
			tool_names.finish;
			tool_names.add_right (c_name)
		end; -- optional

	iteration1 (c: INTEGER) is
			-- Create a regular expression +(`c'), which is an iteration
			-- of regular expression `c', with at least one element.
		require
			dfa_not_built: not dfa_built;
			c_in_tool: c >= 1 and c <= last_created_tool
		local
			new: PDFA;
			c_name: STRING;
			length: INTEGER
		do
			tool_list.go_i_th (c);
			length := tool_list.item.nb_states;
			!!new.make (length, Last_ascii);
			new.include (tool_list.item, 0);
			new.set_e_transition (length, 1);
			if not case_sensitive then
				new.remove_case_sensitiveness
			end;
			last_created_tool := last_created_tool + 1;
			tool_list.finish;
			tool_list.add_right (new);
			tool_names.go_i_th (c);
			!!c_name.make (0);
			c_name.precede ('+');
			c_name.extend ('(');
			c_name.append (tool_names.item);
			c_name.extend (')');
			tool_names.finish;
			tool_names.add_right (c_name)
		end; -- iteration1

	iteration (c: INTEGER) is
			-- Create a regular expression *(`c'), which is an iteration
			-- of regular expression `c', with zero or more elements.
		require
			dfa_not_built: not dfa_built;
			c_in_tool: c >= 1 and c <= last_created_tool
		local
			new: PDFA;
			c_name: STRING;
			length: INTEGER
		do
			tool_list.go_i_th (c);
			length := tool_list.item.nb_states;
			!!new.make (length, Last_ascii);
			new.include (tool_list.item, 0);
			new.set_e_transition (length, 1);
			new.set_e_transition (1, length);
			if not case_sensitive then
				new.remove_case_sensitiveness
			end;
			last_created_tool := last_created_tool + 1;
			tool_list.finish;
			tool_list.add_right (new);
			tool_names.go_i_th (c);
			!!c_name.make (0);
			c_name.precede ('*');
			c_name.extend ('(');
			c_name.append (tool_names.item);
			c_name.extend (')');
			tool_names.finish;
			tool_names.add_right (c_name)
		end; -- iteration

	iteration_n (n, c: INTEGER) is
			-- Create a regular expression n(`c'), which is an
			-- iteration n times of `c'.
			-- For instance: 6(`a'..`z').
		require
			dfa_not_built: not dfa_built;
			n_large_enough: n > 0;
			c_in_tool: c >= 1 and c <= last_created_tool
		local
			a_prefix, new: PDFA;
			c_name: STRING;
			index, o_length, p_length: INTEGER
		do
			tool_list.go_i_th (c);
			new := tool_list.item;
			o_length := new.nb_states;
			!!a_prefix.make (o_length * n, Last_ascii);
			a_prefix.include (new, 0);
			from
				index := 1
			until
				index = n
			loop
				p_length := index * o_length;
				index := index + 1;
				a_prefix.include (new, p_length);
				a_prefix.set_e_transition (p_length, p_length + 1)
			end;
			if not case_sensitive then
				a_prefix.remove_case_sensitiveness
			end;
			last_created_tool := last_created_tool + 1;
			tool_list.finish;
			tool_list.add_right (a_prefix);
			tool_names.go_i_th (c);
			!!c_name.make (0);
			c_name.append (n.out);
			c_name.extend ('(');
			c_name.append (tool_names.item);
			c_name.extend (')');
			tool_names.finish;
			tool_names.add_right (c_name)
		end; -- iteration_n

	union2 (a, b: INTEGER) is
			-- Create a regular expression `a' | `b', which the union
			-- of `a' and `b'.
		require
			dfa_not_built: not dfa_built;
			a_in_tool: a >= 1 and a <= last_created_tool;
			b_in_tool: b >= 1 and b <= last_created_tool
		local
			new: PDFA;
			length, a_length, b_length: INTEGER;
			a_transitions, b_transitions: LINKED_LIST [INTEGER];
			c_name: STRING
		do
			tool_list.go_i_th (a);
			a_length := tool_list.item.nb_states;
			a_transitions := tool_list.item.item (a_length);
			tool_list.go_i_th (b);
			b_length := tool_list.item.nb_states;
			b_transitions := tool_list.item.item (b_length);
			length := a_length + b_length + 2;
			if length = 6 and then
					(a_transitions = Void and b_transitions = Void) then
					-- If `a' and `b' are categories,
					-- `a' | `b' must also be one.
					-- not 'a'|+('b') ==> test of transition number.
				debug
					io.putstring ("Union2, length = 6");
					io.new_line;
				end;
				!!new.make (2, Last_ascii);
				new.include (tool_list.item, 0);
				tool_list.go_i_th (a);
				new.include (tool_list.item, 0)
			else
				debug
					io.putstring ("Union2, length /= 6");
					io.new_line;
				end;
				!!new.make (length, Last_ascii);
				new.include (tool_list.item, a_length + 1);
				tool_list.go_i_th (a);
				new.include (tool_list.item, 1);
				new.set_e_transition (1, 2);
				new.set_e_transition (1, a_length + 2);
				new.set_e_transition (a_length + 1, length);
				new.set_e_transition (length - 1, length)
			end;
			if not case_sensitive then
				new.remove_case_sensitiveness
			end;
			last_created_tool := last_created_tool + 1;
			tool_list.finish;
			tool_list.add_right (new);
			!!c_name.make (0);
			tool_names.go_i_th (a);
			c_name.append (tool_names.item);
			c_name.extend ('|');
			tool_names.go_i_th (b);
			c_name.append (tool_names.item);
			tool_names.finish;
			tool_names.add_right (c_name)
		end; -- union2

	union (a, b: INTEGER) is
			-- Create a regular expression
			-- `a' | `a'+1 | .. | `b', the
			-- union of the successives categories
			-- `a', `a'+1, ..,`b'.
		require
			dfa_not_built: not dfa_built;
			a_not_too_small: a >= 1;
			b_not_too_large: b <= last_created_tool;
			a_smaller_than_b: a <= b
		local
			new, cat: PDFA;
			tool_p, length, index: INTEGER;
			c_name: STRING;
			cat_set, non_cat_set: FIX_INT_SET
		do
			!!cat_set.make (b);
			!!non_cat_set.make (b);
			length := 2;
			from
				tool_list.go_i_th (a)
			until
				tool_list.index = b + 1
			loop
				if tool_list.item.nb_states > 2 then
					non_cat_set.put (tool_list.index);
					length := length + tool_list.item.nb_states
				else
					cat_set.put (tool_list.index)
				end;
				tool_list.forth
			end;
			if not cat_set.empty then
				!!cat.make (2, Last_ascii);
				from
					tool_p := cat_set.smallest
				until
					tool_p > b
				loop
					tool_list.go_i_th (tool_p);
					cat.include (tool_list.item, 0);
					tool_p := cat_set.next (tool_p)
				end
			end;
			if length = 2 then
				new := cat
			else
				if cat_set.empty then
					!!new.make (length, Last_ascii);
					index := 2
				else
					length := length + 2;
					!!new.make (length, Last_ascii);
					new.include (cat, 1);
					new.set_e_transition (1, 2);
					new.set_e_transition (3, length);
					index := 4
				end;
				from
					tool_p := non_cat_set.smallest
				until
					tool_p > b
				loop
					tool_list.go_i_th (tool_p);
					new.include (tool_list.item, index - 1);
					new.set_e_transition (1, index);
					index := index + tool_list.item.nb_states;
					new.set_e_transition (index - 1, length);
					tool_p := non_cat_set.next (tool_p)
				end
			end;
			if not case_sensitive then
				new.remove_case_sensitiveness
			end;
			last_created_tool := last_created_tool + 1;
			tool_list.finish;
			tool_list.add_right (new);
			!!c_name.make (0);
			from
				tool_names.go_i_th (a);
			until
				tool_names.index = b
			loop
				c_name.append (tool_names.item);
				c_name.extend ('|');
				tool_names.forth
			end;
			c_name.append (tool_names.item);
			tool_names.finish;
			tool_names.add_right (c_name)
		end; -- union

	set_word (word: STRING) is
			-- Create a regular expression "`word'", which is same
			-- as (`w'`o'`r'`d').
		require
			word_not_empty: word.count >= 1
		local
			new_tool: PDFA;
			length, code, i: INTEGER;
			tool_name: STRING
		do
			length := word.count;
			!!new_tool.make (length + 1, Last_ascii);
			from
			until
				i = length
			loop
				i := i + 1;
				code := word.item_code (i);
				new_tool.set_transition (i, code, i + 1);
				if (code <= Lower_z and code >= Lower_a) or else
						(code <= Upper_z and code >= Upper_a) then
					new_tool.now_has_letters
				end
			end;
			if not case_sensitive then
				new_tool.remove_case_sensitiveness
			end;
			last_created_tool := last_created_tool + 1;
			tool_list.finish;
			tool_list.add_right (new_tool);
			tool_name := clone (word);
			tool_name.precede ('"');
			tool_name.extend ('"');
			tool_names.finish;
			tool_names.add_right (tool_name)
		end; -- set_word

	up_to (word: STRING) is
			-- Create a regular expression ->"`word'", which is a
			-- set of any number of any characters, ended by "`word'".
			-- Example: "/* C comment */" is recognized by (->"*/").
			-- The difference between (+$. '*' '/') and
			-- (->"*/") is that "*/..*/..*/" can be recognized by the
			-- first one and not by the second one.
			-- The difference between
			-- ((($.-'*') | ('*'($.-'/'))) +('*' '/') )
			-- and "(->"*/")" is that "..**/" can be recognized by
			-- the second one and not by the first one.
		require
			word_not_empty: word.count > 0;
			dfa_not_built: not dfa_built
		local
			i, j, length: INTEGER;
			new_tool: PDFA;
			r_name: STRING
		do
			length := word.count;
			!!new_tool.make ((6 * length) + 1, Last_ascii);
			from
			until
				i = length
			loop
				new_tool.set_e_transition ((6 * i) + 1, (6 * i) + 2);
				new_tool.set_e_transition ((6 * i) + 1, (6 * i) + 4);
				new_tool.set_e_transition ((6 * i) + 1, (6 * i) + 6);
				new_tool.set_e_transition ((6 * i) + 3, 1);
				new_tool.set_e_transition ((6 * i) + 5, 7);
				from
					j := First_printable - 1
				until
					j = Last_printable
				loop
					j := j + 1;
					new_tool.set_transition ((6 * i) + 2, j, (6 * i) + 3)
				end;
				new_tool.delete_transition ((6 * i) + 2,
					word.item_code (i + 1), (6 * i) + 3);
				new_tool.delete_transition ((6 * i) + 2,
					word.item_code (1), (6 * i) + 3);
				new_tool.set_transition ((6 * i) + 6,
					word.item_code (i + 1), (6 * i) + 7);
				new_tool.set_transition ((6 * i) + 4,
					word.item_code (1), (6 * i) + 5);
				i := i + 1
			end;
			new_tool.now_has_letters;
			if not case_sensitive then
				new_tool.remove_case_sensitiveness
			end;
			last_created_tool := last_created_tool + 1;
			tool_list.finish;
			tool_list.add_right (new_tool);
			!!r_name.make (4);
			r_name.extend ('-');
			r_name.extend ('>');
			r_name.extend ('"');
			r_name.append (word);
			r_name.extend ('"');
			tool_names.finish;
			tool_names.add_right (r_name)
		end; -- up_to

	put_keyword (s: STRING; exp: INTEGER) is
			-- Declare `s' as a keyword described by
			-- the regular expression of code `exp'.
			--| Do not check if `s' is recognized by `exp'.
			--| This is done when the dfa is built.
		require
			dfa_not_built: not dfa_built;
			exp_selected: token_type_list /= Void and then token_type_list.has(exp)
		local
			u, l: STRING;
			index: INTEGER
		do
			index := token_type_list.index_of (exp, 1);
			tool_list.go_i_th (selected_tools.i_th (index));
			tool_list.item.add_keyword (s);
			last_declared_keyword := last_declared_keyword + 1;
			if not keywords_case_sensitive then
				l := clone (s);
				l.to_lower;
				tool_list.item.add_keyword (l);
				u := clone (s);
				u.to_upper;
				tool_list.item.add_keyword (u);
				last_declared_keyword := last_declared_keyword + 2
			end
		end; -- put_keyword

	remove is
			-- Remove the last regular expression
			-- from the tool list.
		require
			dfa_not_built: not dfa_built;
			at_least_one_regular: last_created_tool >= 1
		do
			last_created_tool := last_created_tool - 1;
			tool_list.finish;
			tool_names.finish;
			tool_list.remove;
			tool_names.remove
		end; -- remove

	select_tool (i: INTEGER) is
			-- Select the `i'_th tool to include it in the main
			-- regular expression.
		require
			dfa_not_built: not dfa_built;
			i_exist: i > 0 and i <= last_created_tool
		do
			if selected_tools = Void then
				!!selected_tools.make;
				!!token_type_list.make
			end;
			selected_tools.finish;
			selected_tools.add_right (i);
			selected_tools.finish;
			token_type_list.finish;
			token_type_list.add_right (i);
			token_type_list.finish;
			tool_list.go_i_th (i);
			nb_states := nb_states + tool_list.item.nb_states
		ensure
			i_selected: selected_tools.has (i)
		end; -- select_tool

	associate (t, n: INTEGER) is
			-- Associate the `t'-th tool with token type `n'.
			-- If this routine is not used, the default value is `t'.
		require
			t_selected: selected_tools.has (t);
			n_not_zero: n /= 0;
			n_not_minus_one: n /= -1
				-- 0 is reserved for the non final states.
				-- -1 is reserved for the end of text.
		do
			selected_tools.finish;
			if selected_tools.item = t then
				token_type_list.finish;
				token_type_list.put (n)
			else
				from
					selected_tools.start;
					token_type_list.start
				until
					selected_tools.item = t
				loop
					selected_tools.forth;
					token_type_list.forth
				end;
				token_type_list.put (n)
			end
		end; -- associate

	recognize (s: STRING): INTEGER is
			-- Token_type of `s'; 0 if not recognized
		local
			i: INTEGER;
			l: LINKED_LIST [INTEGER];
		do
			!!l.make;
			from
				i := 1
			until
				i = s.count + 1
			loop
				l.add_right (categories_table.item (charcode (s.item (i))));
				l.forth;
				i := i + 1
			end;
			Result := dfa.recognize (l)
		end; -- recognize

	store_analyzer (file_name: STRING) is
			-- Store `analyzer' in file named `file_name'.
		require
			initialized: initialized
		local
			store_file: UNIX_FILE
		do
			if analyzer = Void then
				!!analyzer.make
			end;
			!!store_file.make_open_write (file_name);
			analyzer.basic_store (store_file);
			store_file.close
		end; -- store_analyzer

	retrieve_analyzer (file_name: STRING) is
			-- Retrieve `analyzer' from file named `file_name'.
		local
			retrieved_file: UNIX_FILE
		do
			if analyzer = Void then
				!!analyzer.make
			end;
			!!retrieved_file.make_open_read (file_name);
			analyzer ?= analyzer.retrieved (retrieved_file);
			retrieved_file.close
		end; -- retrieve_analyzer

	initialize is
			-- Initialize the attributes of `analyzer'.
		do
			initialized := true;
			if analyzer = Void then
				!!analyzer.make
			end;
			analyzer.initialize_attributes (dfa, categories_table,
					keyword_h_table, keywords_case_sensitive)
		end -- initialize

feature {NONE}

	last_created_tool: INTEGER;
			-- Identification number of the last
			-- regular expression put in tool_list

	selected_tools: LINKED_LIST [INTEGER];
			-- Regular expressions included in the main one

	token_type_list: LINKED_LIST [INTEGER];
			-- Token types of the selected tools:
			-- The first list value is the token type of
			-- the first selected tool, etc.

	dfa_built: BOOLEAN;
			-- Is the DFA built?

	last_declared_keyword: INTEGER;
			-- Identification number of the last keyword declared

	initialized : BOOLEAN;
            -- Is analyzer initialized?

	readable_form (c: CHARACTER): STRING is
			-- "\n" if c = '\n' ...
		do
			if c = '%N' then
				Result := "%%N"
			elseif c = '%T' then
				Result := "%%T"
			elseif c = '%F' then
				Result := "%%F"
			elseif c = '%R' then
				Result := "%%R"
			else
				!!Result.make (1);
				Result.extend (c)
			end
		end; -- readable_form

-- Routines used for DFA building:

	freeze is
			-- Build the main PDFA, and then the DFA which is
			-- used to recognize a language.
		require
			dfa_not_built: not dfa_built;
			tools_selected: selected_tools /= Void
		do
			creation_with_all_inputs;
			build_categories_table;
			creation_with_categories;
			set_start (1);
			construct_dfa;
			copy_keywords;
			dfa_built := true
		ensure
			dfa_not_Void: dfa /= Void;
			dfa_built: dfa_built = true
		end; -- freeze

	creation_with_all_inputs is
			-- Create main PDFA, including all the selected tools.
			-- Very important: for each tool this routine assumes
			-- that the initial state in the first one, and the
			-- final state is the last one.
		require
			dfa_not_built: not dfa_built
		local
			shift: INTEGER;
			fa: PDFA
		do
			nb_states := nb_states + 1;
			pdfa_make (nb_states, Last_ascii);
			from
				selected_tools.start;
				token_type_list.start;
				shift := 1
			until
				selected_tools.after or selected_tools.empty
			loop
				set_e_transition (1, shift + 1);
				tool_list.go_i_th (selected_tools.item);
				fa := tool_list.item;
				include (fa, shift);
				shift := shift + fa.nb_states;
				set_final (shift, token_type_list.item);
				debug
					io.putstring (" Tool selected: ");
					io.putint (selected_tools.item);
					io.putstring (" Description: ");
					tool_names.go_i_th (selected_tools.item);
					io.putstring (tool_names.item);
					io.putstring (" Token type associated: ");
					io.putint (token_type_list.item);
					io.new_line
				end;
				selected_tools.forth;
				token_type_list.forth
			end
		end; -- creation_with_all_inputs

	build_categories_table is
			-- Build categories_table.
			-- The purpose of this table is to bring together
			-- all the inputs with the same "behavior" in the
			-- main PDFA, in order to reduce the size of the DFA.
			-- A set of inputs is named "category", and
			-- the categories_table provides, for each input, the
			-- number of the category it belongs to.
			-- The 0th category includes all the unused inputs,
			-- and the input -1, which means end of file.
			-- This routine uses "search_in_tree" of NFA, which
			-- purpose is to sort a set of FIX_INT_SET.
		local
			in_put: INTEGER;
			set, old_set: FIX_INT_SET
		do
			!!set_tree.make (nb_states, 0);
			!!categories_table.make (-1, Last_ascii);
			!!old_set.make (nb_states);
			from
				in_put := - 1
			until
				in_put = Last_ascii
			loop
				in_put := in_put + 1;
				set := input_array.item (in_put);
				if set /= Void then
					if set.is_equal (old_set) then
						categories_table.put (set_position, in_put)
					else
						search_in_tree (set);
						old_set := set;
						categories_table.put (set_position, in_put)
					end
				end
			end;
			greatest_input := new_number;
			new_number := 0;
			set_tree := Void
		end; -- build_categories_table

	creation_with_categories is
			-- Re-Create main PDFA, using categories_table,
			-- and bringing together the inputs of the same category.
			-- This routine do not deal with the epsilon transitions,
			-- which are left unchanged.
		require
			categories_table: categories_table /= Void
		local
			new_input_array: ARRAY [FIX_INT_SET];
			category, in_put: INTEGER
		do
			!!new_input_array.make (0, greatest_input);
			from
				in_put := -1
			until
				in_put = Last_ascii
			loop
				in_put := in_put + 1;
				category := categories_table.item (in_put);
				if new_input_array.item (category) = Void then
					new_input_array.put (input_array.item (in_put), category)
				end
			end;
			input_array := new_input_array
		end; -- creation_with_categories

	copy_keywords is
			-- Copy the keywords in the hash table.
		local
			k_list: LINKED_LIST [STRING];
			k: STRING;
			tool_number, token_type: INTEGER
		do
			if last_declared_keyword > 0 then
				!!keyword_h_table.make (last_declared_keyword)
			end;
			from
				selected_tools.start;
				token_type_list.start
			until
				selected_tools.after or selected_tools.empty
			loop
				tool_number := selected_tools.item;
				token_type := token_type_list.item;
				tool_list.go_i_th (tool_number);
				k_list := tool_list.item.keywords_list;
				from
					k_list.start
				until
					k_list.after or k_list.empty
				loop
					k := k_list.item;
					keyword_h_table.put (token_type, k);
					if not recognized (k, token_type) then
						error_keyword (tool_number, k)
					end;
					k_list.forth
				end;
				selected_tools.forth;
				token_type_list.forth
			end
		end; -- copy_keywords

	recognized (kwd: STRING; token_type: INTEGER): BOOLEAN is
			-- Is `kwd' recognized by the regular
			-- expression number `token_type'?
		require
			kwd /= Void
		local
			i: INTEGER;
			l: LINKED_LIST [INTEGER];
			possible_tokens: ARRAY [INTEGER]
		do
			!!l.make;
			from
				i := 1
			until
				i = kwd.count + 1
			loop
				l.add_right (categories_table.item (charcode (kwd.item (i))));
				l.forth;
				i := i + 1
			end;
			possible_tokens := dfa.possible_tokens (l);
			from
				i := possible_tokens.lower
			until
				Result or i > possible_tokens.upper
			loop
				Result := (possible_tokens.item (i) = token_type);
				i := i + 1
			end
		end; -- recognized

	dfa_set_final (s, new_final: INTEGER) is
			-- Set the attribute final of state s to new_final.
		local
			old_final: INTEGER;
		do
			old_final := dfa.item (s).final;
			if old_final = 0 then
				dfa.item (s).set_final (new_final)
			elseif old_final /= new_final then
				error_common_part (old_final, new_final);
				dfa.item (s).set_final (new_final)
			end
		end; -- dfa_set_final

	error_common_part (first, second: INTEGER) is
			-- Create an error message when a regular expression can
			-- be recognized by the first and the second token_type.
			-- Example "aa" is recognized by +(a..z) and 2(a).
			-- The first tool yield the priority to the second.
		require
			first_is_a_token_type: token_type_list.has (first);
			second_is_a_token_type: token_type_list.has (second)
		local
			message: STRING
		do
			!!message.make (0);
			message.append ("Warning: some tokens can be recognized by ");
			token_type_list.start;
			token_type_list.search (first);
			selected_tools.go_i_th (token_type_list.index);
			tool_names.go_i_th (selected_tools.item);
			message.append (tool_names.item);
			message.append (" and by ");
			token_type_list.start;
			token_type_list.search (second);
			selected_tools.go_i_th (token_type_list.index);
			tool_names.go_i_th (selected_tools.item);
			message.append (tool_names.item);
			message.append (".%N	The second one has priority.");
			error_list.add_message (message)
		end; -- error_common_part

	error_keyword (t: INTEGER; k: STRING) is
			-- Create an error message when a keyword k is not
			-- recognized by the corresponding tool.
		local
			message: STRING
		do
			!!message.make (0);
			message.append ("Warning: ");
			message.append (k);
			message.append (" is not recognized by ");
			tool_names.go_i_th (t);
			message.append (tool_names.item);
			message.extend ('.');
			error_list.add_message (message)
		end -- error_keyword

invariant

	last_created: tool_list = Void or else last_created_tool = tool_list.count

end -- class LEX_BUILDER
 

--|----------------------------------------------------------------
--| EiffelLex: library of reusable components for ISE Eiffel 3,
--| Copyright (C) 1986, 1990, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
