note
	description: "Objects that execution a command and return the output..."
	date: "$Date$"
	revision: "$Revision$"

class
	PROCESS_MISC

feature -- Status report

	last_error: INTEGER

feature -- Execution	

	output (a_file_name: READABLE_STRING_GENERAL; args: detachable ITERABLE [READABLE_STRING_GENERAL]; a_working_directory: detachable READABLE_STRING_GENERAL): detachable PROCESS_COMMAND_RESULT
		local
			pf: BASE_PROCESS_FACTORY
			p: BASE_PROCESS
			retried: BOOLEAN
			err,res: STRING
			err_spec, res_spec: SPECIAL [NATURAL_8]
		do
			if not retried then
				last_error := 0
				create res.make (0)
				create err.make (0)
				create pf
				p := pf.process_launcher (a_file_name, args, a_working_directory)
				p.enable_launch_in_new_process_group
				p.set_separate_console (False)
				p.set_hidden (True)
				p.set_detached_console (True)
				p.redirect_output_to_stream
				p.redirect_error_to_stream

				create res_spec.make_filled (0, 1024)
				create err_spec.make_filled (0, 1024)

				p.launch
				if p.launched then
					from
					until
						p.has_exited
					loop
						from
						until
							p.has_output_stream_closed or p.has_output_stream_error
						loop
							p.read_output_to_special (res_spec)
							append_special_of_natural_8_to_string_8 (res_spec, res)
						end

						from
						until
							p.has_error_stream_closed or p.has_error_stream_error
						loop
							p.read_error_to_special (err_spec)
							append_special_of_natural_8_to_string_8 (err_spec, err)
						end
						p.wait_for_exit_with_timeout (50)
					end
					create Result.make (p.exit_code, res, err)
				else
					last_error := 1
				end
			else
				last_error := 1
			end
		rescue
			retried := True
			retry
		end

	output_of_command (a_cmd: READABLE_STRING_GENERAL; a_working_directory: detachable READABLE_STRING_GENERAL): detachable PROCESS_COMMAND_RESULT
		local
			pf: BASE_PROCESS_FACTORY
			p: BASE_PROCESS
			retried: BOOLEAN
			err,res: STRING
			err_spec, res_spec: SPECIAL [NATURAL_8]
		do
			if not retried then
				last_error := 0
				create res.make (0)
				create err.make (0)
				create pf
				p := pf.process_launcher_with_command_line (a_cmd, a_working_directory)
				p.enable_launch_in_new_process_group
				p.set_separate_console (False)
				p.set_hidden (True)
				p.set_detached_console (True)
				p.redirect_output_to_stream
				p.redirect_error_to_stream

				create res_spec.make_filled (0, 1024)
				create err_spec.make_filled (0, 1024)

				p.launch
				if p.launched then
					from
					until
						p.has_exited
					loop
						from
						until
							p.has_output_stream_closed or p.has_output_stream_error
						loop
							p.read_output_to_special (res_spec)
							append_special_of_natural_8_to_string_8 (res_spec, res)
						end

						from
						until
							p.has_error_stream_closed or p.has_error_stream_error
						loop
							p.read_error_to_special (err_spec)
							append_special_of_natural_8_to_string_8 (err_spec, err)
						end
						p.wait_for_exit_with_timeout (50)
					end
					create Result.make (p.exit_code, res, err)
				else
					last_error := 1
				end
			else
				last_error := 1
			end
		rescue
			retried := True
			retry
		end

	command_execution (a_cmd: READABLE_STRING_GENERAL; a_working_directory: detachable READABLE_STRING_GENERAL; a_record_output: BOOLEAN): detachable PROCESS_COMMAND_RESULT
		local
			pf: BASE_PROCESS_FACTORY
			p: BASE_PROCESS
			retried: BOOLEAN
			err,res: STRING
			err_spec, res_spec: SPECIAL [NATURAL_8]
		do
			if not retried then
				last_error := 0
				create res.make (0)
				create err.make (0)
				create pf
				p := pf.process_launcher_with_command_line (a_cmd, a_working_directory)
				p.enable_launch_in_new_process_group
				p.set_separate_console (False)
				p.set_hidden (True)
				p.set_detached_console (True)
				if a_record_output then
					p.redirect_output_to_stream
					p.redirect_error_to_stream
				end

				p.launch
				if p.launched then
					from
					until
						p.has_exited
					loop
						if a_record_output then
							from
								if res_spec = Void then
									create res_spec.make_filled (0, 1024)
								end
							until
								p.has_output_stream_closed or p.has_output_stream_error
							loop
								p.read_output_to_special (res_spec)
								append_special_of_natural_8_to_string_8 (res_spec, res)
							end

							from
								if err_spec = Void then
									create err_spec.make_filled (0, 1024)
								end
							until
								p.has_error_stream_closed or p.has_error_stream_error
							loop
								p.read_error_to_special (err_spec)
								append_special_of_natural_8_to_string_8 (err_spec, err)
							end
						end
						p.wait_for_exit_with_timeout (50)
					end
					create Result.make (p.exit_code, res, err)
				else
					last_error := 1
				end
			else
				last_error := 1
			end
		rescue
			retried := True
			retry
		end

	launch_no_wait_command (a_cmd: READABLE_STRING_GENERAL; a_working_directory: PATH; is_hidden: BOOLEAN)
		local
			pf: BASE_PROCESS_FACTORY
			p: BASE_PROCESS
			retried: BOOLEAN
		do
			if not retried then
				last_error := 0
				create pf
				p := pf.process_launcher_with_command_line (a_cmd, a_working_directory.name)
				p.enable_launch_in_new_process_group
				p.set_separate_console (False)
				p.set_hidden (True)
				p.set_detached_console (True)
				p.launch
			else
				last_error := 1
			end
		rescue
			retried := True
			retry
		end

feature -- Helpers

	append_escaped_string_to (a_string: READABLE_STRING_GENERAL; a_output: STRING_32)
		local
			i,n: INTEGER
			ch: CHARACTER_32
		do
			if a_string.has ('%"') then
				from
					i := 1
					n := a_string.count
				until
					i > n
				loop
					ch := a_string [i]
					inspect ch
					when '`' then
						a_output.extend ('\')
						a_output.extend ('\')
						a_output.extend ('\')
						a_output.extend (ch)
					when '%"', '%'' then
						a_output.extend ('\') -- escape the character
						a_output.extend (ch)
					when '%R' then
						-- Ignore
					when '\' then
						a_output.extend (ch)
						if i < n then
							ch := a_string [i]
							a_output.extend (ch)
							i := i + 1
						end
					else
						a_output.extend (ch)
					end
					i := i + 1
				end
			else
				a_output.append_string_general (a_string)
			end
		end

	to_command_line (a_filename: READABLE_STRING_GENERAL; args: detachable ITERABLE [READABLE_STRING_GENERAL]): STRING_32
		local
			arg: READABLE_STRING_GENERAL
		do
			create Result.make (a_filename.count)
			if a_filename.has (' ') then
				Result.append_character ('%"')
				Result.append_string_general (a_filename)
				Result.append_character ('%"')
			else
				Result.append_string_general (a_filename)
			end
			if args /= Void then
				across
					args as ic
				loop
					arg := ic.item
					Result.append_character (' ')
					if arg.has (' ') then
						Result.append_character ('%"')
						append_escaped_string_to (arg, Result)
						Result.append_character ('%"')
					else
						append_escaped_string_to (arg, Result)
					end
				end
			end
		end

feature {NONE} -- Implementation

	append_special_of_natural_8_to_string_8 (spec: SPECIAL [NATURAL_8]; a_output: STRING)
		local
			i,n: INTEGER
		do
			from
				i := spec.lower
				n := spec.upper
			until
				i > n
			loop
				a_output.append_code (spec[i])
				i := i + 1
			end
		end

note
	copyright: "Copyright (c) 2003-2022, Jocelyn Fiat"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Jocelyn Fiat
			 Contact: jocelyn@eiffelsolution.com
			 Website http://www.eiffelsolution.com/
		]"
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
end
