require 'spec_helper'

describe CommentsController do

  it "should resolve routes" do
    should route(:get, '/comments/new').to(:controller => 'comments', :action => 'new')
    should route(:post, '/comments').to(:controller => 'comments', :action => 'create')
  end

  describe "#new" do
    it "should render the new comments form" do
      get :new
      response.should render_template 'new'
    end
  end

  describe "#create" do
    it "should call comment notifier" do
      comment_params = {:name => 'abc', :email => 'd@e.fgh', :comment => 'ijklmno'}
      CommentNotifier.expects(:send_mail)
      post :create, :comment => comment_params
      response.body.should be_blank
    end
  end

end
