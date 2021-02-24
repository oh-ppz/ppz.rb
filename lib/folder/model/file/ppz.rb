module PPZ::Folder
  class PPZFileModel < AbstractFileModel
    attr_accessor :left, :right

    def _compile dir_out
      PPZ::Func::write_to_file (dir_out + '/' + @name + '.html'), to_html
    end

    private
      def get_content_html
        (PPZ::FileDocParser.new @path)
          .get_model.to_html
      end
  end
end