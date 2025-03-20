# frozen_string_literal: true

module Api
  module V1
    class SubcategoriesController < ApplicationController # rubocop:todo Style/Documentation
      before_action :authorize

      def index
        validate_permissions ['read:recipe'] do
          subcategories = Subcategory.all.order(id: :asc)
          render json: subcategories
        end
      end

      def create
        validate_permissions ['create:subcategory'] do
          subcategory = Subcategory.create!(subcategory_params)
          if subcategory
            render json: subcategory
          else
            render json: subcategory.errors
          end
        end
      end

      def edit
        validate_permissions ['create:subcategory'] do
          subcategory = Subcategory.find(params[:id])
          if subcategory
            render json: subcategory
          else
            render json: subcategory.errors
          end
        end
      end

      def update
        validate_permissions ['create:subcategory'] do
          subcategory = Subcategory.find(params[:id])
          if subcategory.update(subcategory_params)
            render json: subcategory
          else
            render json: subcategory.errors
          end
        end
      end

      def destroy
        validate_permissions ['delete:subcategory'] do
          subcategory&.destroy
          render json: { message: 'Subcategory deleted!' }
        end
      end

      private

      def subcategory_params
        params.permit(:name, :category_id)
      end

      def subcategory
        @subcategory ||= Subcategory.find(params[:id])
      end
    end
  end
end
