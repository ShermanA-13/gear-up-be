class TripInfoSerializer
  def self.trip_info(trip, weather)
    # require "pry"; binding.pry
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
          end,
      weather: {forecast:
              weather.group_by {|w| w.date.split[0] }.map do |date, info|
               { date: date.split[0],
               weather: {
                 low_temp: info.sort_by {|w| w.temp}.first.temp,
                 high_temp: info.sort_by {|w| w.temp}.last.temp,
                 cloud_coverage: info.select {|w| w.date.include?("12:00:00")}.first.cloud_coverage,
                 feels_like: info.select {|w| w.date.include?("12:00:00")}.first.feels_like,
                 humidity: info.select {|w| w.date.include?("12:00:00")}.first.humidity,
                 percipitation_probability: info.select {|w| w.date.include?("12:00:00")}.first.percipitation_probability,
                 visibility: info.select {|w| w.date.include?("12:00:00")}.first.visibility,
                 weather: info.select {|w| w.date.include?("12:00:00")}.first.weather,
                 weather_description: info.select {|w| w.date.include?("12:00:00")}.first.weather_description,
                 weather_icon: info.select {|w| w.date.include?("12:00:00")}.first.weather_icon,
                 wind_direction: info.select {|w| w.date.include?("12:00:00")}.first.wind_direction,
                 wind_gust: info.select {|w| w.date.include?("12:00:00")}.first.wind_gust,
                 wind_speed: info.select {|w| w.date.include?("12:00:00")}.first.wind_speed
               }
             }
           end,
           today_sunrise: weather.first.sunrise,
           today_sunset: weather.first.sunset
        }
      }
  end
end
