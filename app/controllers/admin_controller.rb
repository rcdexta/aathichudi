class AdminController < ApplicationController

  before_filter :authenticate_user!

  def index
    @draft_wikis = WikiVersion.draft.order('created_at')
  end

  def edit
    @wiki_version = WikiVersion.first(:conditions => {:id => params[:wiki_version_id], :state => 'draft'})

    unless @wiki_version.present?
      flash.now[:error] = t(:wiki_version_not_found)
    else
      find_changed_attributes
    end
  end

  private

  def find_changed_attributes
    @changed_attributes = []
    @wiki_version.wiki_attributes.keys.each do |attribute|
      @changed_attributes << attribute.to_sym if @wiki_version.send(attribute.to_s) != @wiki_version.wiki.send(attribute.to_s)
    end
  end

end