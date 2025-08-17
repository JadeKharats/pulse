require "../spec_helper"

describe PulseHandlers::VersionHandler do
  it "return setted version" do
    handler = PulseHandlers::VersionHandler.new("1.2.3")

    SpecHelpers.with_test_server(handler) do |base_url|
      # Test /version endpoint
      version_response = SpecHelpers.make_request("#{base_url}/version")
      version_response.status_code.should eq(200)
      version_response.headers["Content-Type"].should eq("application/json")

      version_json = SpecHelpers.parse_json_response(version_response)
      version_json["version"].should eq("1.2.3")
    end
  end
  it "return setted version with custom path" do
    handler = PulseHandlers::VersionHandler.new("4.2.1", "/custom/version")

    SpecHelpers.with_test_server(handler) do |base_url|
      # Test /version endpoint
      version_response = SpecHelpers.make_request("#{base_url}/custom/version")
      version_response.status_code.should eq(200)
      version_response.headers["Content-Type"].should eq("application/json")

      version_json = SpecHelpers.parse_json_response(version_response)
      version_json["version"].should eq("4.2.1")
    end
  end
end
