require 'pathname'

class PPZ::Folder::FolderModel < PPZ::Folder::AbstractModel
  def initialize path
    super
    @children = []
    (Dir.children path).each do |child_path|
      @children.push PPZ::Folder::AbstractModel.from_path (path + '/' + child_path)
    end
  end
end