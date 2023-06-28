require 'rails_helper'

RSpec.describe 'Recipes', type: :request do
  let(:user) { FactoryBot.create(:user, email: 'oussama_elabdioui@hotmail.com') }

  before do
    post user_session_path, params: {
        user: {
          email: user.email,
          password: user.password
        }
      }
  end

  describe 'GET /recipes' do
    it 'displays the user\'s recipes' do
      recipe1 = FactoryBot.create(:recipe, user: user, name: 'Recipe 1')
      recipe2 = FactoryBot.create(:recipe, user: user, name: 'Recipe 2')

      get '/recipes'

      expect(response).to have_http_status(200)
      expect(response.body).to include('Recipe 1')
      expect(response.body).to include('Recipe 2')
    end
  end

  describe 'GET /recipes/:id' do
    it 'displays the recipe details' do
      recipe = FactoryBot.create(:recipe, user: user, name: 'Recipe')

      get "/recipes/#{recipe.id}"

      expect(response).to have_http_status(200)
      expect(response.body).to include('Recipe')
    end
  end

  describe 'GET /recipes/new' do
    it 'displays the new recipe form' do
      get '/recipes/new'

      expect(response).to have_http_status(200)
      expect(response.body).to include('New Recipe')
    end
  end

  describe 'POST /recipes' do
    it 'creates a new recipe' do
      food1 = FactoryBot.create(:food, user: user, name: 'Food 1')
      food2 = FactoryBot.create(:food, user: user, name: 'Food 2')

      post '/recipes', params: {
        recipe: {
          name: 'New Recipe',
          preparation_time: 10,
          cooking_time: 20,
          description: 'Recipe description',
          public: true,
          food_quantities: {
            food1.id => 2,
            food2.id => 3
          }
        }
      }

      expect(response).to have_http_status(302)
      expect(Recipe.last.name).to eq('New Recipe')
      expect(Recipe.last.foods.count).to eq(2)
    end
  end

  describe 'DELETE /recipes/:id' do
    it 'deletes an existing recipe' do
      recipe = FactoryBot.create(:recipe, user: user)

      delete "/recipes/#{recipe.id}"

      expect(response).to have_http_status(302)
      expect(Recipe.exists?(recipe.id)).to be_falsey
    end
  end
end
