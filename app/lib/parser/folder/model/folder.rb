module PPZ::Folder
  class FolderModel < AbstractModel
    def initialize path, level
      super
      /^((\d+)_)?(.+)/.match @basename
      @index = $2?($2.to_i):(Float::INFINITY)
      @name = $3

      @children = []
      (Dir.children path, encoding: 'utf-8').each do |child_name|
        @children.push AbstractModel.from_path (path + '/' + child_name), level
      end
      @children.sort! do |a, b|
        a.index <=> b.index
      end

      left = right = nil
      @children.each do |child|
        next unless child.is_a? PPZFileModel
        if left
          left.right = child
          child.left = left
        end
        left = child
      end
    end

    def _compile out_dir # compile 是 _compile 的安全版本
      PPZ::Func.write_to_file (out_dir + '/' + @name + '.html'),
        "<link rel=\"stylesheet\" href=\"#{get_css_path}\"/><ul>#{
          @children
          .map do |child|
            if child.file_ext == '.ppz'
              "<li><a href=\"./#{@name}/#{child.name}.html\">#{child.name}</a></li>"
            else
              ''
            end
          end
          .join
        }</ul>"

      children_dir = out_dir + '/' + @name
      Dir.mkdir children_dir
      @children.each { |child| child._compile children_dir }
    end

    def compile out_dir
      unless out_dir.is_a? String
        throw 'out_dir 只能是字符串'
      end
      unless Dir.exist? out_dir
        throw "out_dir #{out_dir} 不存在"
      end
      if ['/', '\\'].include? out_dir[-1]
        _compile out_dir[0...-1]
      else
        _compile out_dir
      end
    end
  end
end