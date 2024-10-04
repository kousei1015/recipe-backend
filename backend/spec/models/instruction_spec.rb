require 'rails_helper'

RSpec.describe Instruction, type: :model do
  it "is invalid without a description" do
    instruction = FactoryBot.build(:instruction, description: nil)
    expect(instruction).not_to be_valid
  end

  it "is invalid without a recipe" do
    instruction = FactoryBot.build(:instruction, recipe: nil)
    expect(instruction).not_to be_valid
  end

  it "is invalid with a description longer than 200 characters" do
    instruction = FactoryBot.build(:instruction, description: 'a' * 201)
    expect(instruction).not_to be_valid
  end

  it "is valid with a description of 200 characters or less" do
    instruction = FactoryBot.build(:instruction, description: 'a' * 200)
    expect(instruction).to be_valid
  end
end
