function localLoadAsModule( $script_block ){
	$name = "MODULE_" + $script_block.getHashCode().toString();
	#write-host $name
	localLoadAsModulewName $script_block $name 
}

function localLoadAsModulewName( $script_block, $name ){
	$dll = new-module -name $name -scriptBlock $script_block
	import-module -moduleInfo $dll
}

# Main
$code = {

	function LoadFile( $filename ){ LoadFilewName $filename $filename }
	
	function LoadFilewName( $filename, $name){
		$code = [system.io.file]::readAllText( $filename )
		$script_block = [System.Management.Automation.ScriptBlock]::Create( $code )
		LoadScriptwName $script_block $name
	}

	function LoadScript( $script_block ){ localLoadAsModule( $script_block ) }
	
	function LoadScriptwName( $script_block, $name ){ localLoadAsModule $script_block $name }

	export-modulemember -Function LoadScript, LoadScriptwName, LoadFile, LoadFilewName
}

# Load itself in memory
localLoadAsModule($code)