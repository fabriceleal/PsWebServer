# ######################################################################
# Light Http Web Server
# ######################################################################
# 
# ** Run as administrator **
# 
# http://msdn.microsoft.com/en-us/library/system.net.httplistener.aspx
# 
# TODO:
# 
# * Alterar modelo de escrever respostas,
#   tem de meter logo no contexto ...
# ...
# * SOAP (MIME types)
# * Assyncs...
# * Security (Auth, Certificates, ...)
# ...
# * Cookies (...)
# * SCRIPTING: asps, phps, perls, python, ruby, (...), CLISP
# 
# ?!? indexing by search engines ?!?
# 
# 
# ######################################################################

# Configurations #######################################################
. .\base.ps1	

# Configurations: how to handle resource asking ...
. .\rules.ps1

# ######################################################################
# Gerar em memoria a estrutura dos recursos (pastas / ficheiros / ...)
# Maps ... (? Associar 1 queryString a 1 recurso)
# (Regra especial, com regex match no parsing ...)
#
# ...
#

# Load assemblies ######################################################

[reflection.assembly]::loadWithPartialName( "system.net"  )  | out-null
[reflection.assembly]::loadWithPartialName( "system.text" )  | out-null
[reflection.assembly]::loadWithPartialName( "system.io"   )  | out-null
[reflection.assembly]::loadWithPartialName( "system.web"  )  | out-null

# ######################################################################

# Setup Listener
$listener = new-object System.Net.HttpListener

foreach ($prefix in $PREFIXES){ 
	$listener.Prefixes.Add($prefix) 
}

# Start Listener
$listener.start()

# ** Blocking call **

$result = $listener.getContext()

processContext $result | out-null

$result

# Stop Listener
$listener.stop()

# ######################################################################
