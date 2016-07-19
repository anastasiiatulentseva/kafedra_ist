require 'rails_helper'

RSpec.describe Workbook, type: :model do

  it "is valid with name and subject_id" do
    subject = Subject.new(name: "Math", specialty: "computes science", year: 6)
    subject.save
    workbook = Workbook.new(name: "Math workbook", subject_id: subject.id)
    expect(workbook).to be_valid
  end

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:subject_id) }

end
