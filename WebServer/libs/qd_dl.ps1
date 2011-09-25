# ######################################################################
# 
# Quick and Dirty Deserialization Library
#
# ######################################################################

# Special parameters to constructors???



# Updates the values in the properties of an object

function setObjectHash( $object, [HashTable] $values ){
	
	# Try to set the maximum number of properties
	
	# ...
	
	return $object
}

function getObjectHash( $object ){
	$ret = new-object HashTable
	
	# Create a key for each writable property in $object
	
	# ...
	
	return $ret
}