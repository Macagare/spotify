Spotify API

<cfset spotifyApi = createObject("component", "cfc.de.cmd.spotify.ApiController").init() />
<cfset connection = spotifyApi.test() />
<cfset results = "" />
<cfif findNoCase("200", "#connection#") >
    <cfif structKeyExists(url, "track")>
        <cfset results = spotifyApi.getTrackByName(url.track) />
        <cfdump var="#results#" />
    </cfif>
    <cfif structKeyExists(url, "artist")>
        <cfset results = spotifyApi.getArtistByName(url.artist) />
        <cfdump var="#results#" />
    </cfif>
    <cfif structKeyExists(url, "albums")>
        <cfset results = spotifyApi.lookupArtistAlbums( structKeyExists(url, "details") ) />
        <cfdump var="#results#" />
    </cfif>
    <cfif structKeyExists(url, "tracks")>
        <cfset results = spotifyApi.lookupAlbumTracks( structKeyExists(url, "details") ) />
        <cfdump var="#results#" />
    </cfif>
    <cfif structKeyExists(url, "trackdetails")>
        <cfset results = spotifyApi.lookupTrack() />
        <cfdump var="#results#" />
    </cfif>
    <cfif structKeyExists(url, "newalbum")>
        <cfset results = spotifyApi.getNewAlbums() />
        <cfdump var="#results#" />
    </cfif>
    <cfif structKeyExists(url, "year")>
        <cfset results = spotifyApi.getAlbumsByYear(url.year) />
        <cfdump var="#results#" />
    </cfif>
    <cfif structKeyExists(url, "albumname")>
        <cfset results = spotifyApi.getAlbumByName(url.albumname) />
        <cfdump var="#results#" />
    </cfif>
    <cfif structKeyExists(url, "genre")>
        <cfset results = spotifyApi.getAlbumsByGenre(url.genre) />
        <cfdump var="#results#" />
    </cfif>
    <cfif structKeyExists(url, "label")>
        <cfset results = spotifyApi.getAlbumsByLabel(url.label) />
        <cfdump var="#results#" />
    </cfif>
<cfelse>
    <cfoutput>There seems to be a problem with the connection!</cfoutput>
</cfif>

