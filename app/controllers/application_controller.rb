class ApplicationController < ActionController::Base
  protect_from_forgery
  include TooltipHelper

  def after_sign_in_path_for(resource)
    p "-"*50
    p resource
    super
  end
end
