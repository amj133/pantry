require 'pry'
require 'bigdecimal'

class Pantry
  attr_reader :stock, :shopping_list, :cookbook

  def initialize
    @stock = Hash.new(0)
    @shopping_list = {}
    @cookbook = []
  end

  def stock_check(item)
    stock[item]
  end

  def restock(item, quantity)
    stock[item] = quantity
  end

  def add_to_shopping_list(recipe)
    @shopping_list = shopping_list.merge!(recipe.ingredients) do |key, oldval, newval|
      oldval + newval
    end
  end

  def print_shopping_list
    printed = shopping_list.map do |key, value|
      "* #{key}: #{value}\n"
    end.join.chomp
    puts "\n" + printed
    printed
  end

  def add_to_cookbook(recipe)
    cookbook << recipe
  end

  def ingredients_available?
    availability = {}
    cookbook.each do |recipe|
      availability[recipe.name] = recipe.ingredients.all? do |ingredient, amount|
        amount <= stock[ingredient]
      end
    end
    availability
  end

  def what_can_i_make
    can_make = []
    ingredients_available?.each do |recipe_name, availability|
      can_make << recipe_name if availability
    end
    can_make
  end

  def ingredient_amounts_for_each_recipe
    how_many = {}
    cookbook.each do |recipe|
      how_many[recipe.name] = recipe.ingredients.map do |item, amount|
        BigDecimal.new(stock[item]) / amount
      end
    end
    how_many
  end

  def how_many_can_i_make
    how_many_can_make = {}
    ingredient_amounts_for_each_recipe.each do |recipe_name, amount_array|
      if (amount_array.any? {|amount| amount < 1})
        how_many_can_make[recipe_name] = nil
      else
      how_many_can_make[recipe_name] = amount_array.min.to_i
      end 
    end
    how_many_can_make.compact
  end

end
