class AdminController < ApplicationController

  before_filter :authenticate_user!
  before_filter :check_if_admin!

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

  def update
    wiki_version = WikiVersion.find(params[:wiki_version_id])
    if params[:commit] == t(:save_button)
      if wiki_version.update_attributes(params[:wiki_version])
        archive_and_activate(wiki_version)
        wiki_version.copy_attributes_to_wiki!
        wiki_version.user.increment!(:accepted_count)
        Thread.new do
          UserNotifier.wiki_approved_mail(wiki_version).deliver
        end
        flash[:notice] = t(:approval_saved)
      end
    else
      wiki_version.user.increment!(:rejected_count)
      wiki_version.destroy
      flash[:notice] = t(:rejection_saved)
    end
    redirect_to :action => :index
  end

  private

  def find_changed_attributes
    @changed_attributes = []
    @wiki_version.wiki_attributes.keys.each do |attribute|
      @changed_attributes << attribute.to_sym if @wiki_version.send(attribute.to_s) != @wiki_version.wiki.send(attribute.to_s)
    end
  end

  def archive_and_activate(wiki_version)
    current_active_version = WikiVersion.active_version_for(wiki_version.wiki).first
    current_active_version.archive
    wiki_version.activate
  end

  def check_if_admin!
    redirect_to root_path unless current_user.email == AppConfig.admin
  end

end