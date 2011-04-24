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

  describe "#update" do

    before :each do
      @locale = YAML.load(File.read("#{Rails.root}/config/locales/ta.yml")).symbolize_keys[:ta]

      @user = Factory(:user)
      @wiki = Factory(:wiki)
      @wiki_version = Factory(:wiki_version, :user => @user,
                              :wiki => @wiki,
                              :paadal_english => 'changed version')
      sign_in @user

    end

    context "approve" do
      it "should make the current wiki version active and display appropriate message" do
        put :update, :wiki_version_id => @wiki_version.id,
                      :wiki_version => @wiki_version.attributes,
                      :commit => @locale['save_button']
        @wiki_version.reload.should be_active
        flash[:notice].should be_present
        response.should redirect_to :action => :index
      end

      it "should make the existing active wiki as archived" do
        active_wiki = WikiVersion.active_version_for(@wiki).first
        put :update, :wiki_version_id => @wiki_version.id,
                      :wiki_version => @wiki_version.attributes,
                      :commit => @locale['save_button']

        active_wiki.reload.should be_archived
        WikiVersion.active_version_for(@wiki).first.should == @wiki_version
      end

      it "should copy all changes from wiki version to actual wiki" do
        put :update, :wiki_version_id => @wiki_version.id,
                            :wiki_version => @wiki_version.attributes,
                            :commit => @locale['save_button']
        @wiki.reload.paadal_english.should == @wiki_version.paadal_english
      end
    end

    context "reject" do
      it "should delete the wiki version" do
        put :update, :wiki_version_id => @wiki_version.id,
                     :wiki_version => @wiki_version.attributes,
                     :commit => @locale['reject_button']
        flash[:notice].should be_present
        @wiki.reload.versions.should have(1).things
      end
    end

    context "user stats" do
      it "should increment user accept count on approval" do
        put :update, :wiki_version_id => @wiki_version.id,
                            :wiki_version => @wiki_version.attributes,
                            :commit => @locale['save_button']
        @wiki_version.reload.user.accepted_count.should == 1
        @wiki_version.user.rejected_count.should == 0
      end

      it "should increment user accept count on approval" do
        put :update, :wiki_version_id => @wiki_version.id,
                            :wiki_version => @wiki_version.attributes,
                            :commit => @locale['reject_button']
        @user.reload.rejected_count.should == 1
        @user.accepted_count.should == 0
      end
    end

  end

end