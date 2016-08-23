require 'rails_helper'

RSpec.describe Specialty, type: :model do
  it "should be valid with name" do
    specialty = Specialty.new(name: "Computer science")
    expect(specialty).to be_valid
  end

  it { is_expected.to validate_presence_of(:name) }

end
