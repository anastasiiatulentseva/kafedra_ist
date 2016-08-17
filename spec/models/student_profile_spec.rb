require 'rails_helper'

RSpec.describe StudentProfile, type: :model do

  it "is valid with user_id, specialty_id, course_year" do
    student = StudentProfile.new(user_id: 1, specialty_id: 2, course_year: 5)
    expect(student).to be_valid
  end

  it { is_expected.to validate_presence_of(:specialty_id) }
  it { is_expected.to validate_inclusion_of(:course_year).in_range(1..6) }

end

