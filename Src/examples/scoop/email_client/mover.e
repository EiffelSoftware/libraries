note
	description: "Moves email messages from the inbox to an archive file (in this case: /dev/null)."
	author: "Chandrakana Nandi"
	date: "$Date$"
	revision: "$Revision$"

class
	MOVER

create
	make

feature {NONE} -- Initialization

	make (a_messages: like messages; a_controller: like controller)
			-- Initialization for `Current'.
		do
			messages := a_messages
			controller := a_controller
		end

feature -- Access

	Min: INTEGER = 100
			-- The number of items which should be left in the message list after archiving.

	Max: INTEGER = 1000
			-- The maximum number of items in the message list before archiving should be triggered.

	messages: separate LINKED_LIST[separate STRING]
			-- The list of emails whose size should be watched over.

	controller: separate CONTROLLER
			-- A separate controller which indicates when to stop execution.

feature -- Status report

	is_over: BOOLEAN
			-- Shall `Current' stop its operation?
		do
			separate controller as c do
				Result := c.is_over
			end
		end

	is_ready(ml: separate LINKED_LIST[separate STRING]): BOOLEAN
			-- Has the size of `ml' reached `Max' messages?
		do
			Result := (ml.count >= Max)
		end

feature -- Basic operations

	live
			--Keep watching for client's mailbox to reach Max messages,
			--and when it does, remove all messages except the last Min ones.
		do
			from until is_over loop
				trim (messages, controller)
			end
		end

	trim (ml: separate LINKED_LIST[separate STRING]; a_controller: separate CONTROLLER)
			-- Remove all messages from `ml' except the last Min ones.
		require
			ml.count > Max
					-- This ensures that the mover can terminate as well.
				or a_controller.is_over
		do
				-- There's no feature to remove a sequence from a list,
				-- so we have to do it manually.
			from
				ml.start
			until
				ml.count <= Min
			loop
				ml.remove
			end
			print("Size after trimming: " + ml.count.out + "%N")
		end

invariant
	correct_constants: Min < Max
end
