class PPZ::Folder::AbstractModel
  attr_reader :index, :name

  def initialize path
    puts path
    throw '文件（夹）的名字得是字符串啊' unless path.is_a? String
    @path = path
    
    /^((\d+)_)?(.+)/.match File.basename path
    @index = $2?($2.to_i):(Float::INFINITY)
    @name = $3
  end

  def self.from_path path
    if Dir.exist? path
      PPZ::Folder::FolderModel.new path
    elsif File.exist? path
      PPZ::Folder::FileModel.new path
    else
      throw path + '不存在？'
    end
  end
end