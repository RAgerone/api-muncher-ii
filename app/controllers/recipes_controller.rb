class RecipesController < ApplicationController
  def index
    @search = params[:search]
    @recipes = EdamamApiWrapper.list_recipes(@search)
    if @recipes.empty?
      flash[:message] = "No Results"
      flash[:status] = "error"
      redirect_to root_path
    end
    return @recipes
  end

  def show
    @uri = params[:name]
    @recipe = EdamamApiWrapper.find_recipe(@uri)
  end

  def main
  end

end
