class PPZ::Folder::FileModel < PPZ::Folder::AbstractModel
  def compile # 源文件 -> 编译好的文件
    is_ppz = (File.extname @path) == 'ppz'
  end
end