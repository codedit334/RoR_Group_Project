require 'rails_helper'

RSpec.describe Food, type: :model do
    describe 'validations' do
      it 'is valid with valid attributes' do
        food = FactoryBot.build(:food)
        expect(food).to be_valid
      end
  
      it 'is not valid without a name' do
        food = FactoryBot.build(:food, name: nil)
        expect(food).not_to be_valid
        expect(food.errors[:name]).to include("can't be blank")
      end
  
      it 'is not valid without a measurement unit' do
        food = FactoryBot.build(:food, measurement_unit: nil)
        expect(food).not_to be_valid
        expect(food.errors[:measurement_unit]).to include("can't be blank")
      end
  
      it 'is not valid with a negative price' do
        food = FactoryBot.build(:food, price: -1)
        expect(food).not_to be_valid
        expect(food.errors[:price]).to include("must be greater than or equal to 0")
      end
  
      it 'is not valid with a negative quantity' do
        food = FactoryBot.build(:food, quantity: -1)
        expect(food).not_to be_valid
        expect(food.errors[:quantity]).to include("must be greater than or equal to 0")
      end
    end
  
    describe 'associations' do
      it 'belongs to a user' do
        food = FactoryBot.create(:food)
        expect(food.user).to be_instance_of(User)
      end
  
      it 'has many recipe_foods' do
        food = FactoryBot.create(:food)
        recipe_food = FactoryBot.create(:recipe_food, food: food)
        expect(food.recipe_foods).to include(recipe_food)
      end
  
      it 'has many recipes through recipe_foods' do
        food = FactoryBot.create(:food)
        recipe = FactoryBot.create(:recipe)
        recipe_food = FactoryBot.create(:recipe_food, food: food, recipe: recipe)
        expect(food.recipes).to include(recipe)
      end
    end
  end
  