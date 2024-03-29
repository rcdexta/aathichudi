module ApplicationHelper

  def generate_paadal_heading(id, html)
    content_tag(:a, :href => wiki_path(id), :title => (device != 'mobile' ? tooltip_for(id) : nil), :id => id) do
      "#{id} #{html}".html_safe
    end
  end

  def device
    agent = request.user_agent
    return "tablet" if agent =~ /(tablet|ipad)|(android(?!.*mobile))/i
    return "mobile" if agent =~ /Mobile/
    return "desktop"
  end

  def go_back_path(id)
    "#{root_path}##{id}"
  end

  def generate_diff(current, original)
    Diffy::Diff.new(original, current).to_s(:html)
  end

  def admin_signed_in?
    current_user and current_user.email == AppConfig.admin
  end

  def generate_logout_link
    if current_user.rpx_identifier =~ /www\.google\.com/
      'https://mail.google.com/mail/?logout&hl=en'
    elsif current_user.rpx_identifier =~ /twitter\.com/
      'http://twitter.com/?lang=en&logged_out=1'
    elsif current_user.rpx_identifier =~ /yahoo\.com/
      'http://login.yahoo.com/config/login?logout=1&.intl=in'
    elsif current_user.rpx_identifier =~ /live\.com/
      'http://login.live.com/logout.srf'
    end
  end

end
