require 'spec_helper'

describe WikisController do

  it "should resolve routes for #edit" do
    should route(:get, '/wikis/1/edit').to(:controller => 'wikis', :action => 'edit', :id => 1)
  end

  before :each do
    user = Factory(:user)
    sign_in user
  end

  describe "#edit" do
    it "should fetch the latest wiki" do
      wiki = Factory(:wiki)
      get :edit, :id => wiki.id
      assigns[:wiki].should == wiki
    end
  end

  describe "#show" do
    it "should fetch the latest wiki" do
      wiki = Factory(:wiki)
      get :show, :id => wiki.id
      assigns[:wiki].should == wiki
    end
  end

  describe "#update" do

    it "should not populate flash message if no attribute has been changed" do
      wiki = Factory(:wiki)
      get :update, :id => wiki.id, :wiki => wiki
      flash[:notice].should be_blank
    end
#
#    it "should create a new revision if no draft present" do
#      wiki = Factory(:wiki)
#      get :update, :id => wiki.id, :wiki => wiki
#    end

  end

end
