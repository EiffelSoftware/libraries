indexing
	description: "Raw response retrieved from interpreter"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AUT_RAW_RESPONSE

create
	make

feature{NONE} -- Initialization

	make (a_output: like output; a_error: like error; a_interpreter_error: BOOLEAN) is
			-- Set `output' with `a_output' and `error' with `a_error'.
		do
			set_output (a_output)
			set_error (a_error)
			is_interpreter_error := a_interpreter_error
		ensure
			output_set: output = a_output
			error_set: error = a_error
			is_interpreter_error_set: is_interpreter_error = a_interpreter_error
		end

feature -- Access

	output: STRING
			-- Output
			-- Contains standard output and standard error generated by testee feature.
			-- For example, if the testee feature output something into its standard error,
			-- those messages will be stored here.

	error: STRING
			-- Error message
			-- Contains: 1. error generated from interpreter or
			--           2. exception trace from testee feature.

	is_interpreter_error: BOOLEAN
			-- Is `error' an interpreter error?

feature -- Setting

	set_output (a_output: like output) is
			-- Set `output' with `a_output'.
		do
			output := a_output
		ensure
			output_set: output = a_output
		end

	set_error (a_error: like error) is
			-- Set `error' with `a_error'.
		do
			error := a_error
		ensure
			error_set: error = a_error
		end

end
