require 'rails_helper'

RSpec.describe Recipe, type: :model do
    describe 'validations' do
      it 'is valid with valid attributes' do
        recipe = FactoryBot.build(:recipe)
        expect(recipe).to be_valid
      end
  
      it 'is not valid without a name' do
        recipe = FactoryBot.build(:recipe, name: nil)
        expect(recipe).not_to be_valid
        expect(recipe.errors[:name]).to include("can't be blank")
      end
  
      it 'is not valid without a preparation time' do
        recipe = FactoryBot.build(:recipe, preparation_time: nil)
        expect(recipe).not_to be_valid
        expect(recipe.errors[:preparation_time]).to include("can't be blank")
      end
  
      it 'is not valid without a cooking time' do
        recipe = FactoryBot.build(:recipe, cooking_time: nil)
        expect(recipe).not_to be_valid
        expect(recipe.errors[:cooking_time]).to include("can't be blank")
      end
  
      it 'is not valid without a description' do
        recipe = FactoryBot.build(:recipe, description: nil)
        expect(recipe).not_to be_valid
        expect(recipe.errors[:description]).to include("can't be blank")
      end
    end
  
    describe 'associations' do
      it 'belongs to a user' do
        recipe = FactoryBot.create(:recipe)
        expect(recipe.user).to be_instance_of(User)
      end
  
      it 'has many recipe_foods' do
        recipe = FactoryBot.create(:recipe)
        recipe_food = FactoryBot.create(:recipe_food, recipe: recipe)
        expect(recipe.recipe_foods).to include(recipe_food)
      end
  
      it 'has many foods through recipe_foods' do
        recipe = FactoryBot.create(:recipe)
        food = FactoryBot.create(:food)
        recipe_food = FactoryBot.create(:recipe_food, recipe: recipe, food: food)
        expect(recipe.foods).to include(food)
      end
    end
  end
  