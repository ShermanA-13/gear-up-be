require "rails_helper"

RSpec.describe Area, type: :model do
  describe "relationships" do
    it { should have_many :trips }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :state }
    it { should validate_presence_of :url }
    it { should validate_presence_of :lat }
    it { should validate_presence_of :long }
  end

  describe "class methods" do
    it "can get all areas by name" do
      area_list = create_list(:area, 4)
      devils_lake =
        Area.create!(
          name: "Devil's Lake",
          state: "WI",
          url: "www.mountainproject.com/devils_lake",
          lat: "43.41444124923926",
          long: "-89.70718195587138"
        )

      search = Area.find_all_by_name("dev")

      expect(search[0]).to eq(devils_lake)
      expect(search).to_not eq(area_list.sample)
    end
  end
end
