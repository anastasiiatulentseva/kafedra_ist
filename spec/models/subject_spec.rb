require 'rails_helper'

RSpec.describe Subject, type: :model do

  it "is valid with name, specialty and year" do
    specialty = create(:specialty)
    subject = Subject.new(name: "Math", specialty_id: specialty.id, course_year: 6)
    expect(subject).to be_valid
  end

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:specialty_id) }
  it { is_expected.to validate_presence_of(:course_year) }
  it { is_expected.to validate_inclusion_of(:course_year).in_range(1..6) }

end
