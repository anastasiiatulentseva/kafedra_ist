require 'rails_helper'

RSpec.describe TeachersSchedule, type: :model do

  it { is_expected.to validate_uniqueness_of(:week) }
end
