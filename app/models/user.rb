class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :rememberable, :trackable, :registerable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  before_create :bootstrap_user
  after_create :send_welcome_email

  def before_rpx_success(rpx_user)
    user = User.find_by_rpx_identifier(rpx_user['identifier'])
    if user.present?
      user.update_attribute(:name, rpx_user['name']) if rpx_user['name']
      user.update_attribute(:photo, rpx_user['photo']) if rpx_user['photo']
    end
  end

  def bootstrap_user
    self.accepted_count = 0
    self.rejected_count = 0
  end

  def send_welcome_email
    Thread.new do
      UserNotifier.welcome_mail(self).deliver
    end
  end

  def display_name
    self.name || self.email || ''
  end

end
