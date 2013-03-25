require File.join(File.dirname(__FILE__), "..", "lib", "youtube")

IMAGE_RE = /\<img.*src="(.*)".*alt="(.*).*\/\>/
describe YouTube do
  before do
    @id = "D80QdsFWdcQ"
    @yt = YouTube.new @id
    @filename = File.join("public", "thumbs", "#{@id}.png")
  end

  describe '#img_tag' do
    context "valid ID" do
      it 'should render a valid image tag' do
        @yt.stub(:parse)
        @yt.img_tag.should =~ IMAGE_RE
      end

      it 'should link to a thumbnail in PNG format' do
        @yt.stub(:parse)
        img = @yt.img_tag.match IMAGE_RE
        src = img[1]
        src.should =~ /#{@id}\.png/
      end

      it 'should link to the overlayed thumbnail with overlay=true' do
        @yt.stub(:parse)
        img = @yt.img_tag(true).match IMAGE_RE
        src = img[1]
        src.should =~ /#{@id}_overlay\.png/
      end

      context 'local image does not exist' do
        before do
          File.delete @filename if File.exists? @filename
        end

        it 'should create its thumb in "public/thumbs" dir' do
          @yt.img_tag
          File.exists?(@filename).should be_true
        end

        it 'should get the large thumbnail' do
          @yt.img_tag
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
          @yt.img_tag
          @existing.should_not eq File.stat(@filename)
        end
      end

      it 'should overlay a play-icon' do
        @yt.img_tag
        filename = File.join("public", "thumbs", "#{@id}_over.png")
        File.exists?(filename)
      end
    end # context "valid ID"
  end

  describe "#title" do
    it "should render a title" do
      @yt.stub(:parse) { @title = "TEST" }
      @yt.title.should eq "TEST"
    end
  end

end
