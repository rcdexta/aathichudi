require 'differ'

module ApplicationHelper

  def generate_diff(current, original)
    Differ.diff_by_word(current, original).format_as(:html)
  end

end
