class Wiki < ActiveRecord::Base

  after_create :create_first_version

  has_many :versions, :class_name => "WikiVersion"

  def create_first_version
    self.versions << WikiVersion.new(self.attributes_for_versioning.merge(:version => 1, :state => 'active'))
  end

  def attributes_for_versioning
    {"english_short_desc" => english_short_desc,  "paadal" => paadal, "paadal_english" => paadal_english,
     "tamil_long_desc" => tamil_long_desc, "tamil_short_desc" => tamil_short_desc}
  end

end
