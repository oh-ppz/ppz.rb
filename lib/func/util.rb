class PPZ::Func
  class << self
    def write_to_file filepath, data
      if File.exist? filepath
        throw '文件已存在'
      end
      file = File.new filepath, mode: 'w:UTF-8'
      file.print data
      file.close
    end

    # 检查某类有没有某常量
    def has_const? klass, const_name
      klass.constants.include? const_name
    end
    # 检查某实例的类有没有某常量
    def class_has_const? instance, const_name
      has_const? instance.class, const_name
    end

    def format_path path
      if ['/', '\\'].include? path[-1]
        path[0...-1]
      else
        path
      end
    end
  end
end