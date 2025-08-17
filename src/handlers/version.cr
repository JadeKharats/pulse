require "http/server"
require "json"

module PulseHandlers
  class VersionHandler
    include HTTP::Handler
    METHOD = "GET"

    def initialize(@version : String, @path : String = "/version")
    end

    def call(context)
      if match_endpoint(context)
        context.response.content_type = "application/json"
        context.response.print({
          version:   @version,
          timestamp: Time.utc.to_rfc3339,
        }.to_json)
      else
        call_next(context)
      end
    end

    private def match_endpoint(context) : Bool
      context.request.method == METHOD && context.request.path == @path
    end
  end
end
