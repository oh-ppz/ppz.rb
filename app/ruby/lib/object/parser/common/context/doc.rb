require_relative '../../../model/section/abstract'
require_relative './abstract'

class DocContext < AbstractContext
  def level
    @stack.reverse_each do |item|
      return item.level if item.is_a? AbstractSectionModel
    end
    throw '不应该到这里'
  end

  def pop_to_section
    pop_to AbstractSectionModel
  end
end