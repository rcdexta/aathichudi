class WikiVersionsController < ApplicationController

  def history
    wiki = Wiki.includes(:versions).find(params[:wiki_id])
    versions = wiki.versions.active
    versions << wiki.versions.archived.order('updated_at desc')
    @wiki_versions = versions.to_a.flatten    
    render :layout => false
  end

  def diff
    @current_wiki_version = WikiVersion.find(params[:id])
    @previous_wiki_version = @current_wiki_version.previous_version
    render :layout => false
  end

end