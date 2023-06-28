require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      recipe_food = FactoryBot.build(:recipe_food)
      expect(recipe_food).to be_valid
    end

    it 'is not valid without a quantity' do
      recipe_food = FactoryBot.build(:recipe_food, quantity: nil)
      expect(recipe_food).not_to be_valid
      expect(recipe_food.errors[:quantity]).to include("can't be blank")
    end

    it 'is not valid with a negative quantity' do
      recipe_food = FactoryBot.build(:recipe_food, quantity: -1)
      expect(recipe_food).not_to be_valid
      expect(recipe_food.errors[:quantity]).to include("must be greater than or equal to 0")
    end
  end

  describe 'associations' do
    it 'belongs to a food' do
      recipe_food = FactoryBot.create(:recipe_food)
      expect(recipe_food.food).to be_instance_of(Food)
    end

    it 'belongs to a recipe' do
      recipe_food = FactoryBot.create(:recipe_food)
      expect(recipe_food.recipe).to be_instance_of(Recipe)
    end
  end
end
