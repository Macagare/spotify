Spotify API

<cfset spotifyApi = createObject("component", "cfc.de.cmd.spotify.ApiController").init() />
<cfset connection = spotifyApi.test() />
<cfset results = "" />
<cfif findNoCase("200", "#connection#") >
    <cfif structKeyExists(url, "track")>
        <cfoutput>Find track: #url.track#</cfoutput>
        <cfset results = spotifyApi.findTrack(url.track) />
        <cfdump var="#results#" />
    </cfif>
    <cfif structKeyExists(url, "artist")>
        <cfoutput>Find artist: #url.artist#</cfoutput>
        <cfset results = spotifyApi.findArtist(url.artist) />
        <cfdump var="#results#" />
    </cfif>
    <cfif structKeyExists(url, "albums")>
        <cfoutput>Find artist albums:</cfoutput>
        <cfset results = spotifyApi.lookupArtistAlbums( structKeyExists(url, "details") ) />
        <cfdump var="#results#" />
    </cfif>
    <cfif structKeyExists(url, "tracks")>
        <cfoutput>Find artist albums:</cfoutput>
        <cfset results = spotifyApi.lookupAlbumTracks( structKeyExists(url, "details") ) />
        <cfdump var="#results#" />
    </cfif>
    <cfif structKeyExists(url, "trackdetails")>
        <cfoutput>Find artist albums:</cfoutput>
        <cfset results = spotifyApi.lookupTrack() />
        <cfdump var="#results#" />
    </cfif>
    <cfif structKeyExists(url, "newalbum")>
        <cfoutput>Find new Albums:</cfoutput>
        <cfset results = spotifyApi.getNewAlbums() />
        <cfdump var="#results#" />
    </cfif>
<cfelse>
    <cfoutput>There seems to be a problem with the connection!</cfoutput>
</cfif>

