require 'RMagick'
require 'video_info'
require 'net/http'

class YouTube
  def initialize id
    @id = id

    @title = nil
  end

  def title
    @title || parse
  end

  def img_tag overlay = false
    %Q{<img src="#{thumb(overlay)}" alt=""/>}
  end

  private
  def thumb overlay
    parse
    thumbname({:overlay => overlay, :omit_public => true})
  end

  def parse
    meta = VideoInfo.get("http://www.youtube.com/watch?v=#{@id}")

    @title = meta.title

    get_thumbs meta
  end

  def get_thumbs meta
    img = Net::HTTP.get(URI(meta.thumbnail_large))

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
    parts.unshift("public") unless opts[:omit_public]
    File.join(parts)
  end
end
