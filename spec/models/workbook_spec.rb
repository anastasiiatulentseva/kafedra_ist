require 'rails_helper'

RSpec.describe Workbook, type: :model do
  let(:filename) { File.join(Rails.root, 'spec/files/123.zip') }
  let(:attachment_file) { File.open(filename) }

  it "is valid with name, subject_id and attachment" do
    subject = Subject.new(name: "Math", specialty: "computes science", year: 6)
    subject.save
    workbook = Workbook.new(name: "Math workbook", subject_id: subject.id, attachment: attachment_file)
    expect(workbook).to be_valid
  end

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:subject_id) }
  it { is_expected.to validate_presence_of(:attachment) }

end
