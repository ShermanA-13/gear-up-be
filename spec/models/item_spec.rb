require "rails_helper"

RSpec.describe Item, type: :model do
  describe "relationships" do
    it { should belong_to(:user) }
    it { should have_many(:trip_items) }
    it { should have_many(:trips).through(:trip_items) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_numericality_of(:count) }
    it { should define_enum_for(:category).with_values([
      "Tents",
      "Sleeping Bag",
      "Stives, Grills & Fuel",
      "Cookware",
      "Dishes",
      "Ropes",
      "Harnesses",
      "Belay & Rappel",
      "Crash Pads",
      "Quickdraws"
    ])}
  end
end
