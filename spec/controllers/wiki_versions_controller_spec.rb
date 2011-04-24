require 'spec_helper'

describe WikiVersionsController do

  it "should resolve routes" do
    should route(:get, '/wiki_versions/1/history').to(:controller => 'wiki_versions', :action => 'history', :wiki_id => 1)
    should route(:get, '/wiki_versions/10/diff').to(:controller => 'wiki_versions', :action => 'diff', :id => 10)
  end

  before :each do
    @user = Factory(:user)
    sign_in @user
    @wiki = Factory(:wiki)
  end

  describe "#history" do
    it "should get the wiki active and archived versions for a wiki in reverse chronological order" do
      Factory(:wiki_version, :user => @user, :wiki => @wiki, :state => 'archived')
      get :history, :wiki_id => @wiki.id
      assigns[:wiki_versions].should == [WikiVersion.active.first, WikiVersion.archived.first]
    end
  end

  describe "#diff" do
    it "should fetch the current and previous version" do
      active_version = @wiki.versions.first
      archived_version = Factory(:wiki_version, :user => @user, :wiki => @wiki, :state => 'archived', :version => 2)
      get :diff, :id => archived_version.id
      assigns[:current_wiki_version].should == archived_version
      assigns[:previous_wiki_version].should == active_version
    end
  end


end