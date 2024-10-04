require 'rails_helper'

RSpec.describe Favorite, type: :model do
  it "is valid with valid attributes" do
    favorite = FactoryBot.build(:favorite)
    expect(favorite).to be_valid
  end

  it "is invalid without a user" do
    favorite = FactoryBot.build(:favorite, user: nil)
    expect(favorite).not_to be_valid
  end

  it "is invalid without a recipe" do
    favorite = FactoryBot.build(:favorite, recipe: nil)
    expect(favorite).not_to be_valid
  end
end
