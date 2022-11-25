module TooltipHelper

  def tooltip_for(wiki_id)
    wiki = @wikis.find { |w| w.id == wiki_id }
    "#{wiki.tamil_short_desc} <br/> #{wiki.english_short_desc}" 
  end

end