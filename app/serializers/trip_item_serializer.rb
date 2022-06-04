class TripItemSerializer
  include JSONAPI::Serializer
  attributes :id, :trip_id, :item_id
end
