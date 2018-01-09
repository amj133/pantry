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

  def test_can_add_multiple_recipe_ingredients_to_shopping_list
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

  def test_print_shopping_list
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

    assert_equal "* Cheese: 25\n* Flour: 20\n* Spaghetti Noodles: 10\n* Marinara Sauce: 10", pantry.print_shopping_list
  end

  def test_can_add_recipes_to_cookbook
    pantry = Pantry.new
    recipe_1 = Recipe.new("Cheese Pizza")
    recipe_2 = Recipe.new("Pickles")
    recipe_3 = Recipe.new("Peanuts")

    recipe_1.add_ingredient("Cheese", 20)
    recipe_1.add_ingredient("Flour", 20)
    pantry.add_to_cookbook(recipe_1)

    assert_equal [recipe_1], pantry.cookbook

    recipe_2.add_ingredient("Brine", 10)
    recipe_2.add_ingredient("Cucumbers", 30)
    pantry.add_to_cookbook(recipe_2)

    assert_equal [recipe_1, recipe_2], pantry.cookbook

    recipe_3.add_ingredient("Raw nuts", 10)
    recipe_3.add_ingredient("Salt", 10)
    pantry.add_to_cookbook(recipe_3)

    assert_equal [recipe_1, recipe_2, recipe_3], pantry.cookbook
  end

  def test_ingredients_available_returns_hash_with_recipe_as_key_and_true_false_as_value
    pantry = Pantry.new
    recipe_1 = Recipe.new("Cheese Pizza")
    recipe_2 = Recipe.new("Pickles")
    recipe_3 = Recipe.new("Peanuts")

    recipe_1.add_ingredient("Cheese", 20)
    recipe_1.add_ingredient("Flour", 20)
    pantry.add_to_cookbook(recipe_1)

    recipe_2.add_ingredient("Brine", 10)
    recipe_2.add_ingredient("Cucumbers", 30)
    pantry.add_to_cookbook(recipe_2)

    recipe_3.add_ingredient("Raw nuts", 10)
    recipe_3.add_ingredient("Salt", 10)
    pantry.add_to_cookbook(recipe_3)

    pantry.restock("Cheese", 10)
    pantry.restock("Flour", 20)
    pantry.restock("Brine", 40)
    pantry.restock("Cucumbers", 120)
    pantry.restock("Raw nuts", 20)
    pantry.restock("Salt", 20)

    assert_equal({"Cheese Pizza" => false,
                  "Pickles"      => true,
                  "Peanuts"      => true}, pantry.ingredients_available?)
  end

  def test_what_can_i_make
    pantry = Pantry.new
    recipe_1 = Recipe.new("Cheese Pizza")
    recipe_2 = Recipe.new("Pickles")
    recipe_3 = Recipe.new("Peanuts")

    recipe_1.add_ingredient("Cheese", 20)
    recipe_1.add_ingredient("Flour", 20)
    pantry.add_to_cookbook(recipe_1)

    recipe_2.add_ingredient("Brine", 10)
    recipe_2.add_ingredient("Cucumbers", 30)
    pantry.add_to_cookbook(recipe_2)

    recipe_3.add_ingredient("Raw nuts", 10)
    recipe_3.add_ingredient("Salt", 10)
    pantry.add_to_cookbook(recipe_3)

    pantry.restock("Cheese", 10)
    pantry.restock("Flour", 20)
    pantry.restock("Brine", 40)
    pantry.restock("Cucumbers", 120)
    pantry.restock("Raw nuts", 20)
    pantry.restock("Salt", 20)

    assert_equal ["Pickles", "Peanuts"], pantry.what_can_i_make
  end

  def test_ingredient_amounts_for_each_recipe_returns_hash_with_stock_amount_div_by_recipe_amount_as_values
    pantry = Pantry.new
    recipe_1 = Recipe.new("Cheese Pizza")
    recipe_2 = Recipe.new("Pickles")
    recipe_3 = Recipe.new("Peanuts")

    recipe_1.add_ingredient("Cheese", 20)
    recipe_1.add_ingredient("Flour", 20)
    pantry.add_to_cookbook(recipe_1)

    recipe_2.add_ingredient("Brine", 10)
    recipe_2.add_ingredient("Cucumbers", 30)
    pantry.add_to_cookbook(recipe_2)

    recipe_3.add_ingredient("Raw nuts", 10)
    recipe_3.add_ingredient("Salt", 10)
    pantry.add_to_cookbook(recipe_3)

    pantry.restock("Cheese", 10)
    pantry.restock("Flour", 20)
    pantry.restock("Brine", 40)
    pantry.restock("Cucumbers", 120)
    pantry.restock("Raw nuts", 20)
    pantry.restock("Salt", 20)

    assert_equal({"Cheese Pizza" => [0.5, 1.0],
                  "Pickles"      => [4.0, 4.0],
                  "Peanuts"      => [2.0, 2.0]}, pantry.ingredient_amounts_for_each_recipe)
  end

  def test_how_many_can_i_make
    pantry = Pantry.new
    recipe_1 = Recipe.new("Cheese Pizza")
    recipe_2 = Recipe.new("Pickles")
    recipe_3 = Recipe.new("Peanuts")

    recipe_1.add_ingredient("Cheese", 20)
    recipe_1.add_ingredient("Flour", 20)
    pantry.add_to_cookbook(recipe_1)

    recipe_2.add_ingredient("Brine", 10)
    recipe_2.add_ingredient("Cucumbers", 30)
    pantry.add_to_cookbook(recipe_2)

    recipe_3.add_ingredient("Raw nuts", 10)
    recipe_3.add_ingredient("Salt", 10)
    pantry.add_to_cookbook(recipe_3)

    pantry.restock("Cheese", 10)
    pantry.restock("Flour", 20)
    pantry.restock("Brine", 40)
    pantry.restock("Cucumbers", 120)
    pantry.restock("Raw nuts", 20)
    pantry.restock("Salt", 20)

    assert_equal({"Pickles" => 4,
                  "Peanuts" => 2}, pantry.how_many_can_i_make)
  end

end
