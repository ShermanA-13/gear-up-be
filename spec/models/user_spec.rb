# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should have_many(:items) }
    it { should have_many(:trip_items).through(:items) }
    it { should have_many(:trip_users) }
    it { should have_many(:trips).through(:trip_users) }
  end

  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_uniqueness_of(:email) }
  end
end
