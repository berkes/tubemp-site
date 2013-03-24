class YouTube
  def initialize id
    @id = id
  end

  def img_tag
    %Q{<img src="#{thumb}" alt=""/>}
  end

  private
  def thumb
    parse
    thumbname
  end

  def parse
    File.open(thumbname, 'w') do |f|
       f << "woop"
    end
  end

  def thumbname
    FileUtils.mkdir_p(File.join("public", "thumbs"))
    File.join("public", "thumbs", "#{@id}.png")
  end
end
