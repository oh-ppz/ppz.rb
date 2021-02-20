module PPZ::Folder
  class PPZFileModel < AbstractFileModel
    attr_accessor :left, :right

    def _compile dir_out
      parser = PPZ::FileDocParser.new @path
      html_str = %!<link rel="stylesheet" href="#{get_css_path}"/><title>#{
        @name
      }</title>#{get_ancestor_html}#{parser.get_model.to_html}#{get_nav_html}!
      PPZ::Func::write_to_file (dir_out + '/' + @name + '.html'), html_str
    end
  end
end