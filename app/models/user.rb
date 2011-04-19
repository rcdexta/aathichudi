class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :rememberable, :trackable, :validatable, :rpx_connectable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  def before_rpx_success(rpx_user)
    p "*"*100
    p 'RPX SUCCESS'
    p rpx_user
#    user = User.find_by_rpx_identifier(rpx_user.identifier)
#    user.update_attributes(:email => rpx_user.
  end

end
