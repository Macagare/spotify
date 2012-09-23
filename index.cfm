Spotify API

<cfset spotify = createObject("component", "cfc.de.cmd.spotify.ApiWrapper").init() />
<cfset connection = spotify.test() />
<cfset results = "" />
<cfif findNoCase("200", "#connection#") >
    <cfif structKeyExists(url, "track")>
        <cfset results = spotify.getTrackByName(url.track) />
    </cfif>
    <cfif structKeyExists(url, "artist")>
        <cfset results = spotify.getArtistByName(url.artist) />
    </cfif>
    <cfif structKeyExists(url, "albums")>
        <cfset results = spotify.lookupArtistAlbums( structKeyExists(url, "details") ) />
    </cfif>
    <cfif structKeyExists(url, "tracks")>
        <cfset results = spotify.lookupAlbumTracks( structKeyExists(url, "details") ) />
    </cfif>
    <cfif structKeyExists(url, "trackdetails")>
        <cfset results = spotify.lookupTrack() />
    </cfif>
    <cfif structKeyExists(url, "newalbum")>
        <cfset results = spotify.getNewAlbums() />
    </cfif>
    <cfif structKeyExists(url, "year")>
        <cfset results = spotify.getAlbumsByYear(url.year) />
    </cfif>
    <cfif structKeyExists(url, "albumname")>
        <cfset results = spotify.getAlbumByName(url.albumname) />
    </cfif>
    <cfif structKeyExists(url, "genre")>
        <cfset results = spotify.getAlbumsByGenre(url.genre) />
    </cfif>
    <cfif structKeyExists(url, "label")>
        <cfset results = spotify.getAlbumsByLabel(url.label) />
    </cfif>
    <cfdump var="#results#" />
<cfelse>
    <cfoutput>There seems to be a problem with the connection!</cfoutput>
</cfif>

