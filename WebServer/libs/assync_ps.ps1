#
# Assyncronous powershell :O
#



$codeTmp = @"
namespace Generator{

	public class CallbackGenerator{
		
		public CallbackGenerator(){
		
		}	
	}
}	
"@


# AsyncCallback callback = CALLBACK_FUNCTION( ... )
# IAsyncResult FUNCTION(callback AsyncCallback , object State )
# Take a ScriptBlock and Generate a 