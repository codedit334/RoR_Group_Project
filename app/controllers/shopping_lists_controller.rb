class ShoppingListsController < ApplicationController
  def index
    @user = current_user
    @recipes = @user.recipes
    @general_food_list = @user.foods

    @missing_foods = calculate_missing_foods
    @total_count = calculate_total_count
    @total_price = calculate_total_price
  end

  private

  # def calculate_missing_foods
  #   recipe_foods = @recipes.map { |recipe| recipe.foods }
  #   general_food_ids = @general_food_list.pluck(:id)
  #   missing_food_ids = recipe_foods.flatten.reject { |food| general_food_ids.include?(food.id) }
  #   Food.where(id: missing_food_ids)
  # end

  def calculate_missing_foods
    general_food_quantities = @general_food_list.group(:name).sum(:quantity)
    recipe_food_quantities = @recipes.flat_map { |recipe| recipe.foods.group(:name).sum(:quantity) }
  
    missing_foods = {}
    recipe_food_quantities.each do |name, quantity|
      if general_food_quantities[name].to_i < quantity
        missing_foods[name] = quantity - general_food_quantities[name].to_i
      end
    end
  
    missing_foods
  end

  def calculate_total_count
    @missing_foods.sum(:quantity)
  end

  def calculate_total_price
    @missing_foods.sum(:price)
  end
end