# frozen_string_literal: true

module Api
  module V1
    class TagsController < ApplicationController # rubocop:todo Style/Documentation
      before_action :authorize

      def index
        validate_permissions ['read:recipe'] do
          tags = Tag.all.order(id: :asc)
          render json: tags
        end
      end

      def create
        validate_permissions ['create:tag'] do
          tag = Tag.create!(tag_params)
          if tag
            render json: tag
          else
            render json: tag.errors
          end
        end
      end

      def edit
        validate_permissions ['create:tag'] do
          tag = Tag.find(params[:id])
          if tag
            render json: tag
          else
            render json: tag.errors
          end
        end
      end

      def update
        validate_permissions ['create:tag'] do
          tag = Tag.find(params[:id])
          if tag.update(tag_params)
            render json: tag
          else
            render json: tag.errors
          end
        end
      end

      def destroy
        validate_permissions ['delete:tag'] do
          tag&.destroy
          render json: { message: 'Tag deleted!' }
        end
      end

      private

      def tag_params
        params.permit(:name, :color)
      end

      def tag
        @tag ||= Tag.find(params[:id])
      end
    end
  end
end
