# frozen_string_literal: true

module Api
  module V1
    class IngredientsController < ApplicationController # rubocop:todo Style/Documentation
      before_action :authorize

      def index
        validate_permissions ['read:recipe'] do
          ingredients = Ingredient.all.order(id: :asc)
          render json: ingredients
        end
      end

      def create
        validate_permissions ['create:ingredient'] do
          ingredient = Ingredient.create!(ingredient_params)
          if ingredient
            render json: ingredient
          else
            render json: ingredient.errors
          end
        end
      end

      def edit
        validate_permissions ['create:ingredient'] do
          ingredient = Ingredient.find(params[:id])
          if ingredient
            render json: ingredient
          else
            render json: ingredient.errors
          end
        end
      end

      def update
        validate_permissions ['create:ingredient'] do
          ingredient = Ingredient.find(params[:id])
          if ingredient.update(ingredient_params)
            render json: ingredient
          else
            render json: ingredient.errors
          end
        end
      end

      def destroy
        validate_permissions ['delete:ingredient'] do
          ingredient&.destroy
          render json: { message: 'Ingredient deleted!' }
        end
      end

      private

      def ingredient_params
        params.permit(:name)
      end

      def ingredient
        @ingredient ||= Ingredient.find(params[:id])
      end
    end
  end
end
