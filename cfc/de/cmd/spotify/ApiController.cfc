/**
*
* @file  spotify/cfc/de/cmd/spotify/ApiController.cfc
* @author Christian Müller  
* @description This class controlls the Spotify API calls.
*
* Search service: https://developer.spotify.com/technologies/web-api/search/
* Lookup service: https://developer.spotify.com/technologies/web-api/lookup/
* 
*/

component output="false" displayname=""  {

	property string BASE_URL_SEARCH; // simple search
	property string BASE_URL_LOOKUP; // get detailed information by id
	property string OPTION_TRACK;
	property string OPTION_ARTIST;

	public function init(){
		BASE_URL_SEARCH = " http://ws.spotify.com/search/1/";
		BASE_URL_LOOKUP = " http://ws.spotify.com/lookup/1/";
		OPTION_TRACK    = "track";
		OPTION_ARTIST   = "artist";
		return this;
	}

	// do a testconnection to any url you want
	public struct function testConnection(string targetUrl) {
		http url="#arguments.targetUrl#" method="HEAD" result="testCall" timeout="10" {
			httpparam type="Header" name="Accept" value="application/json";
		};
		return testCall;
	}


	public string function test() {
		return testConnection("http://www.spotify.com").status_code;
	}
	

	public any function findTrack(string trackName) {
		arguments.trackName = replace("#arguments.trackName#", " ", "+", "ALL");
		http url="#BASE_URL_SEARCH##OPTION_TRACK#?q=#arguments.trackName#" method="GET" result="httpResult" {
			httpparam type="Header" name="Accept" value="application/json";
		};
		return deserializeJSON( httpResult.fileContent );
	}

	public any function findArtist(string artistName) {
		arguments.artistName = replace("#arguments.artistName#", " ", "+", "ALL");
		http url="#BASE_URL_SEARCH##OPTION_ARTIST#?q=#arguments.artistName#" method="GET" result="httpResult" {
			httpparam type="Header" name="Accept" value="application/json";
		};
		return deserializeJSON( httpResult.fileContent );
	}


	public any function lookupArtistAlbums( boolean details = false ) {
		if( details ){
			http url="#BASE_URL_LOOKUP#?uri=spotify:artist:4YrKBkKSVeqDamzBPWVnSJ&extras=albumdetail" method="GET" result="httpResult" {
				httpparam type="Header" name="Accept" value="application/json";
			};
		}else{
			http url="#BASE_URL_LOOKUP#?uri=spotify:artist:4YrKBkKSVeqDamzBPWVnSJ&extras=album" method="GET" result="httpResult" {
				httpparam type="Header" name="Accept" value="application/json";
			};
		}
		return deserializeJSON( httpResult.fileContent );
	}

	public any function lookupAlbumTracks( boolean details = false ) {
		if( details ){
			http url="#BASE_URL_LOOKUP#?uri=spotify:album:6G9fHYDCoyEErUkHrFYfs4&extras=trackdetail" method="GET" result="httpResult" {
				httpparam type="Header" name="Accept" value="application/json";
			};
		}else{
			http url="#BASE_URL_LOOKUP#?uri=spotify:album:6G9fHYDCoyEErUkHrFYfs4&extras=track" method="GET" result="httpResult" {
				httpparam type="Header" name="Accept" value="application/json";
			};
		}
		return deserializeJSON( httpResult.fileContent );
	}

	public any function lookupTrack() {
		http url="#BASE_URL_LOOKUP#?uri=spotify:track:6NmXV4o6bmp704aPGyTVVG" method="GET" result="httpResult" {
			httpparam type="Header" name="Accept" value="application/json";
		};
		return deserializeJSON( httpResult.fileContent );
	}

	/**
	* get a list of new album releases
	* 
	* info source: http://pansentient.com/2010/01/whats-new-on-spotify-resolved-kinda/
	*/
	public any function getNewAlbums() {
		http url="#BASE_URL_SEARCH#album?q=tag:new" method="GET" result="httpResult" {
			httpparam type="Header" name="Accept" value="application/json";
		};
		return deserializeJSON( httpResult.fileContent );
	}

}