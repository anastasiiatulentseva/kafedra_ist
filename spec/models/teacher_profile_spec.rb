require 'rails_helper'

RSpec.describe TeacherProfile, type: :model do
  it "is valid with user_id" do
    teacher = TeacherProfile.new(user_id: 1)
    expect(teacher).to be_valid
  end

  it { is_expected.to validate_presence_of(:user_id) }
end

