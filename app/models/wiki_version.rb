class WikiVersion < ActiveRecord::Base

  belongs_to :user
  belongs_to :wiki

  scope :draft, where(:state => 'draft')
  scope :archived, where(:state => 'archived')
  scope :active, where(:state => 'active')

  scope :draft_version_for, lambda {|wiki, user| where("state = 'draft' and wiki_id = ? and user_id = ?", wiki.id, user.id)}
  scope :active_version_for, lambda {|wiki| where("state = 'active' and wiki_id = ?", wiki.id)}

  after_create :notify_admin

  state_machine :state, :initial => :draft do
    event :archive do
      transition :active => :archived
    end

    event :activate do
      transition :draft => :active
    end

    before_transition :draft => :active do |wiki_version|
      wiki_version.set_next_version!
    end
  end

  def self.create_or_update_next_version_for(wiki, user)
     existing_version = WikiVersion.first(:conditions => {:wiki_id => wiki.id, :user_id => user.id, :state => 'draft'})
     if existing_version.present?
       existing_version.update_attributes(wiki.attributes_for_versioning)
     else
      self.create(wiki.attributes_for_versioning.merge(:wiki_id => wiki.id, :user_id => user.id))
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

  def set_next_version!
    recent_version = WikiVersion.where(["wiki_id = ? and state != 'draft'", wiki.id]).order('version desc').limit(1).first
    self.update_attribute(:version, recent_version.version + 1)
  end

  def notify_admin
    Thread.new do
      AdminNotifier.notify_wiki_submission(self).deliver
    end
  end

  def tamil_long_desc_html
   RedCloth.new(tamil_long_desc).to_html
  end
end
