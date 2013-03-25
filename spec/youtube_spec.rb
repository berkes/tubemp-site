require File.join(File.dirname(__FILE__), "..", "lib", "youtube")

IMAGE_RE = /\<img.*src="(.*)".*alt="(.*).*\/\>/
LINK_RE  = /\<a.*href="(.*)".*\>/

describe YouTube do
  before do
    info = mock("video");
    info.stub(:title).and_return("Tony Tribe , Red Red Wine")
    info.stub(:thumbnail_large).and_return("http://i.ytimg.com/vi/D80QdsFWdcQ/hqdefault.jpg")
    VideoInfo.stub(:get).and_return info

    @id = "D80QdsFWdcQ"
    @yt = YouTube.new @id, {:base_url => "http://example.com"}
    @filename = File.join("public", "thumbs", "#{@id}.png")
  end

  describe '#tags' do
    context "valid ID" do
      it 'should render a list of valid image tags' do
        @yt.tags.each {|t| t.should match IMAGE_RE }
      end

      it 'should link to a thumbnail in PNG format' do
        img = @yt.tags[0].match IMAGE_RE
        src = img[1]
        src.should =~ /#{@id}\.png/
      end

      it 'should link to the overlayed thumbnail with overlay=true' do
        img = @yt.tags[1].match IMAGE_RE
        src = img[1]
        src.should =~ /#{@id}_overlay\.png/
      end

      it 'should link to an absolute URL' do
        img = @yt.tags[0].match IMAGE_RE
        src = img[1]
        src.should match /^http:\/\/.*$/
      end

      it 'should have the title as alt attribute' do
        @yt.tags[0].match(IMAGE_RE)[2].should match "Tony Tribe , Red Red Wine"
      end

      it 'should have a link pointing to the youtube video' do
        @yt.tags[0].match(LINK_RE)[1].should match /http:\/\/www\.youtube\.com/
      end

      context 'local image does not exist' do
        before do
          File.delete @filename if File.exists? @filename
        end

        it 'should create its thumb in "public/thumbs" dir' do
          @yt.tags
          File.exists?(@filename).should be_true
        end

        it 'should get the large thumbnail' do
          @yt.tags
          img = Magick::ImageList.new(@filename)
          img.rows.should >= 300
          img.columns.should >= 400
        end
      end

      context 'Image exists' do
        before do
          FileUtils.cp(root_path.join("spec", "fixtures", "thumb.jpg"), @filename)
          @existing = File.stat(@filename)
        end

        it 'should overwrite when a newer image is found online' do
          @yt.tags
          @existing.should_not eq File.stat(@filename)
        end
      end

      it 'should overlay a play-icon' do
        @yt.tags
        filename = File.join("public", "thumbs", "#{@id}_over.png")
        File.exists?(filename)
      end
    end # context "valid ID"
  end

  describe "#title" do
    it "should render a title" do
      @yt.title.should eq "Tony Tribe , Red Red Wine"
    end
  end

  describe "#href" do
    it 'should render a link' do
      @yt.href.should eq "http://www.youtube.com/watch?v=#{@id}"
    end
  end

end
