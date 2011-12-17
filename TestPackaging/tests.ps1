
# Load module loader
. .\main.ps1

$pwd = pwd

LoadFile( [system.io.path]::combine($pwd, "libs\lib1.ps1") )

LoadFile( [system.io.path]::combine($pwd, "libs\lib2.ps1") )

add2;
add2;
add2;
add;
add;
add;