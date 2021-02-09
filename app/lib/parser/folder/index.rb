# 解析一个文件夹里的 .ppz 文件

module PPZ::Folder
  class FolderParser
    def initialize
      @context = Context.new
    end
  end

  require_relative './model/abstract'
  require_relative './model/folder'
  require_relative './model/file/abstract'
  require_relative './model/file/other'
  require_relative './model/file/ppz'
end
