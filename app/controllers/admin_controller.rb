class AdminController < ApplicationController

  before_filter :authenticate_user!

  def index
    @draft_wikis = WikiVersion.draft.order('created_at')
  end

end