require_relative '../lib/parser/folder/index'

puts '输入文件夹: ' + TARGET_IN
puts '输出文件夹: ' + TARGET_OUT
puts

FileUtils.cp PPZMain::CSS_FILE_PATH, ((Pathname TARGET_OUT) + 'style.css').to_s

model = PPZ::Folder::FolderModel.new TARGET_IN, 0
model.compile TARGET_OUT