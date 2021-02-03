require_relative '../abstract/wrapper-model'

class AbstractSectionModel < AbstractWrapperModel
  def append section
    super
    if section.is_a? AbstractSectionModel
      section.father = self
    end
  end
end