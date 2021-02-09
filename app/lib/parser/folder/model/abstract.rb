module PPZ::Folder
  class AbstractModel
    attr_reader :index, :name

    def initialize path, level
      throw '文件（夹）的名字得是字符串啊' unless path.is_a? String
      @path = path
      @basename = File.basename path
      @level = level
    end

    def self.from_path path, level
      level += 1
      if Dir.exist? path
        FolderModel.new path, level
      elsif File.exist? path
        AbstractFileModel.from_path path, level
      else
        throw path + '不存在？'
      end
    end

    def get_css_path
      ('../' * @level) + 'style.css'
    end
  end
end