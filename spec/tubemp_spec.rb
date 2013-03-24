require 'spec_helper'

describe "tubemp main" do
  it "should have a page for a youtube ID" do
    get '/D80QdsFWdcQ'
    last_response.should be_ok
  end
end
