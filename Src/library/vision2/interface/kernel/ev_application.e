indexing
	description:
		"Eiffel Vision Application.%N%
		%To start an Eiffel Vision application: create exactly one%
		%EV_APPLICATION object and call `launch' after setting up initial%
		%window(s)"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "application, accelerator, event loop"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_APPLICATION

inherit
	EV_ANY
		redefine
			implementation,
			application_exists,
			initialize,
			action_sequence_call_counter
		end

	EV_APPLICATION_ACTION_SEQUENCES
		redefine
			implementation
		end

feature {NONE} -- Initialization is

	initialize is
			-- Mark `Current' as initialized.
		do
			set_tooltip_delay (default_tooltip_delay)
			Precursor
		ensure then
			tooltip_delay_initialized: tooltip_delay = default_tooltip_delay
		end

feature -- Access

	windows: LINEAR [EV_WINDOW] is
			-- All of the application's windows.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.windows
		ensure
			not_void: Result /= Void
			bridge_ok: Result.is_equal (implementation.windows)
		end

	locked_window: EV_WINDOW is
			-- Window currently locked. Void if no window
			-- is currently locked.
			--
			-- See `{EV_WINDOW}.lock_update' for more details
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.locked_window
		end

	captured_widget: EV_WIDGET is
			-- Widget currently captured. Void if none.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.captured_widget
		end

	help_accelerator: EV_ACCELERATOR is
			-- Accelerator that displays contextual help
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.help_accelerator
		ensure
			not_void: Result /= Void
			bridge_ok: Result.is_equal (implementation.help_accelerator)
		end

	contextual_help_accelerator: EV_ACCELERATOR is
			-- Accelerator that enables contextual help mode
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.contextual_help_accelerator
		ensure
			not_void: Result /= Void
			bridge_ok: Result.is_equal
				(implementation.contextual_help_accelerator)
		end

	help_engine: EV_HELP_ENGINE is
			-- Object that handles contextual help display requests
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.help_engine
		ensure
			not_void: Result /= Void
			bridge_ok: Result.is_equal (implementation.help_engine)
		end

	clipboard: EV_CLIPBOARD is
			-- Native platform clipboard access.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.clipboard
		ensure
			not_void: Result /= Void
			bridge_ok: Result.is_equal (implementation.clipboard)
		end

feature -- Element Change

	set_help_accelerator (an_accelerator: EV_ACCELERATOR) is
			-- Assign `an_accelerator' to `help_accelerator'
		require
			not_destroyed: not is_destroyed
			an_accelerator_not_void: an_accelerator /= Void
		do
			implementation.set_help_accelerator (an_accelerator)
		ensure
			help_accelerator_assigned: help_accelerator = an_accelerator
		end

	set_contextual_help_accelerator (an_accelerator: EV_ACCELERATOR) is
			-- Assign `an_accelerator' to `contextual_help_accelerator'
		require
			not_destroyed: not is_destroyed
			an_accelerator_not_void: an_accelerator /= Void
		do
			implementation.set_contextual_help_accelerator (an_accelerator)
		ensure
			contextual_help_accelerator_assigned:
				contextual_help_accelerator = an_accelerator
		end

	set_help_engine (an_engine:  EV_HELP_ENGINE) is
			-- Assign `an_engine' to `help_engine'
		require
			not_destroyed: not is_destroyed
			an_engine_not_void: an_engine /= Void
		do
			implementation.set_help_engine (an_engine)
		ensure
			help_engine_set: help_engine = an_engine
		end

feature -- Basic operation

	launch is
			-- Start the application.
			-- This begins the event processing loop.
		require
			not_destroyed: not is_destroyed
			not_already_launched: not is_launched
		do
			is_launched := True
			implementation.launch
		ensure
			is_launched: is_launched
		rescue
			is_launched := False
		end

	process_events is
			-- Process any pending events.
			-- Pass control to the underlying native toolkit so that it can
			-- handle any events that may be in its queue.
			-- (Should be called from time to time during extended computation.)
		require
			not_destroyed: not is_destroyed
			is_launched: is_launched
		do
			implementation.process_events
		end

	process_events_until_stopped is
			-- Process all events until 'stop_processing' is called.
		require
			not_destroyed: not is_destroyed
			is_launched: is_launched
		do
			implementation.process_events_until_stopped
		end

	process_graphical_events is
			-- Process any pending paint events.
			-- Pass control to the GUI toolkit so that it can
			-- handle any paint events that may be in its queue.
		require
			not_destroyed: not is_destroyed
			is_launched: is_launched
		do
			implementation.process_graphical_events
		end

	stop_processing is
			--  Exit `process_events_until_stopped'.
		require
			not_destroyed: not is_destroyed
			is_launched: is_launched
		do
			implementation.stop_processing
		end

	sleep (msec: INTEGER) is
			-- Wait for `msec' milliseconds and return.
		require
			not_destroyed: not is_destroyed
			msec_non_negative: msec >= 0
		do
			implementation.sleep (msec)
		end

	enable_contextual_help is
			-- Change mouse cursor to help cursor.
			-- Capture mouse input.
			-- Send help context of widget being clicked to help engine for
			-- processing.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_contextual_help
		end

	display_help_for_widget (a_widget: EV_WIDGET) is
			-- Display contextual help for `a_widget', if any.
		require
			not_destroyed: not is_destroyed
			a_widget_not_void: a_widget /= Void
		do
			implementation.display_help_for_widget (a_widget)
		end

feature -- Status report

	is_launched: BOOLEAN
			-- Has `launch' been called?

	tooltip_delay: INTEGER is
			-- Time in milliseconds which the pointer must be stationary over
			-- a widget before a tooltip appears.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.tooltip_delay
		ensure
			bridge_ok: Result = implementation.tooltip_delay
		end

	default_tooltip_delay: INTEGER is 500
			-- Default delay in milleseconds for tooltips.

	focused_widget: EV_WIDGET is
			-- Widget that has keyboard focus.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.focused_widget
		ensure
			bridge_ok: Result = implementation.focused_widget
		end

	transport_in_progress: BOOLEAN
			-- Is a Pick and Drop transport currently in progress?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.transport_in_progress
		end

	ctrl_pressed: BOOLEAN is
			-- Is ctrl key currently pressed?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.ctrl_pressed
		end

	alt_pressed: BOOLEAN is
			-- Is alt key currently pressed?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.alt_pressed
		end

	shift_pressed: BOOLEAN is
			-- Is shift key currently pressed?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.shift_pressed
		end

	caps_lock_on: BOOLEAN is
			-- Is caps lock key currently on?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.caps_lock_on
		end

	is_display_remote: BOOLEAN
			-- Is application display remote?
			-- This function is primarily to determine if drawing to the display is optimal.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_display_remote
		end

feature -- Status setting

	set_tooltip_delay (a_delay: INTEGER) is
			-- Assign `a_delay' to `tooltip_delay'.
		require
			not_destroyed: not is_destroyed
			a_delay_non_negative: a_delay >= 0
		do
			implementation.set_tooltip_delay (a_delay)
		ensure
			assigned: tooltip_delay = a_delay
		end

feature -- Event handling

	do_once_on_idle (an_action: PROCEDURE [ANY, TUPLE]) is
			-- Perform `an_action' one time when the application is next idle.
			-- Thread safe
		require
			not_destroyed: not is_destroyed
		do
			implementation.do_once_on_idle (an_action)
		end

	add_idle_action (a_idle_action: PROCEDURE [ANY, TUPLE]) is
			-- Add `a_idle_actions' to `idle_actions' if not already present.
			-- Thread safe
		require
			a_idle_action_not_void: a_idle_action /= Void
		do
			implementation.add_idle_action (a_idle_action)
		end

	remove_idle_action (a_idle_action: PROCEDURE [ANY, TUPLE]) is
			-- Remove `a_idle_action' from `idle_actions'.
			-- Thread safe.
		require
			a_idle_action_not_void: a_idle_action /= Void
		do
			implementation.remove_idle_action (a_idle_action)
		end

feature {EV_ANY, EV_LITE_ACTION_SEQUENCE} -- Implementation

	action_sequence_call_counter: NATURAL_32
			-- Counter used in post-conditions to determine if any actions sequences have been
			-- called as a result of the routine the post-condition is applied to.

feature {EV_LITE_ACTION_SEQUENCE} -- Implementation

	increase_action_sequence_call_counter
			-- Increase `action_sequence_call_counter' by one.
		do
			action_sequence_call_counter := action_sequence_call_counter + 1
		end

feature {NONE} -- Contract support

	application_exists: BOOLEAN is
			-- Does the application exist? This is used to stop
			-- manipulation of widgets before an application is created.
			-- As we are now in the process of creating the application,
			-- we return True.
		do
			Result := True
		end

feature {EV_ANY, EV_ANY_I, EV_ABSTRACT_PICK_AND_DROPABLE, EV_SHARED_TRANSPORT_I, EXCEPTIONS, EV_ANY_HANDLER} -- Implementation

	implementation: EV_APPLICATION_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_APPLICATION_IMP} implementation.make (Current)
		end

invariant
	tooltip_delay_not_negative: tooltip_delay >= 0
	windows_not_void: windows /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_APPLICATION

