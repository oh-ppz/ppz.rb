class Func
  class << self
    def write_to_file filepath, data
      if File.exist? filepath
        throw '文件已存在'
      end
      file = File.new filepath, 'w'
      file.print data
      file.close
    end
  end
end