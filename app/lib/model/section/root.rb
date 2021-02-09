class PPZ::RootSectionModel < PPZ::AbstractSectionModel
  def level
    0
  end
  def section_dom_id
    'section'
  end

  def get_nav_html
    return "<aside><ul>#{super}</ul></aside>"
  end

  def to_html
    "#{get_nav_html}<article>#{super}</article>"
  end
end