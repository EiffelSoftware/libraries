indexing
	description: "Abstract OCI Descriptor"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"
	history: "$History: oci_descriptor.e $"

deferred class
	OCI_DESCRIPTOR

inherit
	OCI_HANDLE_ATTR
		rename
			handle as descriptor,
			handle_type as descriptor_type
		redefine
			allocate, free
		end

feature -- Status setting

	allocate (parent: OCI_HANDLE) is
			-- Allocate descriptor explicitly
		local
			status: INTEGER_16
			l_descriptor: like descriptor
		do
			status := oci_descriptor_alloc (parent.handle, $l_descriptor, descriptor_type, 0,
					default_pointer)
			descriptor := l_descriptor
			is_allocated := status = Oci_success
		end
		
feature -- Removal
			
	free is
			-- Free the descriptor
		local
			status: INTEGER_16
		do
			status := oci_descriptor_free (descriptor, descriptor_type)
			check
				success: status = Oci_success
			end
			is_allocated := False
		end
		
feature {NONE} -- Externals

	oci_descriptor_alloc (parenth: POINTER; descpp: POINTER; type: INTEGER; 
		xtramem_sz: INTEGER; usrmempp: POINTER): INTEGER_16 is
		external
			"C (void *, void **, int, int, void **): short | %"oci.h%""
		alias
			"OCIDescriptorAlloc"
		end
		
	oci_descriptor_free (descp: POINTER; type: INTEGER): INTEGER_16 is
		external
			"C (void *, int): short | %"oci.h%""
		alias
			"OCIDescriptorFree"
		end
		

end -- class OCI_DESCRIPTOR
