require 'rails_helper'

RSpec.describe Relationship, type: :model do
  it "is valid with valid attributes" do
    relationship = FactoryBot.build(:relationship)
    expect(relationship).to be_valid
  end

  it "is invalid without a follower" do
    relationship = FactoryBot.build(:relationship, follower: nil)
    expect(relationship).not_to be_valid
  end

  it "is invalid without a followed" do
    relationship = FactoryBot.build(:relationship, followed: nil)
    expect(relationship).not_to be_valid
  end
end
