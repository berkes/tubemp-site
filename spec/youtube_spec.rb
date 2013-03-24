require File.join(File.dirname(__FILE__), "..", "lib", "youtube")
require 'filemagic'

IMAGE_RE = /\<img.*src="(.*)".*alt="(.*).*\/\>/
describe YouTube do
  before do
    @id = "D80QdsFWdcQ"
    @yt = YouTube.new @id
  end

  describe '#img_tag' do
    it 'should render a valid image tag' do
      @yt.img_tag.should =~ IMAGE_RE
    end

    it 'should link to a thumbnail in PNG format' do
      img = @yt.img_tag.match IMAGE_RE
      src = img[1]
      src.should =~ /#{@id}\.png/
    end

    it 'should create its thumb in "public/thumbs" dir' do
      filename = File.join("public", "thumbs", "#{@id}.png")
      File.delete filename if File.exists? filename

      @yt.img_tag
      File.exists?(filename).should be_true
    end
  end
end
