class AreaSerializer
  include JSONAPI::Serializer
  attributes :name, :state, :url, :lat, :long
end
