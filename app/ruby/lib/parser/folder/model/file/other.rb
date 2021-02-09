module PPZ::Folder
  class OtherFileModel < AbstractFileModel
    def _compile dir_out
      FileUtils.cp @path, (dir_out + '/' + @basename)
    end
  end
end