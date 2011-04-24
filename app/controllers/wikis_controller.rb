class WikisController < ApplicationController

  before_filter :authenticate_user!, :only => [:edit, :update]
  before_filter :find_wiki, :only => [:show, :edit, :history]
  cache_sweeper :wiki_sweeper

  def edit
    draft_version =  WikiVersion.draft_version_for(@wiki, current_user)
    if draft_version.present?
      @wiki.attributes = draft_version.first.wiki_attributes
      @draft = true
    end
  end

  def update
    wiki = Wiki.find(params[:id])
    wiki.attributes_for_versioning.keys.each do |attribute|
      wiki.send("#{attribute}=", params[:wiki][attribute])
    end
    if wiki.changed?
      WikiVersion.create_or_update_next_version_for(wiki, current_user)
      flash[:notice] = t(:saved_for_approval)
      redirect_to :action => :show
    else
      flash[:alert] = t(:unchanged)
      redirect_to :action => :edit
    end
  end

  def history
    @wiki_versions = @wiki.versions.archived.order('updated_at desc')
    render :layout => false
  end

  private

  def find_wiki
    @wiki = Wiki.find params[:id]
  end
end
