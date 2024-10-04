require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  it "is valid with valid attributes" do
    ingredient = FactoryBot.build(:ingredient)
    expect(ingredient).to be_valid
  end

  it "is not valid without a name" do
    ingredient = FactoryBot.build(:ingredient, name: nil)
    expect(ingredient).not_to be_valid
  end

end
