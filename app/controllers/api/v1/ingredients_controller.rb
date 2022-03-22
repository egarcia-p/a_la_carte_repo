class Api::V1::IngredientsController < ApplicationController
  def index
    ingredients = Ingredient.all.order(id: :asc)
    render json: ingredients
  end

  def create
    ingredient = Ingredient.create!(ingredient_params)
    if ingredient
      render json: ingredient
    else
      render json: ingredient.errors
    end
  end

  def edit
    ingredient = Ingredient.find(params[:id])
    if ingredient
      render json: ingredient
    else
      render json: ingredient.errors
    end
  end

  def update
    ingredient = Ingredient.find(params[:id])
    if ingredient.update(ingredient_params)
      render json: ingredient
    else
      render json: ingredient.errors
    end
  end

  def destroy
    ingredient&.destroy
    render json: { message: 'Ingredient deleted!' }
  end

  private

  def ingredient_params
    params.permit(:name)
  end

  def ingredient
    @ingredient ||= Ingredient.find(params[:id])
  end
end
