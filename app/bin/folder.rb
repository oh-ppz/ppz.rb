require_relative '../lib/parser/folder/index'

puts '输入文件夹: ' + TARGET_IN
puts '输出文件夹: ' + TARGET_OUT
puts

model = PPZ::Folder::AbstractModel.from_path TARGET_IN
model.compile TARGET_OUT