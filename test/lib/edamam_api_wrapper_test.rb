require 'test_helper'

describe EdamamApiWrapper do
  it 'can get a list of recipes' do
    VCR.use_cassette('recipes') do
      result = EdamamApiWrapper.list_recipes("spaghetti")
      result.must_be_kind_of Array
      result.length.must_be :>, 0
    end
  end

  it "fails sometimes" do
    VCR.use_cassette("no_network_access") do
      result = EdamamApiWrapper.list_recipes("silly_token")
      puts result
    end
  end
end
