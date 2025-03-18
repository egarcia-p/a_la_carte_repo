# frozen_string_literal: true

module Api
  module V1
    class CookbooksController < ApplicationController
      before_action :authorize

      def index
        validate_permissions ['read:cookbook'] do
          user = current_user()

          cookbooks = Cookbook.where(user_id: user.id)
          render json: cookbooks
        end
      end

      def create
        validate_permissions ['create:cookbook'] do
          user = current_user()
          cookbook = Cookbook.create!(cookbook_params.merge(user_id: user.id))
          if cookbook
            render json: cookbook
          else
            render json: cookbook.errors
          end
        end
      end

      def edit
        validate_permissions ['create:cookbook'] do
          cookbook = Cookbook.find(params[:id])
          if cookbook
            render json: cookbook
          else
            render json: cookbook.errors
          end
        end
      end

      def destroy
        validate_permissions ['create:cookbook'] do
          user = current_user()
          cookbook = Cookbook.find(params[:id])

          if(cookbook.user_id != user.id)
            render json: { error: 'Cannot delete other users cookbook' }, status: :forbidden
          else
            cookbook&.destroy
            render json: { message: 'Cookbook deleted!' }
          end
        end
      end

      private

      def cookbook_params
        params.permit(:name, :is_favorite)
      end
    end
  end
end
