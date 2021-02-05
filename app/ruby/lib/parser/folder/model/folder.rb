require 'pathname'

class PPZ::Folder::FolderModel < PPZ::Folder::AbstractModel
  def initialize path
    super
    @children = []
    (Dir.children path).each do |child_name|
      @children.push PPZ::Folder::AbstractModel.from_path (path + '/' + child_name)
    end
    @children.sort! do |a, b|
      a.index <=> b.index
    end
  end

  def to_html target_out
    
  end
end