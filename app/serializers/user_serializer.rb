class UserSerializer < ActiveModel::Serializer 
  attributes :id, :user_name, :email, :first_name, :last_name
  has_many :posts

  def comments
    object.posts
  end
end