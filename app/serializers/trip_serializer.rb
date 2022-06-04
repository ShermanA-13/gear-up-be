class TripSerializer
  include JSONAPI::Serializer
  attributes :name, :area_id, :description, :host_id, :start_date, :end_date
end
