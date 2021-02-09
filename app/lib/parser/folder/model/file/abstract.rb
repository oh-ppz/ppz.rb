module PPZ::Folder
class AbstractFileModel < AbstractModel
  def self.from_path path, level
    if (File.extname path) == '.ppz'
      PPZFileModel.new path, level
    else
      OtherFileModel.new path, level
    end
  end

  attr_reader :file_ext

  def initialize path, level
    super
    unless /^((\d+)_)?([^\.]+)(\.[^\.]+)?$/.match @basename
      throw '文件的命名方式不太理解哦:' + path
    end
    @index = $2?($2.to_i):(Float::INFINITY)
    @name = $3
    @file_ext = $4 || ''
  end
end
end