require 'rails_helper'

RSpec.describe Workbook, type: :model do
  let(:filename) { File.join(Rails.root, 'spec/files/123.zip') }
  let(:attachment_file) { File.open(filename) }

  it "is valid with name, subject_id and attachment" do
    specialty = create(:specialty)
    subject = create(:subject, specialty_id: specialty.id)
    workbook = Workbook.new(name: "Math workbook", subject_id: subject.id, teacher_profile_id: 5, attachment: attachment_file)
    expect(workbook).to be_valid
  end

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:subject_id) }
  it { is_expected.to validate_presence_of(:teacher_profile_id) }
  it { is_expected.to validate_presence_of(:attachment) }

end
