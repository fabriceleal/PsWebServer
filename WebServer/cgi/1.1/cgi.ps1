# #####################################################
# Powershell Implementation of CGI 1.1
# #####################################################
#
# Exports:
#
#
# #####################################################
# (description)
# #####################################################


# DO NOT LAUCH WITHOUT CONFIG FILES !!!
# Read $CONFIG first; it should override $GENERAL_CONFIG
#. ..\base.ps1
#. .\conf.ps1


#
# Responsable for setting processes' environment, 
# calling processes, grab their output, and update HttpListenerContext
#


function cgiProcessContext( [System.Net.HttpListenerContext] $context ){
	# Do CGI stuff: 
	
	#$stdout = new-object System.IO.MemoryStream
	#$stdout_reader = new-object System.IO.StreamReader( $stdout )
	
	# Setup Environment using $context ...	
    # HttpMethod, QueryString, Cookies, Headers, ...    	
    $cgiEnv   = @{
			"teste"  = "123";
			"teste2" = "456" 
		}

	$filename = "powershell"
    $args     = "/?"

	# Setup Process ############################################################
	$procSt = new-object System.Diagnostics.ProcessStartInfo
    $procSt.arguments = $args # String
    $procSt.createNoWindow = $true
    $procSt.domain = "" # String
	foreach($key in $cgiEnv.keys){		
		$procSt.environmentVariables.Add( $key , $cgiEnv[ $key ] )
	}
	
	#$procSt.userName = "Fabrice Leal" # String
	#$procSt.password = $null # SecureString
	
    $procSt.fileName = $filename # String
    $procSt.loadUserProfile = $false
        
    $procSt.redirectStandardOutput = $true
	$procSt.standardOutputEncoding = [system.text.encoding]::utf8
    $procSt.redirectStandardError = $true
    $procSt.standardErrorEncoding = [system.text.encoding]::utf8    
    
    $procSt.useShellExecute = $false
    $procSt.workingDirectory = "C:\"
    
	# Lauch Process ############################################################
    $proc = new-object System.Diagnostics.Process	
    $proc.StartInfo = $procSt
	$proc.Start() | out-null # Returns True/False: DO proper handling of this result
	#"PID = " + $proc.Id	| write-host 
	$proc.WaitForExit() 	
	
	# Take output from Process #################################################
	
	$strBuffer = $proc.StandardOutput.ReadToEnd()
	
	# ... Tests ... you can delete this
	$strBuffer = [System.Web.HttpUtility]::HtmlEncode( $strBuffer )
	$strBuffer = $strBuffer.replace( [Environment]::NewLine , "<br />" )
	$strBuffer = $strBuffer.replace( [Environment]::NewLine.ToCharArray()[0].toString() , "<br />" )
	$strBuffer = $strBuffer.replace( [Environment]::NewLine.ToCharArray()[1].toString() , "<br />" )

	
	$strBuffer = 
		"<html>" +
			"<head></head>" +
			"<body>" +
				$strBuffer +
			"</body>" +
		"</html>"

	# Update $context, if needed, from environment ... #########################

	# Return $context (just to make sure) ######################################
	return $strBuffer
}

# TEST ...
#cgiProcessContext( $null )











