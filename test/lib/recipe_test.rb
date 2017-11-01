require 'test_helper'

describe Recipe do

  it "Can be instantiated with correct Info" do
    new_recipe = Recipe.new("name", "image", "ingredients", "health_labels", "nutrient_info", "url")
    new_recipe.must_be_kind_of Recipe
  end

  it "Requires a name and ID" do
    proc {
      Recipe.new()
    }.must_raise ArgumentError

    proc {
      Recipe.new("name")
    }.must_raise ArgumentError

    # Empty strings are not permitted either
    proc {
    Recipe.new("", "")
    }.must_raise ArgumentError
  end

  it "Tracks name and other attributes" do
    name = "test_name"
    image = "test_image"
    ingredients = "test_ingredients"
    health_labels = "test_health_labels"
    nutrient_info = "test_nutrient_info"
    url = "test_url"
    spaghetti = Recipe.new(name, image, image, ingredients, health_labels, nutrient_info, url)
    spaghetti.name.must_equal name
    spaghetti.image.must_equal image
    spaghetti.ingredients.must_equal ingredients
    spaghetti.health_labels.must_equal health_labels
    spaghetti.nutrient_info.must_equal nutrient_info
    spaghetti.url.must_equal url
  end




end
