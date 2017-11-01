require 'test_helper'

describe EdamamApiWrapper do
  it 'can get a list of recipes' do
    VCR.use_cassette('recipes') do
      result = EdamamApiWrapper.list_recipes("spaghetti")
      result.must_be_kind_of Array
      result.each do |recipe|
        recipe.must_be_kind_of Recipe
      end
      result.length.must_be :>, 0
    end
  end

  it "fails sometimes" do
    VCR.use_cassette("no_network_access") do

    nil_string =   EdamamApiWrapper.list_recipes("")
    nil_string.must_equal "Empty Array in data_parsed"
    end
  end

  it "can find a specific recipe by uri" do
    VCR.use_cassette('recipes') do
      result = EdamamApiWrapper.find_recipe("recipe_637913ec61d9da69eb451818c3293df2")
      result.wont_be_nil
      result.must_be_kind_of Recipe
    end
  end
end
