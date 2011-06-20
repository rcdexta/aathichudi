class TextileController < ApplicationController

  def preview
   text = params[:text]
   @html= RedCloth.new(text).to_html
   render :json => @html
  end

end
