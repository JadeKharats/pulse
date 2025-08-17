require "json"
require "http/server"

module PulseHandlers
  VERSION = "0.1.0"

  # TODO: Put your code here
  class VersionHandler
    include HTTP::Handler

    def initialize(@version : String, @path : String = "/version")
    end

    def call(context)
      if context.request.method == "GET" && context.request.path == @path
        context.response.content_type = "application/json"
        context.response.print({
          version:   @version,
          timestamp: Time.utc.to_rfc3339,
        }.to_json)
      else
        call_next(context)
      end
    end
  end
end
