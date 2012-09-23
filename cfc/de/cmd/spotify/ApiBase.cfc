/**
*
* @file  cfc/de/cmd/spotify/ApiBase.cfc
* @author  
* @description
*
*/

component output="false" displayname=""  {

    property string BASE_URL_SEARCH; // simple search
    property string BASE_URL_LOOKUP; // get detailed information by id
    
    public function init(){
        BASE_URL_SEARCH = " http://ws.spotify.com/search/1/";
        BASE_URL_LOOKUP = " http://ws.spotify.com/lookup/1/";

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
    * @private
    */
    private string function buildQueryString(string option = "", required struct query, boolean lookup = false) {
        var targetUrl  = IIf( not arguments.lookup, DE("#BASE_URL_SEARCH##arguments.option#"), DE("#BASE_URL_LOOKUP##arguments.option#") );
        var queryLoop  = 0;
        var connect    = "";

        for (filter in arguments.query) {
            targetUrl = "#targetUrl##IIf( queryLoop gt 0, DE("&"), DE("?") )##filter#=#URLEncodedFormat(arguments.query[filter])#";
            queryLoop++;
        }

        return targetUrl;
    }
    
    /**
    * Dynamically build search query
    * 
    * @param query struct with search parameters
    */
    public struct function buildQuery(string option = "", required struct query, boolean lookup = false ) {
        var targetUrl = this.buildQueryString( arguments.option, arguments.query, arguments.lookup );
        http url="#targetUrl#" method="GET" result="httpResult" {
            httpparam type="Header" name="Accept" value="application/json";
        };
        result               = deserializeJSON( httpResult.fileContent );
        result["requestUrl"] = targetUrl;

        return result;
    }
}