class ItemSerializer
  include JSONAPI::Serializer
  attributes :name, :description, :count, :category, :user_id
end
