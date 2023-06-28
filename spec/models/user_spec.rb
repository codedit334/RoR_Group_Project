require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      user = FactoryBot.build(:user, email: 'oussama_elabdioui@hotmail.com')
      expect(user).to be_valid
    end

    it 'is not valid without a name' do
      user = FactoryBot.build(:user, name: nil)
      expect(user).not_to be_valid
      expect(user.errors[:name]).to include("can't be blank")
    end
  end

  describe 'associations' do
    it 'has many recipes' do
      user = FactoryBot.create(:user)
      recipe = FactoryBot.create(:recipe, user:)
      expect(user.recipes).to include(recipe)
    end

    it 'has many foods' do
      user = FactoryBot.create(:user)
      food = FactoryBot.create(:food, user:)
      expect(user.foods).to include(food)
    end
  end

  describe 'methods' do
    it 'returns true when confirmed' do
      user = FactoryBot.create(:user)
      expect(user.confirmed?).to be true
    end
  end
end
