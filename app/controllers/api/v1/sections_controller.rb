# frozen_string_literal: true

# rubocop:todo Style/Documentation
module Api
  module V1
    class SectionsController < ApplicationController # rubocop:todo Metrics/ClassLength, Style/Documentation
      include Secured

      # rubocop:enable Style/Documentation
      %i[recipe_id].each do |attribute|
        define_method :"find_by_#{attribute}" do
          sections = Section.includes(:steps, :recipe_ingredients,
                                      :recipe_equipments).where("#{attribute}": params[:id])
          if sections
            render json: sections.to_json(include: %i[steps recipe_ingredients recipe_equipments])
          else
            render json: {}
          end
        end
      end

      def create
        section = Section.create!(section_params)
        if section
          render json: section
        else
          render json: section.errors
        end
      end

      # rubocop:todo Metrics/PerceivedComplexity
      # rubocop:todo Metrics/MethodLength
      # rubocop:todo Metrics/AbcSize
      def save_multiple # rubocop:todo Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/MethodLength, Metrics/PerceivedComplexity
        @targetrecords = []
        save_succeeded = true
        params[:targetrecord].each do |record|
          section = Section.find_by_id(record[:id])
          if section
            save_succeeded = false unless section.update(targetrecord_params(record))
            save_succeeded = false unless save_steps(record, section)
            save_succeeded = false unless save_ingredients(record, section)
            save_succeeded = false unless save_equipments(record, section)
            tr = record
          else
            tr = Section.new(targetrecord_params(record))
            save_succeeded = false unless tr.save
            if save_succeeded
              record[:id] = tr.id
              save_succeeded = false unless save_steps(record, tr)
              save_succeeded = false unless save_ingredients(record, tr)
              save_succeeded = false unless save_equipments(record, tr)
            else
              @targetrecords << "invalid Record: #{tr}"
            end
          end

          @targetrecords << tr
        end

        if save_succeeded
          render json: @targetrecords.to_json, status: 200
        else
          render json: @targetrecords.to_json, status: 404
        end
      end
      # rubocop:enable Metrics/AbcSize
      # rubocop:enable Metrics/MethodLength
      # rubocop:enable Metrics/PerceivedComplexity

      def edit
        section = Section.find(params[:id])
        if section
          render json: section
        else
          render json: section.errors
        end
      end

      def update
        section = Section.find(params[:id])
        if section.update(section_params)
          render json: section
        else
          render json: section.errors
        end
      end

      def destroy
        section&.destroy # Destroy only section or also steps and ingredients?
        render json: { message: 'Section deleted!' }
      end

      private

      # rubocop:todo Metrics/MethodLength
      def save_steps(record, section_obj) # rubocop:todo Metrics/AbcSize, Metrics/MethodLength
        save_succeeded = true

        # return true unless record[:steps].present?

        updated_step_ids = []

        if record[:steps].present?

          record[:steps].each do |step|
            step_obj = Step.find_by_id(step[:id])
            if step_obj
              save_succeeded = false unless step_obj.update(step_params(step))
              tr = step_obj
            else
              step[:section_id] = record[:id]
              tr = Step.new(step_params(step))
              save_succeeded = false unless tr.save
            end

            # save array of step ids created/updated
            updated_step_ids << tr.id

            # @targetrecords << tr
          end
        end

        # clean steps(remove steps that were removed)
        # option to remove steps that were not updated?
        remove_steps(updated_step_ids, section_obj)

        save_succeeded
      end
      # rubocop:enable Metrics/MethodLength

      def save_ingredients(record, section_obj) # rubocop:todo Metrics/AbcSize, Metrics/MethodLength
        save_succeeded = true

        # return true unless section[:recipe_ingredients].present?

        updated_ingredient_ids = []

        if record[:recipe_ingredients].present?
          record[:recipe_ingredients].each do |recipe_ingredient|
            recipe_ingredient_obj = RecipeIngredient.find_by_id(recipe_ingredient[:id])
            if recipe_ingredient_obj
              save_succeeded = false unless recipe_ingredient_obj.update(recipe_ingredient_params(recipe_ingredient))
              tr = recipe_ingredient_obj
            else
              recipe_ingredient[:section_id] = record[:id]
              tr = RecipeIngredient.new(recipe_ingredient_params(recipe_ingredient))
              save_succeeded = false unless tr.save
            end

            # save array of recipe ingredient ids created/updated
            updated_ingredient_ids << tr.id
          end
        end

        # clean recipe_ingredients
        remove_recipe_ingredients(updated_ingredient_ids, section_obj)

        save_succeeded
      end

      def save_equipments(record, section_obj) # rubocop:todo Metrics/AbcSize, Metrics/MethodLength
        save_succeeded = true

        # return true unless section[:recipe_equipments].present?

        updated_recipe_equipment_ids = []

        if record[:recipe_equipments].present?
          record[:recipe_equipments].each do |recipe_equipment|
            recipe_equipment_obj = RecipeEquipment.find_by_id(recipe_equipment[:id])
            if recipe_equipment_obj
              save_succeeded = false unless recipe_equipment_obj.update(recipe_equipment_params(recipe_equipment))
              tr = recipe_equipment_obj
            else
              recipe_equipment[:section_id] = record[:id]
              tr = RecipeEquipment.new(recipe_equipment_params(recipe_equipment))
              save_succeeded = false unless tr.save
            end

            # save array of recipe ingredient ids created/updated
            updated_recipe_equipment_ids << tr.id
          end
        end

        # clean recipe_ingredients
        section_obj.remove_recipe_equipments(updated_recipe_equipment_ids)

        save_succeeded
      end

      def remove_steps(updated_step_ids, section_obj)
        Rails.logger.debug("Section: #{section_obj}")
        section_obj.steps.each do |step|
          step&.destroy unless step.id.in?(updated_step_ids)
        end
      end

      def step_params(step)
        step.permit(:id, :description, :step_number, :section_id, :recipe_id)
      end

      def remove_recipe_ingredients(updated_ingredient_ids, section_obj)
        Rails.logger.debug("Section: #{section_obj}")
        section_obj.recipe_ingredients.each do |recipe_ingredient|
          recipe_ingredient&.destroy unless recipe_ingredient.id.in?(updated_ingredient_ids)
        end
      end

      def recipe_ingredient_params(recipe_ingredient)
        recipe_ingredient.permit(:id, :recipe_id, :ingredient_id, :uom_id, :quantity, :section_id)
      end

      def recipe_equipment_params(recipe_equipment)
        recipe_equipment.permit(:id, :recipe_id, :equipment_id, :quantity, :uom_id, :section_id)
      end

      def targetrecord_params(record)
        record.permit(:id, :name, :recipe_id, :sort_number, :steps)
      end

      def section_params
        params.permit(:name, :recipe_id, :sort_number)
      end

      def section
        @section ||= Section.find(params[:id])
      end
    end
  end
end
