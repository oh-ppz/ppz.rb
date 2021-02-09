module PPZ::Folder
  class AbstractModel
    attr_reader :index, :name

    def initialize path
      throw '文件（夹）的名字得是字符串啊' unless path.is_a? String
      @path = path
      @basename = File.basename path
    end

    def self.from_path path
      if Dir.exist? path
        FolderModel.new path
      elsif File.exist? path
        AbstractFileModel.from_path path
      else
        throw path + '不存在？'
      end
    end
  end
end