module PPZ::Folder
  class FolderModel < AbstractModel
    attr_reader :children

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

      # 设置上级 和 左右
      left = right = nil
      @children.each do |child|
        child.father_model = self # 上级

        next unless child.is_a? PPZFileModel
        if left
          left.right = child
          child.left = left
        end
        left = child
      end
    end

    def _compile out_dir # compile 是 _compile 的安全版本
      PPZ::Func.write_to_file (out_dir + '/' + @name + '.html'), to_html

      children_dir = out_dir + '/' + @name
      Dir.mkdir children_dir
      @children.each { |child| child._compile children_dir }
    end

    def compile out_dir
      set_prev_and_next_page

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
    
    def get_content_table_html root
      %~<ul>#{
        @children
        .select do |child|
          (child.class == FolderModel) || (child.file_ext == '.ppz')
        end
        .map do |child|
          result = "<li><a href=\"./#{root.relative_link child}\">#{child.name}</a></li>"
          if child.is_a? FolderModel
            result += child.get_content_table_html root
          end
          result
        end
        .join
      }</ul>~
    end

    # 设置页面的“上一篇、下一篇”
    private
      def set_prev_and_next_page
        list = []
        linearize_children self, list
        list.inject do |pre, nex|
          pre.next_model = nex
          nex.prev_model = pre
          nex
        end
      end
      
      def linearize_children child, list
        if child.is_a? PPZFileModel
          list.push child
        elsif child.is_a? FolderModel
          list.push child
          child.children.each do |cc|
            linearize_children cc, list
          end
        end
      end

      def get_content_html
        "<article>#{get_content_table_html self}</article>"
      end
  end
end