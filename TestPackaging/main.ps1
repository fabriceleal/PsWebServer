function local-Load-As-Module( $scriptBlock ){
	local-Load-As-Module( $scriptBlock, "MODULE_" $scriptBlock.getHashCode().toString() )
}

function local-Load-As-Module( $scriptBlock, $name ){
	$dll = new-module -name $name -scriptBlock $scriptBlock
	import-module -moduleInfo $dll
}

# Main
$code = {

	function Load-File( $filename ){ Load-File-wName( $filename, $filename) }
	
	function Load-File-wName( $filename, $name){
		$code = [system.io.file]::readAllText( $filename )
		$script_block = [System.Management.Automation.ScriptBlock]::Create( $code )
		Load-Script-wName( $script_block, $name )
	}

	function Load-Script( $scriptBlock ){ local-Load-As-Module( $scriptBlock ) }
	
	function Load-Script-wName( $scriptBlock, $name ){ local-Load-As-Module( $scriptBlock, $name ) }

	export-modulemember -Function Load-Script, Load-Script-wName, Load-File, Load-File-wName
}

# Load itself in memory
local-Load-As-Module($code)