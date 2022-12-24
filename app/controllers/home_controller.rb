class HomeController < ApplicationController

  def index
    @wikis = Wiki.all    
  end

end
