require 'rails_helper'

RSpec.describe TripUser, type: :model do
  describe 'relationships' do
    it { should belong_to(:trip) }
    it { should belong_to(:user) }
  end

  describe 'validations' do
    # it { should validate_inclusion_of(:host).in_array([true, false]) }
  end
end
