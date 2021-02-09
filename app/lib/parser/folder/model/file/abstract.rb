module PPZ::Folder
class AbstractFileModel < AbstractModel
  def self.from_path path
    if (File.extname path) == '.ppz'
      PPZFileModel.new path
    else
      OtherFileModel.new path
    end
  end

  def initialize path
    super
    unless /^((\d+)_)?([^\.]+)(\.([^\.]+))?$/.match @basename
      throw '文件的命名方式不太理解哦:' + path
    end
    @index = $2?($2.to_i):(Float::INFINITY)
    @name = $3
    @suffix = $5 || ''
  end
end
end