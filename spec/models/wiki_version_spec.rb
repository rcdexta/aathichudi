require 'spec_helper'

describe WikiVersion do

  context "associations" do
    it "should belong to user and wiki" do
      should belong_to :user
      should belong_to :wiki
    end
  end

  context "state machine" do
    it "should initially be in draft state" do
      wiki_version = Factory(:wiki_version)
      wiki_version.should be_draft
    end

    it "should change state if archived" do
      wiki_version = Factory(:wiki_version)
      wiki_version.activate!
      wiki_version.archive!
      wiki_version.should be_archived
    end

    it "should change state if activated" do
      wiki_version = Factory(:wiki_version)
      wiki_version.activate!
      wiki_version.should be_active
    end

    it "should set next version number if activated" do
      wiki = Factory(:wiki)
      wiki_version = Factory(:wiki_version, :wiki => wiki)
      wiki_version.activate!
      wiki_version.version.should == 2
    end
  end

  context "draft_version scope" do
    it "should return the draft version for a wiki and user" do
      wiki = Factory(:wiki)
      user = Factory(:user)
      active_version = Factory(:wiki_version, :state => 'active', :user => user, :wiki => wiki)
      draft_version = Factory(:wiki_version, :user => user, :wiki => wiki)

      WikiVersion.draft_version_for(wiki, user).first.should == draft_version
    end
  end

  context "active_version scope" do
    it "should return the active version for a wiki" do
      wiki = Factory(:wiki)
      user = Factory(:user)
      draft_version = Factory(:wiki_version, :user => user, :wiki => wiki)

      WikiVersion.active_version_for(wiki).first.should == WikiVersion.first
    end
  end

  context "archived_version scope" do
    it "should return the active version for a wiki" do
      wiki = Factory(:wiki)
      user = Factory(:user)
      archived_version = Factory(:wiki_version, :user => user, :wiki => wiki, :state => 'archived')

      WikiVersion.archived.first.should == archived_version
    end
  end

  describe "#create_next_version_for" do
    it "should copy all attributes and create the next version for wiki" do
      wiki = Factory(:wiki)
      user = Factory(:user)

      WikiVersion.create_or_update_next_version_for(wiki, user)

      wiki.reload
      wiki.versions.should have(2).things

      wiki.versions.last.user.should == user
    end

    it "should update attributes if draft version already exists" do
      wiki = Factory(:wiki)
      user = Factory(:user)
      Factory(:wiki_version, :wiki => wiki, :user => user)

      wiki.paadal = "new version paadal"
      WikiVersion.create_or_update_next_version_for(wiki, user)

      wiki.reload
      wiki.versions.should have(2).things

      wiki.versions.last.paadal.should == "new version paadal"
    end
  end

  describe "#copy_attributes_to_wiki!" do
    it "should copy attribute values to wiki" do
      wiki = Factory(:wiki)
      user = Factory(:user)
      wiki_version = Factory(:wiki_version, :wiki => wiki, :user => user, :paadal => 'he he he')
      wiki_version.copy_attributes_to_wiki!
      wiki.reload.paadal.should == 'he he he'
    end
  end

  describe "#previous_version" do
    it "should return the previous version relative to current" do
      wiki = Factory(:wiki)
      user = Factory(:user)
      wiki_version = Factory(:wiki_version, :wiki => wiki, :user => user, :version => 2)
      wiki_version.previous_version.should == wiki.versions.active.first
    end
  end

  describe "#set_next_version" do
    it "should set the version number as plus one relative to previous version" do
      wiki = Factory(:wiki)
      user = Factory(:user)
      wiki_version = Factory(:wiki_version, :wiki => wiki, :user => user, :state => 'draft')
      wiki_version.set_next_version!
      wiki_version.version.should == 2
    end
  end

end