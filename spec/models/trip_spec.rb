require 'rails_helper'

RSpec.describe Trip, type: :model do
  describe 'relationships' do
    it { should have_many :trip_items }
    it { should have_many :trip_users }
    it { should have_many(:users).through(:trip_users) }
    it { should have_many(:items).through(:trip_items) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :location }
    it { should validate_presence_of :start_date }
    it { should validate_presence_of :end_date }
    it { should validate_presence_of :description }
    it { should validate_presence_of :host_id }

    # it { should validate_inclusion_of(:start_date).in_range(Date.today..Date.today.next) }

  end
end
