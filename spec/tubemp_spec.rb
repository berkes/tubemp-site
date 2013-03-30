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

describe 'tubemp tags.json' do
  before do
    get 'tags.json?v=D80QdsFWdcQ'
  end

  it 'should have a json-version' do
    last_response.should be_ok
  end

  it 'should send json content-type' do
    last_response.content_type.should match /.*application\/json.*/
  end

  it 'should return the tags in json' do
    tags = JSON.parse(last_response.body.strip)

    tags.should be_kind_of(Hash)
    ["basic", "overlay"].each do |variation|
      tags[variation].should match IMAGE_RE
    end
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
