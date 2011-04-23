class AdminController < ApplicationController

  before_filter :authenticate_user!

  def index
    @draft_wikis = WikiVersion.draft.order('created_at')
  end

  def edit
    @wiki_version = WikiVersion.first(:conditions => {:id => params[:wiki_version_id], :state => 'draft'})

    unless @wiki_version.present?
      flash.now[:error] = t(:wiki_version_not_found)
    end
  end

end