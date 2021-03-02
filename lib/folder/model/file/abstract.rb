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
    temp_bn = @basename
    if /^(\d+)_/.match temp_bn
      @index = $1.to_i
      temp_bn = temp_bn[($1.size + 1)..-1]
    else
      @index = Float::INFINITY
    end

    /(.*)(\.[^\.]+)$/.match temp_bn
    @name = $1 || temp_bn
    @file_ext = $2 || ''
  end
end
end