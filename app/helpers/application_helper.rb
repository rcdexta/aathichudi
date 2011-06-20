require 'differ'

module ApplicationHelper

  def generate_diff(current, original)
    # Differ.diff_by_word(current, original).format_as(:html)
    Diffy::Diff.new(current, original).to_s(:html)
  end

  def admin_signed_in?
    current_user and current_user.email == AppConfig.admin
  end

end
