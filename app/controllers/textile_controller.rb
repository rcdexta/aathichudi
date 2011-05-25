class TextileController < ApplicationController

  def preview
   @html= RedCloth.new(params[:text]).to_html
   render :json => @html
  end

end
