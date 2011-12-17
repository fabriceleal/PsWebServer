# #####################################################
# Base Web Server preprocessing rules
# #####################################################
#
# Exports:
#
# processContext( System.Net.HttpListenerContext )
#
#
# #####################################################
#
# Delegate here behaviour to a CGI script or to a fixed page; 
# Create here http error codes 
#
#
# #####################################################


# #####################################################
# Load CGI (if you wish ...)
# #####################################################
# ...
. .\cgi\1.1\cgi.ps1

# #####################################################
# Aux Variables ...
# #####################################################


$notfound = 
		"<html>" +
			"<head></head>" +
			"<body>" +
				"<p>" +
					"Error 404" +
				"</p>" +
			"</body>" +
		"</html>"

		
# #####################################################
# Rules (tree / hash structure recommended ... )
# #####################################################

# TODO: Rules should not return string, they should directly with the HttpListenerContext ...
# They should return $true to signal proper handling.

$rules = @(
			@(
				{ $false },
				{
					cgiProcessContext $args[0]
				}
			),
			# Rule nbr. 1
			@(
				{
					# Evaluate something with context ...					
					# Return boolean
					($args[0].Request.HttpMethod -eq "GET") -and ($args[0].Request.RawUrl -eq "/")
				},
				{
					# Do stuff with context ...
					# Return string
					"<html>" + 
						"<head></head>" +
						"<body>index for you!!!</body>" +
					"</html>"
				}
			),
			# Rule nbr. 2
			@(
				{
					# Evaluate something with context ...
					# Return boolean
					($args[0].Request.HttpMethod -eq "GET") -and ($args[0].Request.RawUrl -match "(/.+){1,}/?")
				},
				{
					# Do stuff with context ...
					# Return string
					"<html>" + 
						"<head></head>" +
						"<body>" + 
						
						"</body>" +
					"</html>"
				}
			)
		)

		
# #####################################################
# Other aux functions ...
# #####################################################
# ...

	
# #####################################################
# Rules evaluator and response generator
# #####################################################
#
# It should manipulate $context so the response be writed in $context.Response; 
# the outputStream in $context.Response should be closed
#
# #####################################################

function processContext([System.Net.HttpListenerContext] $context)
{
	$response = $context.Response

	# ##################################################################
	# Implement and reimplement as you wish:
	
	
	# Error message (no rule match ...)
	$strBuffer = $notfound

	# Evaluate rules. First rule found will build the response ...
	foreach($rule in $rules){
		if ( 
			( & $rule[0] $context ) -eq $true.toString()
		){
			
			$strBuffer = & $rule[1] $context
			#" ** RULE MATCH ** " | write-host
			break;
		}
	}
	
	# ##################################################################
	# This is standard:

	
	# Get StrBuffer bytes
	$buffer = [System.Text.Encoding]::Utf8.GetBytes( $strBuffer )

	# Write into Stream	
	$response.contentEncoding = [System.Text.Encoding]::Utf8
	$response.contentLength64 = $buffer.Length
	$output = $response.outputStream	
	$output.write( $buffer, 0, $buffer.Length )
	
	# DO NOT FORGET TO CLOSE STREAM
	$output.close()
	
	$buffer = $null
	$strBuffer = $null
		
	return $response	
}