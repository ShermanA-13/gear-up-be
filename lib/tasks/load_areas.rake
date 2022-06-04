namespace :load_areas do

  task areas: :environment do
    Area.destroy_all
    source = File.read('db/openbeta-conus-areas.jsonlines')
    parsed = JSONL.parse(source)
    parsed.each do |area|
      info = {
        name: area["area_name"],
        state: area["us_state"],
        url: area["url"],
        long: area["lnglat"][0],
        lat: area["lnglat"][1]
      }
      Area.create!(info)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!("areas")
    puts "#{Area.all.count} areas created!"
  end
end
