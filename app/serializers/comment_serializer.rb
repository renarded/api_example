class CommentSerializer < ActiveModel::Serializer 
  attributes :id, :content, :post_id, :user_id
end