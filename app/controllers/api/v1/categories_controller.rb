# frozen_string_literal: true

module Api
  module V1
    class CategoriesController < ApplicationController # rubocop:todo Style/Documentation
      before_action :authorize

      def index
        validate_permissions ['read:recipe'] do
          categories = Category.all.order(id: :asc)
          render json: categories
        end
      end

      def create
        validate_permissions ['create:category'] do
          category = Category.create!(category_params)
          if category
            render json: category
          else
            render json: category.errors
          end
        end
      end

      def edit
        validate_permissions ['create:category'] do
          category = Category.find(params[:id])
          if category
            render json: category
          else
            render json: category.errors
          end
        end
      end

      def update
        validate_permissions ['create:category'] do
          category = Category.find(params[:id])
          if category.update(category_params)
            render json: category
          else
            render json: category.errors
          end
        end
      end

      def destroy
        validate_permissions ['delete:category'] do
          category&.destroy
          render json: { message: 'Category deleted!' }
        end
      end

      private

      def category_params
        params.permit(:name)
      end

      def category
        @category ||= Category.find(params[:id])
      end
    end
  end
end
