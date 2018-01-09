require 'pry'

class Pantry
  attr_reader :stock, :shopping_list

  def initialize
    @stock = Hash.new(0)
    @shopping_list = {}
  end

  def stock_check(item)
    stock[item]
  end

  def restock(item, quantity)
    stock[item] = quantity
  end

  def add_to_shopping_list(recipe)
    @shopping_list = @shopping_list.merge(recipe.ingredients)
    # people_debts.merge!(activity_debt){|key, oldval, newval| oldval + newval}
  end

end
