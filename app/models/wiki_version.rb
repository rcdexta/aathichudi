class WikiVersion < ActiveRecord::Base

  belongs_to :user
  belongs_to :wiki

  scope :draft, where(:state => 'draft')
  scope :active, where(:state => 'active')
  scope :draft_version, lambda {|wiki, user| where("state = ? and wiki_id = ? and user_id = ?", 'draft', wiki.id, user.id)}

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
    {"english_short_desc" => english_short_desc,  "paadal" => paadal, "paadal_english" => paadal_english,
     "tamil_long_desc" => tamil_long_desc, "tamil_short_desc" => tamil_short_desc}
  end

end