require_relative '../src/object/parser/doc/file'
require_relative '../src/func/index'
require 'pathname'

dirname = File.dirname __FILE__
path = Pathname(dirname) + '../readme.ppz'
path = path.to_s
target = FileDocParser.new path

model = target.get_model
html = model.to_html
Func::write_to_file 'test.html', html