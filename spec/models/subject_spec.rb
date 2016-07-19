require 'rails_helper'

RSpec.describe Subject, type: :model do

  it "is valid with name, specialty and year" do
    subject = Subject.new(name: "Math", specialty: "computes science", year: 6)
    expect(subject).to be_valid
  end

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:specialty) }
  it { is_expected.to validate_presence_of(:year) }
  it { is_expected.to validate_inclusion_of(:year).in_range(1..6) }

end
