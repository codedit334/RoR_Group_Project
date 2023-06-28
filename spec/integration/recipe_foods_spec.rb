require 'rails_helper'

RSpec.describe 'RecipeFoods', type: :request do
  let(:user) { FactoryBot.create(:user, email: 'oussama_elabdioui@hotmail.com') }
  let(:recipe) { FactoryBot.create(:recipe, user:) }

  before do
    post user_session_path, params: {
      user: {
        email: user.email,
        password: user.password
      }
    }
  end

  describe 'POST /recipes/:recipe_id/recipe_foods' do
    it 'creates a new recipe food' do
      food = FactoryBot.create(:food, user:)

      post "/recipes/#{recipe.id}/recipe_foods", params: {
        recipe_food: {
          quantity: 2,
          food_id: food.id
        }
      }

      expect(response).to have_http_status(302)
      expect(RecipeFood.last.quantity).to eq(2)
      expect(RecipeFood.last.food).to eq(food)
    end

    it 'redirects to the new recipe food form if quantity is blank' do
      post "/recipes/#{recipe.id}/recipe_foods", params: {
        recipe_food: {
          quantity: '',
          food_id: ''
        }
      }

      expect(response).to have_http_status(302)
      expect(response).to redirect_to(new_recipe_recipe_food_path(recipe))
      expect(flash[:alert]).to eq('Quantity is required.')
    end

    it 'updates existing recipe food quantity' do
      food = FactoryBot.create(:food, user:)
      existing_recipe_food = FactoryBot.create(:recipe_food, recipe:, food:)

      post "/recipes/#{recipe.id}/recipe_foods", params: {
        recipe_food: {
          quantity: 5,
          food_id: food.id
        }
      }

      expect(response).to have_http_status(302)
      expect(existing_recipe_food.reload.quantity).to eq(5)
      expect(response).to redirect_to(recipe_path(recipe))
      expect(flash[:notice]).to eq('Recipe_food quantity updated successfully.')
    end
  end

  describe 'DELETE /recipes/:recipe_id/recipe_foods/:id' do
    it 'deletes an existing recipe food' do
      recipe_food = FactoryBot.create(:recipe_food, recipe:)

      delete "/recipes/#{recipe.id}/recipe_foods/#{recipe_food.id}"

      expect(response).to have_http_status(302)
      expect(RecipeFood.exists?(recipe_food.id)).to be_falsey
      expect(response).to redirect_to(recipe_path(recipe))
      expect(flash[:notice]).to eq('Recipe_food is successfully deleted.')
    end
  end
end
