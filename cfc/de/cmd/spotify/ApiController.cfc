/**
*
* @file  spotify/cfc/de/cmd/spotify/ApiController.cfc
* @author Christian Müller  
* @description This class controlls the Spotify API calls.
*
*/

component output="false" displayname=""  {

	public function init(){
		return this;
	}

	// do a testconnection to any url you want
	public struct function testConnection(string targetUrl) {
		http url="#arguments.targetUrl#" method="HEAD" result="testCall" timeout="10" {};
		return testCall;
	}


	public string function test() {
		return testConnection("http://www.google.com").status_code;
	}
	
	
}