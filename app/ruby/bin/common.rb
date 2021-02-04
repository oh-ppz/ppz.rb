require 'pathname'

module PPZMain
  CURRENT_PATH = File.dirname __FILE__
  CSS_FILE_PATH = (Pathname CURRENT_PATH) + '../asset/style/ppz.css'

  class Util
    class << self
      def get_file_in_and_out
        file_in, file_out = ARGV
        unless file_in && file_out
          abort '参数不对啊，需要至少俩参数（输入文件路径、输出文件路径）'
        end

        current_path = Pathname Dir.pwd
        file_in = (current_path + file_in).to_s
        file_out = (current_path + file_out).to_s

        unless File.exist? file_in
          abort '没有 ' + file_in + " 这个文件\n【参数不正确：ppz 源文件不存在】"
        end

        file_out_dir = File.dirname file_out
        unless Dir.exist? file_out_dir 
          abort '输出文件的目录不存在'
        end

        if File.exist? file_out
          abort '输出文件已存在'
        end

        [file_in, file_out]
      end
    end
  end
end