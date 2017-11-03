class RecipesController < ApplicationController
  def index
    @search = params[:search]
    @recipes = EdamamApiWrapper.list_recipes(@search)

    # binding.pry
    # @paginatable_recipes = @recipes.page(params[:page]).per(10)
    if @search == ""
      flash[:message] = "Must put words in the Search bar.  How about 'cake'?"
      flash[:status] = "error"
      redirect_to root_path
    elsif @recipes.empty?
      flash[:message] = "No Results"
      flash[:status] = "error"
      redirect_to root_path
    else
      @paginatable_recipes = Kaminari.paginate_array(@recipes).page(params[:page]).per(10)
    end

  end

  def show
    @uri = params[:name]
    @recipe = EdamamApiWrapper.find_recipe(@uri)
    if @recipe == "Empty Array or nil in data_parsed"
      flash[:message] = "Oops, there is no recipe."
      flash[:status] = "error"
      redirect_to root_path
    else
      flash[:status] = :success
      flash[:message] = "Successfully retrieved recipe."
    end
    @recipe
  end

  def main
  end

end
