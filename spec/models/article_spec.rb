require 'rails_helper'

RSpec.describe Article, type: :model do
  
  it "should be valid with name" do
    article = Article.new(name: "About kafedra")
    expect(article).to be_valid
  end

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_numericality_of(:order) }

end
