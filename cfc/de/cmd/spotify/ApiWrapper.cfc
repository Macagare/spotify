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

component output="false" displayname="" extends="ApiBase"  {

	
	property string OPTION_TRACK;
	property string OPTION_ARTIST;

	public function init(){
		SUPER.init();
		
		OPTION_TRACK    = "track";
		OPTION_ARTIST   = "artist";
		OPTION_ALBUM    = "album";
		return this;
	}

	public struct function lookupArtistAlbums( boolean details = false ) {
		if( details ){
			return this.buildQuery( "", { "uri":"spotify:artist:4YrKBkKSVeqDamzBPWVnSJ", "extras" : "albumdetail" }, true );
		}else{
			return this.buildQuery( "", { "uri":"spotify:artist:4YrKBkKSVeqDamzBPWVnSJ" }, true );
		}
	}

	public struct function lookupAlbumTracks( boolean details = false ) {
		if( details ){
			return this.buildQuery( "", { "uri":"spotify:album:6G9fHYDCoyEErUkHrFYfs4", "extras" : "albumdetail" }, true );
		}else{
			return this.buildQuery( "", { "uri":"spotify:album:6G9fHYDCoyEErUkHrFYfs4", "extras" : "track" }, true );
		}
	}

	public struct function lookupTrack() {
		return this.buildQuery( "", { "uri":"spotify:track:6NmXV4o6bmp704aPGyTVVG" }, true );
	}

	/**
	* get a list of new album releases
	* 
	* info source: http://pansentient.com/2010/01/whats-new-on-spotify-resolved-kinda/
	*/
	public struct function getNewAlbums() {
		return this.searchTag("new");
	}

	private struct function searchTag(string tag) {
		return this.buildQuery( OPTION_ALBUM, { "q":"tag:#arguments.tag#" } );
	}
	
	public struct function getAlbumsByYear(numeric  year) {
		return this.buildQuery( OPTION_ALBUM, { "q":"year:#arguments.year#" } );
	}

	public struct function getAlbumByName(string name) {
		return this.buildQuery( OPTION_ALBUM, { "q":"album:#arguments.name#" } );
	}
	
	public struct function getTrackByName(string trackName) {
		arguments.trackName = replace("#arguments.trackName#", " ", "+", "ALL");
		return this.buildQuery( OPTION_TRACK, { "q":arguments.trackName } );
	}

	public struct function getArtistByName(string artistName) {
		arguments.artistName = replace("#arguments.artistName#", " ", "+", "ALL");
		return this.buildQuery( OPTION_ARTIST, { "q":arguments.artistName } );
	}

	/**
	* full spotify genre list:
	* https://spreadsheets.google.com/pub?key=psnjFY3R2itsqjinSs9hkZw
	*/
	public struct function getAlbumsByGenre(string name) {
		return this.buildQuery( OPTION_ALBUM, { "q":"genre:#arguments.name#" } );
	}

	/**
	* Be able to search for labels like EMI, BMG or Universal
	*/
	public struct function getAlbumsByLabel(string name) {
		return this.buildQuery( OPTION_ALBUM, { "q":"label:#arguments.name#"} );
	}

}