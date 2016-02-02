class UserSerializer < ActiveModel::Serializer 
  attributes :id, :user_name, :email, :first_name, :last_name
end