## Module 1 Assessment Starter Kit

This project will serve as the jumping-off point for several module one assessment challenges. Before your assessment, you should clone this repository, `bundle`, and make sure all the tests pass by running `rake`.

Then, spend a few minutes to familiarize yourself with the structure and contents of the project. So far it contains a single Ruby class, `Recipe`, and some accompanying tests.

#### Running Tests

From the project's root, `rake` like a boss.

#### Installing Dependencies

You will probably the gems needed for this project already on your machine, but if not, `bundle`.

Before coming to the assessment, students should clone down the starter repository [here](https://github.com/turingschool-examples/pantry).

`git@github.com:turingschool-examples/pantry.git`

It contains a standard directory scaffold as well as a straightforward recipe class.

### Iteration 1: Pantry Stocking

Build a simple Pantry-tracking program that can store a list of ingredients and available
quantities. Once we have tracked our ingredients and quantities, we'll use the Recipe class
we built before to have the pantry prepare a shopping list for us.

Support the following interactions:

```ruby
pantry = Pantry.new
# => <Pantry...>

# Checking and adding stock
pantry.stock
# => {}

pantry.stock_check("Cheese")
# => 0

pantry.restock("Cheese", 10)
pantry.stock_check("Cheese")
# => 10

pantry.restock("Cheese", 20)
pantry.stock_check("Cheese")
# => 30
```

### Iteration 2: Shopping List

Add a feature to your pantry to generate a shopping list for a collection of recipes.

We'll follow this interaction pattern:

```ruby
pantry = Pantry.new
# => <Pantry...>

# Building our recipe
r = Recipe.new("Cheese Pizza")
# => <Recipe...>

r.ingredients
# => {}

r.add_ingredient("Cheese", 20)
r.add_ingredient("Flour", 20)

r.ingredients
# => {"Cheese" => 20, "Flour" => 20}

# Adding the recipe to the shopping list
pantry.add_to_shopping_list(r)

# Checking the shopping list
pantry.shopping_list # => {"Cheese" => 20, "Flour" => 20}

# Adding another recipe
r = Recipe.new("Spaghetti")
r.add_ingredient("Spaghetti Noodles", 10)
r.add_ingredient("Marinara Sauce", 10)
r.add_ingredient("Cheese", 5)
pantry.add_to_shopping_list(r)

# Checking the shopping list
pantry.shopping_list # => {"Cheese" => 25, "Flour" => 20, "Spaghetti Noodles" => 10, "Marinara Sauce" => 10}

# Printing the shopping list
pantry.print_shopping_list
# * Cheese: 25
# * Flour: 20
# * Spaghetti Noodles: 10
# * Marinara Sauce: 10
# => "* Cheese: 25\n* Flour: 20\n* Spaghetti Noodles: 10\n* Marinara Sauce: 10"
```

### Iteration 3: What Can I Make?

Add a feature to your pantry that can recommend recipes for us to cook based on what
ingredients we currently have in stock.

Support this interaction pattern:

```ruby
pantry = Pantry.new

# Building our recipe
r1 = Recipe.new("Cheese Pizza")
r1.add_ingredient("Cheese", 20)
r1.add_ingredient("Flour", 20)

r2 = Recipe.new("Pickles")
r2.add_ingredient("Brine", 10)
r2.add_ingredient("Cucumbers", 30)

r3 = Recipe.new("Peanuts")
r3.add_ingredient("Raw nuts", 10)
r3.add_ingredient("Salt", 10)


# Adding the recipe to the cookbook
pantry.add_to_cookbook(r1)
pantry.add_to_cookbook(r2)
pantry.add_to_cookbook(r3)

# Stock some ingredients
pantry.restock("Cheese", 10)
pantry.restock("Flour", 20)
pantry.restock("Brine", 40)
pantry.restock("Cucumbers", 120)
pantry.restock("Raw nuts", 20)
pantry.restock("Salt", 20)

# What can I make?
pantry.what_can_i_make # => ["Pickles", "Peanuts"]

# How many can I make?
pantry.how_many_can_i_make # => {"Pickles" => 4, "Peanuts" => 2}
```
