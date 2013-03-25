require 'spec_helper'

describe "tubemp tags" do
  before do
    get '/tags?v=D80QdsFWdcQ'
  end

  it "should have a page for a youtube ID" do
    last_response.should be_ok
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
