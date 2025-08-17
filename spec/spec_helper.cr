require "spec"
require "../src/pulse"

module SpecHelpers
  def self.with_test_server(handler : HTTP::Handler, &)
    server = HTTP::Server.new([handler]) do |context|
      context.response.status = HTTP::Status::NOT_FOUND
      context.response.print "Not Found"
    end

    address = server.bind_tcp("127.0.0.1", 0)
    port = address.port

    spawn do
      server.listen
    end

    sleep Time::Span.new(nanoseconds: 10_000)

    begin
      yield "http://127.0.0.1:#{port}"
    ensure
      server.close
    end
  end

  def self.make_request(url : String, method : String = "GET") : HTTP::Client::Response
    uri = URI.parse(url)
    HTTP::Client.new(uri) do |client|
      case method
      when "GET"
        client.get(uri.path || "/")
      when "POST"
        client.post(uri.path || "/")
      else
        raise "Unsupported method: #{method}"
      end
    end
  end

  def self.parse_json_response(response : HTTP::Client::Response) : JSON::Any
    JSON.parse(response.body)
  end
end
