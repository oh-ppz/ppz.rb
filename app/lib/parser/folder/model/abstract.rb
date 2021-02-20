module PPZ::Folder
  class AbstractModel
    attr_reader :index, :name, :level
    attr_accessor :prev_model, :next_model, :father_model

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

    def relative_link relative_level
      # relative_level 是“当前 model 比目标 level 高几级”
      (if relative_level > 0
        '../' * relative_level
      elsif relative_level < 0
        result = ''
        father = @father_model
        (- relative_level).times do
          result = father.name + '/' + result
          father = father.father_model
        end
        result
      else
        ''
      end) + @name + '.html'
    end

    private
      def get_nav_html
        # prev_model nav_html
        prev_model_html = ''
        if @prev_model
          prev_link = @prev_model.relative_link @level - @prev_model.level
          prev_model_html = "<li class=\"prev\"><a href=\"#{prev_link}\">#{@prev_model.name}</a></li>"
        end
        next_model_html = ''
        if @next_model
          next_link = @next_model.relative_link @level - @next_model.level
          next_model_html = "<li class=\"next\"><a href=\"#{next_link}\">#{@next_model.name}</a></li>"
        end

        %~<ul class="interpage-nav">#{prev_model_html}#{next_model_html}</ul>~
      end
  end
end