class Api::V1::CategoriesController < ApplicationController
  def index
    categories = Category.all.order(id: :asc)
    render json: categories
  end

  def create
    category = Category.create!(category_params)
    if category
      render json: category
    else
      render json: category.errors
    end
  end

  def edit
    category = Category.find(params[:id])
    if category
      render json: category
    else
      render json: category.errors
    end
  end

  def update
    category = Category.find(params[:id])
    if category.update(category_params)
      render json: category
    else
      render json: category.errors
    end
  end

  def destroy
    category&.destroy
    render json: { message: 'Category deleted!' }
  end

  private

  def category_params
    params.permit(:name)
  end

  def category
    @category ||= Category.find(params[:id])
  end
end
