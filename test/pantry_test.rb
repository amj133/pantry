require './lib/pantry'
require 'minitest/autorun'
require 'minitest/pride'

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

end
