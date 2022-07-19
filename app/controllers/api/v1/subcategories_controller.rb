# frozen_string_literal: true

module Api
  module V1
    class SubcategoriesController < ApplicationController # rubocop:todo Style/Documentation
      def index
        subcategories = Subcategory.all.order(id: :asc)
        render json: subcategories
      end

      def create
        subcategory = Subcategory.create!(subcategory_params)
        if subcategory
          render json: subcategory
        else
          render json: subcategory.errors
        end
      end

      def edit
        subcategory = Subcategory.find(params[:id])
        if subcategory
          render json: subcategory
        else
          render json: subcategory.errors
        end
      end

      def update
        subcategory = Subcategory.find(params[:id])
        if subcategory.update(subcategory_params)
          render json: subcategory
        else
          render json: subcategory.errors
        end
      end

      def destroy
        subcategory&.destroy
        render json: { message: 'Subcategory deleted!' }
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
