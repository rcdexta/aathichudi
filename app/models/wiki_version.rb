class WikiVersion < ActiveRecord::Base

  belongs_to :user
  belongs_to :wiki

  scope :draft, where(:state => 'draft')
  scope :archived, where(:state => 'archived')
  scope :active, where(:state => 'active')

  scope :draft_version_for, lambda {|wiki, user| where("state = 'draft' and wiki_id = ? and user_id = ?", wiki.id, user.id)}
  scope :active_version_for, lambda {|wiki| where("state = 'active' and wiki_id = ?", wiki.id)}

  state_machine :state, :initial => :draft do
    event :archive do
      transition :active => :archived
    end

    event :activate do
      transition :draft => :active
    end
  end

  def self.create_or_update_next_version_for(wiki, user)
     existing_version = WikiVersion.first(:conditions => {:wiki_id => wiki.id, :user_id => user.id, :state => 'draft'})
     if existing_version.present?
       existing_version.update_attributes(wiki.attributes_for_versioning)
     else
      recent_version = self.where(:wiki_id => wiki.id).order('version desc').limit(1).first
      self.create(wiki.attributes_for_versioning.merge(:wiki_id => wiki.id,
                                                       :user_id => user.id,
                                                       :version => recent_version.version + 1))
    end
  end

  def wiki_attributes
    {"paadal" => paadal,
     "paadal_english" => paadal_english,
     "tamil_long_desc" => tamil_long_desc,
     "english_short_desc" => english_short_desc,
     "tamil_short_desc" => tamil_short_desc}
  end

  def copy_attributes_to_wiki!
    self.wiki.update_attributes(wiki_attributes)
  end

  def previous_version
    WikiVersion.first(:conditions => ['wiki_id = ? and version = ?', self.wiki.id, self.version - 1])
  end

end