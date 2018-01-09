require './lib/pantry'
require './lib/recipe'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class PantryTest < Minitest::Test

  def test_it_exists
    pantry = Pantry.new

    assert_instance_of Pantry, pantry
  end

  def test_starts_with_no_stock
    pantry = Pantry.new

    assert_equal({}, pantry.stock)
  end

  def test_stock_check_starts_with_0
    pantry = Pantry.new

    assert_equal 0, pantry.stock_check("Cheese")
    assert_equal 0, pantry.stock_check("Butter")
    assert_equal 0, pantry.stock_check("Flour")
  end

  def test_can_restock_item
    pantry = Pantry.new

    pantry.restock("Cheese", 10)

    assert_equal 10, pantry.stock_check("Cheese")

    pantry.restock("Cheese", 20)

    assert_equal 20, pantry.stock_check("Cheese")

    pantry.restock("Cheese", 30)

    assert_equal 30, pantry.stock_check("Cheese")
  end

  def test_can_add_recipe_to_shopping_list
    pantry = Pantry.new
    recipe = Recipe.new("Cheese Pizza")

    recipe.add_ingredient("Cheese", 20)
    recipe.add_ingredient("Flour", 20)
    pantry.add_to_shopping_list(recipe)

    assert_equal({"Flour" => 20, "Cheese" => 20}, pantry.shopping_list)
  end

  def test_can_add_multiple_recipes_to_shopping_list
    pantry = Pantry.new
    recipe_1 = Recipe.new("Cheese Pizza")
    recipe_2 = Recipe.new("Spaghetti")

    recipe_1.add_ingredient("Cheese", 20)
    recipe_1.add_ingredient("Flour", 20)
    pantry.add_to_shopping_list(recipe_1)
    recipe_2.add_ingredient("Spaghetti Noodles", 10)
    recipe_2.add_ingredient("Marinara Sauce", 10)
    recipe_2.add_ingredient("Cheese", 5)
    pantry.add_to_shopping_list(recipe_2)

    assert_equal({"Cheese" => 25, "Flour" => 20, "Spaghetti Noodles" => 10, "Marinara Sauce" => 10}, pantry.shopping_list)
  end

end
