
#$modulo = "lib2"
#$pwd = pwd
#$codigo = [system.io.file]::readAllText( "$pwd\libs\lib2.ps1" )
#$script_block = [System.Management.Automation.ScriptBlock]::Create( $codigo )
#$DLL = new-module -name $modulo -scriptBlock $script_block
#import-module -moduleInfo $DLL

# Do Test-Path for all definitions ...

$itExists = Test-Path variable:script:var_teste
if($itExists -eq $false){
	$script:var_teste = 0;  
}

function add(){
	$script:var_teste += 1
}

function fun_teste(){
	return "456"
}  

function get_var_teste(){
	return $script:var_teste
}

export-modulemember -Function add, fun_teste, get_var_teste -Variable script:var_teste