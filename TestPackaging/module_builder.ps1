# http://msdn.microsoft.com/en-us/library/dd878297(v=VS.85).aspx
# http://huddledmasses.org/powershell-modules/
# http://dotnetslackers.com/articles/net/Converting-a-PowerShell-Script-into-a-Module.aspx

# colocar em pasta dentro de 1 dos dirs em "Env:\PSModulePath"

$script

$modulo = "lib1"
$pwd = pwd
$codigo = [system.io.file]::readAllText( "$pwd\libs\lib1.ps1" )
$script_block = [System.Management.Automation.ScriptBlock]::Create( $codigo )
$DLL = new-module -name $modulo -scriptBlock $script_block
import-module -moduleInfo $DLL


#$DLL
$var_teste = 0


"---" | write-host
add
"var_teste: " | write-host
$var_teste | write-host
add
"fun_teste: "| write-host
fun_teste | write-host
add
"get_var_teste: " | write-host
get_var_teste | write-host
"---" | write-host


# Unload ALL
# Get-Module | foreach { Remove-Module -ModuleInfo $_ }