# frozen_string_literal: true

module Api
  module V1
    class CookbooksController < ApplicationController
      before_action :authorize

      def index
        validate_permissions ['read:recipe'] do
          user = user()

          cookbooks = Cookbook.where(user_id: user.id)
          render json: cookbooks
        end
      end

      def create
        validate_permissions ['create:recipe'] do
          user = user()
          cookbook = Cookbook.create!(cookbook_params.merge(user_id: user.id))
          if cookbook
            render json: cookbook
          else
            render json: cookbook.errors
          end
        end
      end

      def edit
        cookbook = Cookbook.find(params[:id])
        if cookbook
          render json: cookbook
        else
          render json: cookbook.errors
        end
      end

      def destroy
        cookbook = Cookbook.find(params[:id])

        cookbook&.destroy
        render json: { message: 'Cookbook deleted!' }
      end

      private

      def cookbook_params
        params.permit(:name, :is_favorite)
      end
    end
  end
end
