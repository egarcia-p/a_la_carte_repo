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

      def recipes_by_user
        validate_permissions ['read:recipe'] do
          user = current_user

          recipe = Recipe.where(user_id: user.id).order(created_at: :desc)
          render json: recipe
        end
      end

      def recipes_by_cookbook
        validate_permissions ['read:recipe'] do
          cookbook_id = params[:cookbook_id]

          recipe = Recipe.where(cookbook_id: cookbook_id).order(created_at: :desc)
          render json: recipe
        end
      end

      def create
        validate_permissions ['create:recipe'] do
          user = current_user

          ActiveRecord::Base.transaction do
            new_params = add_ingredient_params(recipe_params)

            recipe = Recipe.create!(new_params.merge(user_id: user.id))

            if recipe.save
              render json: recipe
            else
              render json: recipe.errors
            end
          end
        end
      end

      def edit
        validate_permissions ['create:recipe', 'edit:recipe'] do
          recipe = Recipe.find(params[:id])
          user = current_user

           ActiveRecord::Base.transaction do
            new_params = add_ingredient_params(recipe_params_edit)

            if recipe.user_id != user.id
              render json: { error: 'Cannot delete other users recipes' }, status: :forbidden
            elsif recipe.update(new_params.merge(user_id: user.id))
              # validate if recipe was updated
              render json: recipe
            else
              render json: recipe.errors
            end
          end
        end
      end

      def show
        if recipe
          render jbuilder: "api/v1/recipes/show.json.jbuilder"
        else
          render json: recipe.errors
        end
      end

      def destroy
        user = current_user

        if recipe.user_id != user.id
          render json: { error: 'Cannot delete other users recipes' }, status: :forbidden
        else
          recipe&.destroy
          render json: { message: 'Recipe deleted!' }
        end
      end

      private

      def recipe_params
        params.require(:recipe).permit(
          :title, :subtitle, :servings, :total_time, :author, :category_id, :subcategory_id, :cookbook_id,
          sections_attributes: [
            :name, :sort_number, :_destroy,
            { steps_attributes: %i[description step_number _destroy],
              recipe_ingredients_attributes: %i[ingredient_id fdc_id name quantity uom_id _destroy] }
          ]
        )
      end

      def recipe_params_edit
        params.require(:recipe).permit(
          :title, :subtitle, :servings, :total_time, :author, :category_id, :subcategory_id, :cookbook_id,
          sections_attributes: [
            :id, :name, :sort_number, :_destroy,
            { steps_attributes: %i[id description step_number _destroy],
              recipe_ingredients_attributes: %i[id ingredient_id fdc_id name quantity uom_id _destroy] }
          ]
        )
      end

      def recipe
        @recipe ||= Recipe.includes(:sections).includes(:steps).find(params[:id])
      end

      def add_ingredient_params(params)
        params[:sections_attributes].each do |section|
          section[:recipe_ingredients_attributes].each do |ingredient|
            ingredient_record = Ingredient.find_or_create_by_fdc_id(ingredient[:fdc_id], ingredient[:name])

            ingredient[:ingredient_id] = ingredient_record.id
            ingredient.delete(:fdc_id)
            ingredient.delete(:name)
          end
        end
        params
      end
    end
  end
end
