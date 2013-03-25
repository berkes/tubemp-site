require 'spec_helper'

describe "tubemp main" do
  before do
    get '/D80QdsFWdcQ'
  end

  it "should have a page for a youtube ID" do
    last_response.should be_ok
  end
end
