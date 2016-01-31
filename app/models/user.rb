class User < ActiveRecord::Base

  has_many :posts, dependent: :destroy

  validates :user_name, :first_name, :last_name, :email, presence: :true

end
