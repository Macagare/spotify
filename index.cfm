Spotify API

<cfset spotifyApi = createObject("component", "cfc.de.cmd.spotify.ApiController").init() />
<cfset connection = spotifyApi.test() />
<cfset results = "" />
<cfif findNoCase("200", "#connection#") >
    <cfif structKeyExists(url, "track")>
        <cfset results = spotifyApi.getTrackByName(url.track) />
    </cfif>
    <cfif structKeyExists(url, "artist")>
        <cfset results = spotifyApi.getArtistByName(url.artist) />
    </cfif>
    <cfif structKeyExists(url, "albums")>
        <cfset results = spotifyApi.lookupArtistAlbums( structKeyExists(url, "details") ) />
    </cfif>
    <cfif structKeyExists(url, "tracks")>
        <cfset results = spotifyApi.lookupAlbumTracks( structKeyExists(url, "details") ) />
    </cfif>
    <cfif structKeyExists(url, "trackdetails")>
        <cfset results = spotifyApi.lookupTrack() />
    </cfif>
    <cfif structKeyExists(url, "newalbum")>
        <cfset results = spotifyApi.getNewAlbums() />
    </cfif>
    <cfif structKeyExists(url, "year")>
        <cfset results = spotifyApi.getAlbumsByYear(url.year) />
    </cfif>
    <cfif structKeyExists(url, "albumname")>
        <cfset results = spotifyApi.getAlbumByName(url.albumname) />
    </cfif>
    <cfif structKeyExists(url, "genre")>
        <cfset results = spotifyApi.getAlbumsByGenre(url.genre) />
    </cfif>
    <cfif structKeyExists(url, "label")>
        <cfset results = spotifyApi.getAlbumsByLabel(url.label) />
    </cfif>
    <cfdump var="#results#" />
<cfelse>
    <cfoutput>There seems to be a problem with the connection!</cfoutput>
</cfif>

