class WikiVersionsController < ApplicationController

  def history
    wiki = Wiki.find(params[:wiki_id])
    @wiki_versions = wiki.versions.active
    @wiki_versions << wiki.versions.archived.order('updated_at desc')
    @wiki_versions.flatten!
    render :layout => false
  end

  def diff
    @current_wiki_version = WikiVersion.find(params[:id])
    @previous_wiki_version = @current_wiki_version.previous_version
    render :layout => false
  end

end