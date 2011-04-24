require 'spec_helper'

describe WikisController do

  it "should resolve routes" do
    should route(:get, '/wikis/1/edit').to(:controller => 'wikis', :action => 'edit', :id => 1)
    should route(:get, '/wikis/1/history').to(:controller => 'wikis', :action => 'history', :id => 1)
  end

  before :each do
    @user = Factory(:user)
    sign_in @user
    @wiki = Factory(:wiki)
  end

  describe "#edit" do
    it "should fetch the latest wiki" do
      get :edit, :id => @wiki.id
      assigns[:wiki].should == @wiki
    end
  end

  describe "#show" do
    it "should fetch the latest wiki" do
      get :show, :id => @wiki.id
      assigns[:wiki].should == @wiki
    end
  end

  describe "#update" do

    it "should display alert message if no changes are present" do
      put :update, :id => @wiki.id, :wiki => @wiki
      flash[:notice].should be_blank
      flash[:alert].should be_present
      response.should redirect_to :action => :edit
    end

    it "should create a new revision" do
      @wiki.paadal = "new paadal"

      put :update, :id => @wiki.id, :wiki => @wiki

      wiki_version = WikiVersion.last
      wiki_version.should_not be_blank

      wiki_version.version.should == 2
      wiki_version.paadal.should == "new paadal"
      wiki_version.user.should == @user
      wiki_version.should be_draft
    end

  end

  describe "#history" do
    it "should get the wiki active and archived versions for a wiki in reverse chronological order" do
      Factory(:wiki_version, :user => @user, :wiki => @wiki, :state => 'archived')
      get :history, :id => @wiki.id
      assigns[:wiki_versions].should == WikiVersion.archived.to_a
    end
  end

end
