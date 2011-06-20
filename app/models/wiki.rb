class Wiki < ActiveRecord::Base

  after_create :create_first_version

  has_many :versions, :class_name => "WikiVersion"

  def create_first_version
    admin_user = User.find_by_email(AppConfig.admin)
    self.versions << WikiVersion.new(self.attributes_for_versioning.merge(:version => 1, :state => 'active', :user => admin_user))
  end

  def attributes_for_versioning
    {"english_short_desc" => english_short_desc,  "paadal" => paadal, "paadal_english" => paadal_english,
     "tamil_long_desc" => tamil_long_desc, "tamil_short_desc" => tamil_short_desc}
  end

  def active_version
    self.versions.active.first
  end

  def self.essential_attribute_names
    [:paadal, :paadal_english, :english_short_desc, :tamil_short_desc, :tamil_long_desc]
  end

  def tamil_long_desc_html
    RedCloth.new(tamil_long_desc).to_html
  end
end
