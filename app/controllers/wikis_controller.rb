class WikisController < ApplicationController

  before_filter :find_latest_active_wiki, :only => [:show, :edit]
  cache_sweeper :wiki_sweeper

  def update
    wiki = Wiki.find(params[:id])
    wiki.update_attributes(params[:wiki])
    flash[:notice] = t(:saved)
    redirect_to :action => :show
  end

  private

  def find_latest_active_wiki
    wiki = Wiki.find params[:id]
    @wiki = wiki.latest_active
  end
end
