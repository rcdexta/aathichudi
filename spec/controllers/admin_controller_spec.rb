require 'spec_helper'

describe AdminController do

  it "should resolve routes for #edit" do
    should route(:get, '/admin/dashboard').to(:controller => 'admin', :action => 'index')
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


end