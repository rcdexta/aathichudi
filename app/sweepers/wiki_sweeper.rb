class WikiSweeper < ActionController::Caching::Sweeper
  observe Wiki

  def after_update(wiki)
    expire_cache_for(wiki) if wiki.english_short_desc_changed? or wiki.tamil_short_desc_changed?
  end

  private
  def expire_cache_for(wiki)
    # Expire the index page now that we added a new product
    expire_page(:controller => 'home', :action => 'index')
  end
end