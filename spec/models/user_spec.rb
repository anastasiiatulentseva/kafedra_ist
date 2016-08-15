require 'rails_helper'

RSpec.describe User, type: :model do

  it "is valid with name, email, password" do
    user = User.new(name: "Student", email: "ex@email.com", password: "password")
    expect(user).to be_valid
  end

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_inclusion_of(:course_year).in_range(1..6) }


end
