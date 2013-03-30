require 'RMagick'
require 'video_info'
require 'net/http'

class YouTube
  def initialize identifier, opts = {}
    @id = find_id(identifier)

    @meta = nil
    @base_url = opts[:base_url] || ''
  end

  def title
    parse
    @meta.title
  end

  def href
    "http://www.youtube.com/watch?v=#{@id}"
  end

  def tags
    parse
    Hash[get_thumbs.map {|key,value| [key, %Q{<a href="#{href}"><img src="#{value}" alt="#{title}"/></a>}] }]
  end

  def valid?
    parse
    not @meta.nil?
  end

  def id
    @id
  end

  private
  def find_id identifier
    id_part  = "[a-zA-Z0-9]{4,16}"
    if matches = identifier.match("^#{id_part}$")
      matches[0]
    elsif matches = identifier.match("^http(?:s)?:\/\/(?:www\.)?youtube\.com\/watch\\?v=(#{id_part})")
      matches[1]
    elsif matches = identifier.match("^http(?:s)?:\/\/youtu.be\/(#{id_part})")
      matches[1]
    elsif matches = identifier.match("\<iframe(?:.*)src=\"http://www.youtube.com/embed/(#{id_part}).+")
      matches[1]
    else
      nil
    end
  end

  def parse
    @meta ||= VideoInfo.get(href)
  end

  def get_thumbs
    img = Net::HTTP.get(URI(@meta.thumbnail_large))

    tmpfile = Tempfile.new(["tubemp", ".jpg"])
    begin
      tmpfile.binmode
      tmpfile.write(img)
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

    {
     "basic" => thumbname({:overlay => false, :absolute => true}),
     "overlay" => thumbname({:overlay => true, :absolute  => true})
    }
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
