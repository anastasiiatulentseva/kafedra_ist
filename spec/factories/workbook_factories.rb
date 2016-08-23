FactoryGirl.define do
  factory :workbook do
    sequence(:name) { |n| "workbook#{n}" }
    subject
    teacher_profile
    attachment { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'files', '123.zip')) }
  end
end
