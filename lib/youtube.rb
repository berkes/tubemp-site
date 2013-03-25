require 'RMagick'
require 'video_info'
require 'net/http'

class YouTube
  def initialize id, opts = {}
    @id = id
    @meta = nil

    @base_url = opts[:base_url] || ''
  end

  def title
    parse
    @meta.title
  end

  def tags
    parse
    get_thumbs.map {|t| %Q{<img src="#{t}" alt=""/>} }
  end

  private
  def parse
    @meta ||= VideoInfo.get("http://www.youtube.com/watch?v=#{@id}")
  end

  def get_thumbs
    img = Net::HTTP.get(URI(@meta.thumbnail_large))

    tmpfile = Tempfile.new(["tubemp", ".jpg"])
    begin
      tmpfile.binmode
      tmpfile.write img
      tmpfile.close

      images = Magick::ImageList.new(tmpfile.path, File.join("assets", "overlay.png"))

      # Write a png as thumbnail
      images[0].write(thumbname)
      # And glue the overlay to it, save that as an alternative PNG
      images[0].composite(images[1], Magick::CenterGravity, Magick::OverCompositeOp).write(thumbname({:overlay => true}))
    ensure
      images = nil
      tmpfile.unlink
    end

    [ thumbname({:overlay => false, :absolute => true}),
      thumbname({:overlay => true, :absolute  => true}) ]
  end

  # Creates a path to the thumbnail
  # opts: 
  #  * `:overlay => true`, appends _overlay to the imagename
  #  * `:omit_public => true`, does not include the /public/ part of the path,
  #                            for static-file serving
  def thumbname opts = {}
    FileUtils.mkdir_p(File.join("public", "thumbs"))

    filename = opts[:overlay] ? "#{@id}_overlay": @id
    parts = ["thumbs", "#{filename}.png"]

    if opts[:absolute]
      parts.unshift(@base_url)
    else
      parts.unshift("public")
    end
    File.join(parts)
  end
end
