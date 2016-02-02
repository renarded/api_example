class User < ActiveRecord::Base

  has_many :posts, dependent: :destroy
  has_many :comments

  validates :user_name, :first_name, :last_name, :email, presence: :true

end
