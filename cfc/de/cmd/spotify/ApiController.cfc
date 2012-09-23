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
		OPTION_ALBUM    = "album";
		return this;
	}

	public string function test() {
		return testConnection("http://www.spotify.com").status_code;
	}

	// do a testconnection to any url you want
	public struct function testConnection(string targetUrl) {
		http url="#arguments.targetUrl#" method="HEAD" result="testCall" timeout="10" {
			httpparam type="Header" name="Accept" value="application/json";
		};
		return testCall;
	}

	/**
	* Dynamically build search query
	* 
	* @param query struct with search parameters
	*/
	public any function buildQuery(string option = "", required struct query, boolean lookup = false ) {
		var targetUrl  = IIf( not arguments.lookup, DE("#BASE_URL_SEARCH##arguments.option#"), DE("#BASE_URL_LOOKUP##arguments.option#") );
		var queryLoop  = 0;
		var connect    = "";
		var result     = "";

		//"#BASE_URL_LOOKUP#?uri=spotify:artist:4YrKBkKSVeqDamzBPWVnSJ&extras=album"

		for (filter in arguments.query) {
			targetUrl = "#targetUrl##IIf( queryLoop gt 0, DE("&"), DE("?") )##filter#=#arguments.query[filter]#";
			queryLoop++;
		}

		//return targetUrl; 
		
		http url="#targetUrl#" method="GET" result="httpResult" {
			httpparam type="Header" name="Accept" value="application/json";
		};
		result               = deserializeJSON( httpResult.fileContent );
		result["requestUrl"] = targetUrl;

		return result;
	}

	public any function lookupArtistAlbums( boolean details = false ) {
		if( details ){
			return this.buildQuery( "", { "uri":"spotify:artist:4YrKBkKSVeqDamzBPWVnSJ", "extras" : "albumdetail" }, true );
		}else{
			return this.buildQuery( "", { "uri":"spotify:artist:4YrKBkKSVeqDamzBPWVnSJ" }, true );
		}
	}

	public any function lookupAlbumTracks( boolean details = false ) {
		if( details ){
			return this.buildQuery( "", { "uri":"spotify:album:6G9fHYDCoyEErUkHrFYfs4", "extras" : "albumdetail" }, true );
		}else{
			return this.buildQuery( "", { "uri":"spotify:album:6G9fHYDCoyEErUkHrFYfs4", "extras" : "track" }, true );
		}
	}

	public any function lookupTrack() {
		return this.buildQuery( "", { "uri":"spotify:track:6NmXV4o6bmp704aPGyTVVG" }, true );
	}

	/**
	* get a list of new album releases
	* 
	* info source: http://pansentient.com/2010/01/whats-new-on-spotify-resolved-kinda/
	*/
	public any function getNewAlbums() {
		return this.searchTag("new");
	}

	private any function searchTag(string tag) {
		return this.buildQuery( OPTION_ALBUM, { "q":"tag:#arguments.tag#" } );
	}
	
	public any function getAlbumsByYear(numeric  year) {
		return this.buildQuery( OPTION_ALBUM, { "q":"year:#arguments.year#" } );
	}

	public any function getAlbumByName(string name) {
		return this.buildQuery( OPTION_ALBUM, { "q":"album:#arguments.name#" } );
	}
	
	public any function getTrackByName(string trackName) {
		arguments.trackName = replace("#arguments.trackName#", " ", "+", "ALL");
		return this.buildQuery( OPTION_TRACK, { "q":arguments.trackName } );
	}

	public any function getArtistByName(string artistName) {
		arguments.artistName = replace("#arguments.artistName#", " ", "+", "ALL");
		return this.buildQuery( OPTION_ARTIST, { "q":arguments.artistName } );
	}

	/**
	* full spotify genre list:
	* https://spreadsheets.google.com/pub?key=psnjFY3R2itsqjinSs9hkZw
	*/
	public any function getAlbumsByGenre(string name) {
		return this.buildQuery( OPTION_ALBUM, { "q":"genre:#arguments.name#" } );
	}

	/**
	* Be able to search for labels like EMI, BMG or Universal
	*/
	public any function getAlbumsByLabel(string name) {
		return this.buildQuery( OPTION_ALBUM, { "q":"label:#arguments.name#"} );
	}

}