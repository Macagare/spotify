Spotify API

<cfset spotifyApi = createObject("component", "cfc.de.cmd.spotify.ApiController") />
<cfset connection = spotifyApi.test() />
<cfdump var="#connection#" />