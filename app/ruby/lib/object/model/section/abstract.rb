require_relative '../abstract/wrapper-model'

class AbstractSectionModel < AbstractWrapperModel
  def append section
    super
    if section.is_a? AbstractSectionModel
      section.father = self
      section.section_dom_id = "#{section_dom_id}-#{section.level.to_s}.#{section.index.to_s}"
    end
  end

  def get_nav_html
    @children
      .select { |child| child.is_a? AbstractSectionModel }
      .collect { |child| child.get_nav_html }
      .join
  end
end