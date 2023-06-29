require 'rails_helper'
require 'rack_session_access/capybara'
require 'devise'

RSpec.describe 'Foods', type: :request do
  let(:user) { FactoryBot.create(:user, email: 'oussama_elabdioui@hotmail.com') }

  before do
    post user_session_path, params: {
      user: {
        email: user.email,
        password: user.password
      }
    }
  end

  describe 'GET /foods' do
    it 'returns a list of foods' do
      FactoryBot.create_list(:food, 5, user:)

      get '/foods'

      expect(response).to have_http_status(200)
      expect(response.body).to include('salad')
    end
  end

  describe 'GET /foods/new' do
    it 'renders the new food form' do
      get '/foods/new'

      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /foods' do
    it 'creates a new food' do
      food_params = {
        name: 'New Food',
        measurement_unit: 'grams',
        price: 9.99,
        quantity: 10
      }

      post '/foods', params: { food: food_params }

      expect(response).to have_http_status(302)
      expect(Food.last.name).to eq('New Food')
    end
  end

  describe 'DELETE /foods/:id' do
    it 'deletes an existing food' do
      food = FactoryBot.create(:food, user:)

      delete "/foods/#{food.id}"

      expect(response).to have_http_status(302)
      expect(Food.exists?(food.id)).to be false
    end
  end
end
