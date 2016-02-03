class PostSerializer < ActiveModel::Serializer 
  attributes :id, :name, :content, :user_id
end