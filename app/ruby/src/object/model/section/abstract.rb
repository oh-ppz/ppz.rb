require_relative '../abstract/wrapper-model'

class AbstractSectionModel < AbstractWrapperModel
  def append section
    p section
    unless section.is_a? AbstractSectionModel
      raise 'section 只接受 section 作为内容'
    end

    section.level = @level + 1
    super.append section
  end
end