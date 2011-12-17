
$itExists = Test-Path variable:script:var_teste
if($itExists -eq $false){
	$script:var_teste2 = 0;  
}


function add2(){
	$script:var_teste2 += 1;
	return $script:var_teste2;
}


export-modulemember -function add2 -Variable script:var_teste2