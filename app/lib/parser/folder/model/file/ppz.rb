module PPZ::Folder
  class PPZFileModel < AbstractFileModel
    attr_accessor :left, :right

    def _compile dir_out
      parser = PPZ::FileDocParser.new @path
      html_str = %!<link rel="stylesheet" href="#{get_css_path}"/>
<title>#{@name}</title>#{
  parser.get_model.to_html
}<ul class="interpage-nav">#{
  (@left ?
    "<li class=\"prev\"><a href=\"#{@left.name}.html\">#{@left.name}</a></li>"
    : "") +
  (@right ?
    "<li class=\"next\"><a href=\"#{@right.name}.html\">#{@right.name}</a></li>"
    : "")
}</ul>!
      PPZ::Func::write_to_file (dir_out + '/' + @name + '.html'), html_str
    end
  end
end