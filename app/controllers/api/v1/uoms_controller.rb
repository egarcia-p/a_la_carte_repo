# frozen_string_literal: true

module Api
  module V1
    class UomsController < ApplicationController # rubocop:todo Style/Documentation
      before_action :authorize

      def index
        validate_permissions ['read:recipe'] do
          uoms = Uom.all.order(id: :asc)
          render json: uoms
        end
      end

      def create
        validate_permissions ['create:uom'] do
          uom = Uom.create!(uom_params)
          if uom
            render json: uom
          else
            render json: uom.errors
          end
        end
      end

      def edit
        validate_permissions ['create:uom'] do
          uom = Uom.find(params[:id])
          if uom
            render json: uom
          else
            render json: uom.errors
          end
        end
      end

      def update
        validate_permissions ['create:uom'] do
          uom = Uom.find(params[:id])
          if uom.update(uom_params)
            render json: uom
          else
            render json: uom.errors
          end
        end
      end

      def destroy
        validate_permissions ['delete:uom'] do
          uom&.destroy
          render json: { message: 'Uom deleted!' }
        end
      end

      private

      def uom_params
        params.permit(:name, :base_unit, :system, :conversion)
      end

      def uom
        @uom ||= Uom.find(params[:id])
      end
    end
  end
end
