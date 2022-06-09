class UserSerializer
  include JSONAPI::Serializer
  attributes :first_name, :last_name, :email, :user_photo
end
