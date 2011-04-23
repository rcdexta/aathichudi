require 'spec_helper'

describe AdminController do

  it "should resolve routes" do
    should route(:get, '/admin/dashboard').to(:controller => 'admin', :action => 'index')
    should route(:get, '/admin/review/2').to(:controller => 'admin', :action => 'edit', :wiki_version_id => 2)
  end

  describe "#index" do
    before :each do
      @user = Factory(:user)
      @wiki = Factory(:wiki)
      sign_in @user
    end

    it "should retrieve all draft wikis in chronological order" do
      first_draft = Factory(:wiki_version, :user => @user, :wiki => @wiki)
      Timecop.freeze(Time.now + 1.day)
      second_draft = Factory(:wiki_version, :user => @user, :wiki => @wiki)
      Timecop.return
      get :index
      assigns[:draft_wikis].should == [first_draft, second_draft]
    end

  end

  describe "#edit" do

    before :each do
      @user = Factory(:user)
      @wiki = Factory(:wiki)
      sign_in @user
    end

    it "should get the wiki revision and the active wiki" do
      wiki_version = Factory(:wiki_version, :user => @user, :wiki => @wiki)
      get :edit, :wiki_version_id => wiki_version.id

      assigns[:wiki_version] = @wiki_version
    end

    it "should return an error message for invalid wiki version id" do
      wiki_version = Factory(:wiki_version, :user => @user, :wiki => @wiki, :state => 'active')
      get :edit, :wiki_version_id => wiki_version.id

      assigns[:wiki_version].should be_blank
      flash.now[:error].should be_present
    end

    it "should return an hash containing attributes that have changed" do
      wiki_version = Factory(:wiki_version, :user => @user, :wiki => @wiki,
                             :paadal_english => 'changed version', :tamil_long_desc => 'new long tamil version')

      get :edit, :wiki_version_id => wiki_version.id

      assigns[:changed_attributes].should == [:paadal_english, :tamil_long_desc]
    end
  end

end