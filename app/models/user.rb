class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :rememberable, :trackable, :validatable, :rpx_connectable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  def before_rpx_success(rpx_user)
    p 'before_rpx_success'
    p rpx_user
    p rpx_user.class
    user = User.find_by_rpx_identifier(rpx_user['identifier'])
    p user
    if user.present?
      user.update_attribute(:name, rpx_user['name']) if rpx_user['name']
      user.update_attribute(:photo, rpx_user['photo']) if rpx_user['photo']
    end
  end

end
