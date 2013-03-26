require 'spec_helper'

describe "tubemp tags" do
  it "should have a page for a youtube ID" do
    get '/tags?v=D80QdsFWdcQ'
    last_response.should be_ok
  end

  it 'should give a 404 on an invalid ID' do
    get 'tags?v=INVALID'
    last_response.should be_not_found
  end
end

describe "tubemp /" do
  before do
    get '/'
  end

  it 'should have an index page' do
    last_response.should be_ok
  end
end
