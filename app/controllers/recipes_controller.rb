class RecipesController < ApplicationController
  def index
    @search = params[:search]
    @recipes = EdamamApiWrapper.list_recipes(@search)
    if @recipes.empty?
      flash[:message] = "No Results"
      flash[:status] = "error"
      redirect_to root_path
    else
      flash[:message] = "Success! Recipes found."
      flash[:status] = "success"
    end
    return @recipes
  end

  def show
    @recipe = EdamamApiWrapper.find_recipe(params[])
  end

  def main
  end

end
