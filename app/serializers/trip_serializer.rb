class TripSerializer
  include JSONAPI::Serializer
  attributes :name, :location, :description, :host_id, :start_date, :end_date
end
