indexing
	description: "Implemented `IPropertyNotifySink' Interface."
	date: "$Date$"
	revision: "$Revision$"

class
	IPROPERTY_NOTIFY_SINK_IMPL

inherit
	IPROPERTY_NOTIFY_SINK_INTERFACE

	OLE_CONTROL_PROXY

feature -- Basic Operations

	on_changed (disp_id: INTEGER) is
			-- No description available.
			-- `disp_id' [in].  
		do
			-- Put Implementation here.
		end

	on_request_edit (disp_id: INTEGER) is
			-- No description available.
			-- `disp_id' [in].  
		do
			-- Put Implementation here.
		end


end -- IPROPERTY_NOTIFY_SINK_IMPL

