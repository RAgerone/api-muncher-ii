require "test_helper"

describe RecipesController do
  # it "must be a real test" do
  #   flunk "Need real tests"
  # end

  describe "index" do
    it "gets responds with success" do
      VCR.use_cassette("recipes") do

        # result = EdamamApiWrapper.list_recipes("lasagna")
        get recipes_path( :search => "spaghetti")
        must_respond_with :success
      end
    end

    it "will fail when given no data" do
      VCR.use_cassette("recipes") do
        # result = EdamamApiWrapper.list_recipes("lasagna")
        get recipes_path( :search => "")
        flash[:status].must_equal "error"
        flash[:message].must_equal "Must put words in the Search bar.  How about 'cake'?"
        must_respond_with :redirect
      end
    end

  end

  describe "show" do
    

    it "has success status when works correctly" do

      VCR.use_cassette("recipes") do

        get recipe_path( "recipe_637913ec61d9da69eb451818c3293df2")
        must_respond_with 200
        flash[:status].must_equal :success
        flash[:message].must_equal "Successfully retrieved recipe."
      end
    end

    it "fails sometimes" do

      VCR.use_cassette("no_network_access") do
        get recipe_path( "bogus info")
        flash[:status].must_equal "error"
        flash[:message].must_equal "Oops, there is no recipe."
        must_respond_with :redirect
      end
    end
  end

  describe "main" do

  end
end
