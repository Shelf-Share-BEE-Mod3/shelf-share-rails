require "rails_helper"

RSpec.describe Book do
  describe "validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :author }
    it { should validate_presence_of :description }
    it { should validate_presence_of :isbn }
    it { should validate_uniqueness_of :isbn }
    it { should validate_presence_of :category }
    it { should validate_presence_of :thumbnail }
  end
end
