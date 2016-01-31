class PostSerializer < ActiveModel::Serializer 
  attributes :id, :name, :content
  has_many :comments

  def comments
    object.comments
  end
end