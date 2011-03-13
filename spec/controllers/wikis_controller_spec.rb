require 'spec_helper'

describe WikisController do
  it "should resolve routes for #edit" do
    should route(:get, '/wikis/1/edit').to(:controller => 'wikis', :action => 'edit', :id => 1)
  end

  describe "#edit" do

    it "should fetch the latest wiki with state as active" do
      wiki = Factory(:active_wiki)
      get :edit, :id => wiki.id
      assigns[:wiki].should == wiki
    end

  end

  describe "#show" do

    it "should fetch the latest wiki with state as active" do
      wiki = Factory(:active_wiki)
      get :edit, :id => wiki.id
      assigns[:wiki].should == wiki
    end

  end

end
