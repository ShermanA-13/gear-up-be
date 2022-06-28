class TripInfoSerializer

  def self.trip_info(trip, weather)
    {
      id: trip.id,
      type: "trip info",
      name: trip.name,
      start_date: trip.start_date,
      end_date: trip.end_date,
      host: User.find(trip.host_id).first_name,
      host_id: trip.host_id,
      description: trip.description,
      lat: trip.area.lat,
      long: trip.area.long,
      url: trip.area.url,
      area: trip.area.name,
      state: trip.area.state,
      users: trip.users.map do |user|
            {
              id: user.id,
              first_name: user.first_name,
              last_name: user.last_name,
              email: user.email,
              user_photo: user.user_photo
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
          end,
      comments: trip.comments.map do |comment|
            {
              user_name: "#{comment.user.first_name} #{comment.user.last_name}",
              user_id: comment.user.id,
              user_photo: comment.user.user_photo,
              created_at: comment.created_at,
              message: comment.message
            }
          end,
      weather: Weather.set_forecast(weather)
      }
  end
end
