indexing
	description: "No description available."
	Note: "Automatically generated by the EiffelCOM Wizard."

deferred class
	PICTURE_AUTO_INTERFACE

feature -- Access

	handle: INTEGER is
			-- No description available.
		require
			handle_user_precondition: handle_user_precondition
		deferred

		end

	h_pal: INTEGER is
			-- No description available.
		require
			h_pal_user_precondition: h_pal_user_precondition
		deferred

		end

	type: INTEGER is
			-- No description available.
		require
			type_user_precondition: type_user_precondition
		deferred

		end

	width: INTEGER is
			-- No description available.
		require
			width_user_precondition: width_user_precondition
		deferred

		end

	height: INTEGER is
			-- No description available.
		require
			height_user_precondition: height_user_precondition
		deferred

		end

feature -- Status Report

	handle_user_precondition: BOOLEAN is
			-- User-defined preconditions for `handle'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	h_pal_user_precondition: BOOLEAN is
			-- User-defined preconditions for `h_pal'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	set_h_pal_user_precondition (a_value: INTEGER): BOOLEAN is
			-- User-defined preconditions for `set_h_pal'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	type_user_precondition: BOOLEAN is
			-- User-defined preconditions for `type'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	width_user_precondition: BOOLEAN is
			-- User-defined preconditions for `width'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	height_user_precondition: BOOLEAN is
			-- User-defined preconditions for `height'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	render_user_precondition (hdc: INTEGER; x: INTEGER; y: INTEGER; cx: INTEGER; cy: INTEGER; x_src: INTEGER; y_src: INTEGER; cx_src: INTEGER; cy_src: INTEGER; prc_wbounds: POINTER): BOOLEAN is
			-- User-defined preconditions for `render'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

feature -- Element Change

	set_h_pal (a_value: INTEGER) is
			-- Set 'h_pal' with 'an_item'
		require
			set_h_pal_user_precondition: set_h_pal_user_precondition (a_value)
		deferred

		end

feature -- Basic Operations

	render (hdc: INTEGER; x: INTEGER; y: INTEGER; cx: INTEGER; cy: INTEGER; x_src: INTEGER; y_src: INTEGER; cx_src: INTEGER; cy_src: INTEGER; prc_wbounds: POINTER) is
			-- -- `hdc' [out].
			-- `x' [out].
			-- `y' [out].
			-- `cx' [out].
			-- `cy' [out].
			-- `x_src' [out].
			-- `y_src' [out].
			-- `cx_src' [out].
			-- `cy_src' [out].
			-- `prc_wbounds' [out].
			
		require
			render_user_precondition: render_user_precondition (hdc, x, y, cx, cy, x_src, y_src, cx_src, cy_src, prc_wbounds)
		deferred

		end

end -- PICTURE_AUTO_INTERFACE

