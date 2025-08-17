require "./spec_helper"

describe PulseHandlers do
  it "have shards version from shards.yml" do
    PulseHandlers::VERSION.should eq "0.1.0"
  end
end
