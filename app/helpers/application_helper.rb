module ApplicationHelper

  def generate_diff(current, original)
    Diffy::Diff.new(current, original).to_s(:html)
  end

  def admin_signed_in?
    current_user and current_user.email == AppConfig.admin
  end

end
