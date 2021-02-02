require 'test/unit'
require_relative './leaf'
require_relative './root'

root = RootSectionModel.new
leaf1 = LeafSectionModel.new '一级标题'
leaf2 = LeafSectionModel.new '第二个一级标题'
leaf11 = LeafSectionModel.new '二级标题'

root.append leaf1
leaf1.append leaf11
root.append leaf2
