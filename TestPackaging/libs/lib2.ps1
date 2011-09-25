

$script:var_teste2 = 0;  


function add2(){
	$script:var_teste2 += 1
}


export-modulemember -function add2 -Variable script:var_teste2