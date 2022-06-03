require "rails_helper"

RSpec.describe TripItem, type: :model do
  describe "relationships" do
    it { should belong_to(:trip) }
    it { should belong_to(:item) }
    it { should have_one(:user).through(:item) }
  end
end
