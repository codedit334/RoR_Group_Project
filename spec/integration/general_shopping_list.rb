require 'rails_helper'

RSpec.describe 'GeneralShoppingLists', type: :request do
  let(:user) { FactoryBot.create(:user) }

  before do
    sign_in user
  end

  describe 'GET /general_shopping_lists' do
    it 'displays the shopping list' do
      recipe1 = FactoryBot.create(:recipe, user:, public: true)
      recipe2 = FactoryBot.create(:recipe, user:, public: true)
      food1 = FactoryBot.create(:food, user:, quantity: 10)
      food2 = FactoryBot.create(:food, user:, quantity: 5)

      FactoryBot.create(:recipe_food, recipe: recipe1, food: food1, quantity: 2)
      FactoryBot.create(:recipe_food, recipe: recipe2, food: food2, quantity: 3)

      get '/general_shopping_lists'

      expect(response).to have_http_status(200)
      expect(response.body).to include(food1.name)
      expect(response.body).to include(food2.name)
      expect(response.body).to include('5') # Total count
      expect(response.body).to include('15.0') # Total price
    end
  end
end
