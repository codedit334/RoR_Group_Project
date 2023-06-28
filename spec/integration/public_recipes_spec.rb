require 'rails_helper'

RSpec.describe 'PublicRecipes', type: :request do
  let(:user) { FactoryBot.create(:user) }

  before do
    post user_session_path, params: {
        user: {
          email: user.email,
          password: user.password
        }
      }
  end

  describe 'GET /public_recipes' do
    it 'displays public recipes' do
      public_recipe1 = FactoryBot.create(:recipe, public: true)
      public_recipe2 = FactoryBot.create(:recipe, public: true)
      private_recipe = FactoryBot.create(:recipe, public: false)

      get '/public_recipes'

      expect(response).to have_http_status(200)
      expect(response.body).to include(public_recipe1.name)
      expect(response.body).to include(public_recipe2.name)
      expect(response.body).not_to include(private_recipe.name)
    end
  end
end
