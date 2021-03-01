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

    def relative_link target
      relative_level = @level - target.level # relative_level 是“目标 model 比当前 level 高几级”

      (if relative_level > 0
        '../' * relative_level
      elsif relative_level < 0
        result = ''
        father = target.father_model
        (- relative_level).times do
          result = father.name + '/' + result
          father = father.father_model
        end
        result
      else
        ''
      end) + target.name + '.html'
    end

    private
      def to_html
        get_head_html +
        get_ancestor_html +
        get_content_html +
        get_nav_html +
        get_js_html
      end

      def get_head_html
        css_path = ('../' * @level) + 'style.css'
        %~<title>#{@name}</title><link rel="stylesheet" href="#{css_path}">~
      end
      
      def get_ancestor_html
        list = []
        father = self
        loop do
          break unless father.father_model
          father = father.father_model
          list.unshift father
        end
        %~<div class="ancestor-nav"><ul>#{
          (list.collect do |node|
            %`<li><a href="#{relative_link node}">#{node.name}</a></li>`
          end
          .join) + %`<li class="self">#{self.name}</li>`
        }</ul></div>~
      end

      def get_nav_html
        # prev_model nav_html
        prev_model_html = ''
        if @prev_model
          prev_link = relative_link @prev_model
          prev_model_html = "<li class=\"prev\"><a href=\"#{prev_link}\">#{@prev_model.name}</a></li>"
        end
        next_model_html = ''
        if @next_model
          next_link = relative_link @next_model
          next_model_html = "<li class=\"next\"><a href=\"#{next_link}\">#{@next_model.name}</a></li>"
        end

        %~<ul class="interpage-nav">#{prev_model_html}#{next_model_html}</ul>~
      end

      def get_js_html
        js_path = ('../' * @level) + 'index.js'
        %~<script type="module" src="#{js_path}"></script>~
      end
  end
end