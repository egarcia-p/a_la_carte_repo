# frozen_string_literal: true

module Api
  module V1
    class StepsController < ApplicationController # rubocop:todo Style/Documentation
      include Secured

      %i[section_id recipe_id].each do |attribute|
        define_method :"find_by_#{attribute}" do
          steps = Step.find_by("#{attribute}": params[:id])
          if steps
            render json: steps
          else
            render json: {}
          end
        end
      end

      def create
        step = Step.create!(step_params)
        if step
          render json: step
        else
          render json: step.errors
        end
      end

      def edit
        step = Step.find(params[:id])
        if step
          render json: step
        else
          render json: step.errors
        end
      end

      def update
        step = Step.find(params[:id])
        if step.update(step_params)
          render json: step
        else
          render json: step.errors
        end
      end

      def destroy
        step&.destroy
        render json: { message: 'Step deleted!' }
      end

      private

      def step_params
        params.permit(:description, :step_number, :section_id, :recipe_id)
      end

      def step
        @step ||= Step.find(params[:id])
      end
    end
  end
end
