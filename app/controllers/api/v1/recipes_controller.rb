# frozen_string_literal: true

module Api
  module V1
    class RecipesController < ApplicationController # rubocop:todo Style/Documentation
      before_action :authorize

      def index
        validate_permissions ['read:recipe'] do
          recipe = Recipe.all.order(created_at: :desc)
          render json: recipe
        end
      end

      def create
        validate_permissions ['create:recipe'] do
          recipe = Recipe.create!(recipe_params)
          if recipe
            render json: recipe
          else
            render json: recipe.errors
          end
        end
      end

      def edit
        recipe = Recipe.find(params[:id])
        if recipe
          render json: recipe
        else
          render json: recipe.errors
        end
      end

      def show
        if recipe
          render 'show.json.jbuilder' # check jbuilder gem
        else
          render json: recipe.errors
        end
      end

      def destroy
        recipe&.destroy
        render json: { message: 'Recipe deleted!' }
      end

      private

      def recipe_params
        params.permit(:title, :subtitle, :servings, :total_time, :author, :category_id, :subcategory_id)
      end

      def recipe
        @recipe ||= Recipe.includes(:sections).includes(:steps).find(params[:id])
      end
    end
  end
end
