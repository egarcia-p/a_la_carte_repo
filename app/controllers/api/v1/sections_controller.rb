# rubocop:todo Style/Documentation
class Api::V1::SectionsController < ApplicationController # rubocop:todo Metrics/ClassLength, Style/Documentation
  # rubocop:enable Style/Documentation
  %i[recipe_id].each do |attribute|
    define_method :"find_by_#{attribute}" do
      sections = Section.includes(:steps, :recipe_ingredients, :recipe_equipments).where("#{attribute}": params[:id])
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
        save_succeeded = false unless save_ingredients(record)
        save_succeeded = false unless save_equipments(record)
        tr = record
      else
        tr = Section.new(targetrecord_params(record))
        save_succeeded = false unless tr.save
        if save_succeeded
          record[:id] = tr.id
          save_succeeded = false unless save_steps(record, tr)
          save_succeeded = false unless save_ingredients(record)
          save_succeeded = false unless save_equipments(record)
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
  # rubocop:todo Naming/VariableName
  # rubocop:todo Naming/MethodParameterName
  def save_steps(record, sectionObj) # rubocop:todo Metrics/AbcSize, Metrics/MethodLength, Naming/MethodParameterName, Naming/VariableName
    # rubocop:enable Naming/MethodParameterName
    # rubocop:enable Naming/VariableName
    save_succeeded = true

    # return true unless record[:steps].present?

    updatedStepIds = [] # rubocop:todo Naming/VariableName

    if record[:steps].present?

      record[:steps].each do |step|
        stepObj = Step.find_by_id(step[:id]) # rubocop:todo Naming/VariableName
        if stepObj # rubocop:todo Naming/VariableName
          save_succeeded = false unless stepObj.update(step_params(step)) # rubocop:todo Naming/VariableName
          tr = stepObj # rubocop:todo Naming/VariableName
        else
          step[:section_id] = record[:id]
          tr = Step.new(step_params(step))
          save_succeeded = false unless tr.save
        end

        # save array of step ids created/updated
        updatedStepIds << tr.id # rubocop:todo Naming/VariableName

        # @targetrecords << tr
      end
    end

    # clean steps(remove steps that were removed)
    # option to remove steps that were not updated?
    remove_steps(updatedStepIds, sectionObj) # rubocop:todo Naming/VariableName

    save_succeeded
  end
  # rubocop:enable Metrics/MethodLength

  def save_ingredients(section) # rubocop:todo Metrics/MethodLength
    save_succeeded = true

    return true unless section[:recipe_ingredients].present?

    section[:recipe_ingredients].each do |recipe_ingredient|
      recipeIngredientObj = RecipeIngredient.find_by_id(recipe_ingredient[:id]) # rubocop:todo Naming/VariableName
      if recipeIngredientObj # rubocop:todo Naming/VariableName
        # rubocop:todo Naming/VariableName
        save_succeeded = false unless recipeIngredientObj.update(recipe_ingredient_params(recipe_ingredient))
        # rubocop:enable Naming/VariableName
        tr = recipe_ingredient # rubocop:todo Lint/UselessAssignment
      else
        recipe_ingredient[:section_id] = section[:id]
        tr = RecipeIngredient.new(recipe_ingredient_params(recipe_ingredient))
        save_succeeded = false unless tr.save
      end

      # @targetrecords << tr
    end

    save_succeeded
  end

  def save_equipments(section) # rubocop:todo Metrics/MethodLength
    save_succeeded = true

    return true unless section[:recipe_equipments].present?

    section[:recipe_equipments].each do |recipe_equipment|
      recipeEquipmentObj = RecipeEquipment.find_by_id(recipe_equipment[:id]) # rubocop:todo Naming/VariableName
      if recipeEquipmentObj # rubocop:todo Naming/VariableName
        # rubocop:todo Naming/VariableName
        save_succeeded = false unless recipeEquipmentObj.update(recipe_equipment_params(recipe_equipment))
        # rubocop:enable Naming/VariableName
        tr = recipe_equipment # rubocop:todo Lint/UselessAssignment
      else
        recipe_equipment[:section_id] = section[:id]
        tr = RecipeEquipment.new(recipe_equipment_params(recipe_equipment))
        save_succeeded = false unless tr.save
      end

      # @targetrecords << tr
    end

    save_succeeded
  end

  # rubocop:todo Naming/VariableName
  def remove_steps(updatedStepIds, sectionObj) # rubocop:todo Naming/MethodParameterName, Naming/VariableName
    # rubocop:enable Naming/VariableName
    Rails.logger.info("Section: #{sectionObj}") # rubocop:todo Naming/VariableName
    sectionObj.steps.each do |step| # rubocop:todo Naming/VariableName
      step&.destroy unless step.id.in?(updatedStepIds) # rubocop:todo Naming/VariableName
    end
  end

  def step_params(step)
    step.permit(:id, :description, :step_number, :section_id, :recipe_id)
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
