class TripInfoSerializer
  def self.trip_info(trip)
    {
      id: trip.id,
      type: "trip info",
      name: trip.name,
      start_date: trip.start_date,
      end_date: trip.end_date,
      host: User.find(trip.host_id).first_name,
      lat: trip.area.lat,
      long: trip.area.long,
      area: trip.area.name,
      state: trip.area.state,
      users: trip.users.map do |user|
            {
              id: user.id,
              first_name: user.first_name,
              last_name: user.last_name,
              email: user.email
            }
          end,
      items: trip.items.map do |item|
            {
              id: item.id,
              name: item.name,
              description: item.description,
              count: item.count,
              category: item.category,
              owner: item.user.first_name
            }
          end
      }
  end
end
