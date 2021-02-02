require_relative '../abstract/wrapper-model'

class AbstractSectionModel < AbstractWrapperModel
  def append section
    if section.is_a? AbstractSectionModel
      section.father = self
    end
    super
  end
end