require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "relationships" do
    it { should belong_to :trip }
    it { should belong_to :user }
  end

  describe "validations" do
    it { should validate_presence_of :message}
  end
end
