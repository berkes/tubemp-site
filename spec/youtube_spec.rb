require File.join(File.dirname(__FILE__), "..", "lib", "youtube")

IMAGE_RE = /\<img.*src="(.*)".*alt="(.*).*\/\>/
LINK_RE  = /\<a.*href="(.*)".*\>/

describe YouTube do
  context "valid ID" do
    before do
      stub_info
      @id = "D80QdsFWdcQ"
      @yt = YouTube.new @id, {:base_url => "http://example.com"}
      @filename = File.join("public", "thumbs", "#{@id}.png")
    end

    describe '#tags' do
      it 'should render a list of valid image tags' do
        @yt.tags.each {|key,t| t.should match IMAGE_RE }
      end

      it 'should link to a thumbnail in PNG format' do
        @yt.tags["basic"].match(IMAGE_RE)[1].should match /#{@id}\.png/
      end

      it 'should link to the overlayed thumbnail with overlay=true' do
        @yt.tags["overlay"].match(IMAGE_RE)[1].should match /#{@id}_overlay\.png/
      end

      it 'should link to an absolute URL' do
        @yt.tags["basic"].match(IMAGE_RE)[1].should match /^http:\/\/.*$/
      end

      it 'should have the title as alt attribute' do
        @yt.tags["basic"].match(IMAGE_RE)[2].should match "Tony Tribe , Red Red Wine"
      end

      it 'should have a link pointing to the youtube video' do
        @yt.tags["basic"].match(LINK_RE)[1].should match /http:\/\/www\.youtube\.com/
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
        File.exists?(File.join("public", "thumbs", "#{@id}_over.png"))
      end
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

    describe "#valid?" do
      it 'should return true for a valid youtube-ID' do
        @yt = YouTube.new("D80QdsFWdcQ")
        @yt.should be_valid
      end
    end
  end #end valid-ID

  describe "invalid-ID" do
    before do
      VideoInfo.stub(:get).and_return nil
      @yt = YouTube.new("INVALID")
    end

    describe "#valid?" do
      it 'should return false for an invalid youtube-ID' do
        @yt = YouTube.new("INVALID")
        @yt.should_not be_valid
      end
    end
  end

  describe "liberal IDs" do
    before do
      @id = "D80QdsFWdcQ"
    end

    it "should allow an ID" do
      @yt = YouTube.new(@id)
      @yt.id.should eq @id
    end

    it 'should allow an URL' do
      @yt = YouTube.new("http://www.youtube.com/watch?v=#{@id}")
      @yt.id.should eq @id
    end

    it 'should allow a shortened URL' do
      @yt = YouTube.new("http://youtu.be/#{@id}")
      @yt.id.should eq @id
    end

    it 'should allow an embed-code' do
      @yt = YouTube.new("<iframe src=\"http://www.youtube.com/embed/D80QdsFWdcQ\" frameborder=\"0\" allowfullscreen=\"allowfullscreen\"></iframe>")
      @yt.id.should eq @id
    end
  end
end
