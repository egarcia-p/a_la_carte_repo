class Api::V1::SectionsController < ApplicationController
  %i[recipe_id].each do |attribute|
    define_method :"find_by_#{attribute}" do
      sections = Section.includes(:steps).where("#{attribute}": params[:id])
      if sections
        render json: sections.to_json(include: :steps)
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

  def save_multiple
    @targetrecords = []
    save_succeeded = true
    params[:targetrecord].each do |record|
      section = Section.find_by_id(record[:id])
      if section
        save_succeeded = false unless section.update(targetrecord_params(record))
        save_succeeded = false unless save_steps(record)
        tr = record
      else
        tr = Section.new(targetrecord_params(record))
        save_succeeded = false unless tr.save
        if save_succeeded
          record[:id] = tr.id
          save_succeeded = false unless save_steps(record)
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

  def save_steps(section)
    save_succeeded = true

    return true unless section[:steps].present?

    section[:steps].each do |step|
      stepObj = Step.find_by_id(step[:id])
      if stepObj
        save_succeeded = false unless stepObj.update(step_params(step))
        tr = step
      else
        step[:section_id] = section[:id]
        tr = Step.new(step_params(step))
        save_succeeded = false unless tr.save
      end

      # @targetrecords << tr
    end

    save_succeeded
  end

  def step_params(step)
    step.permit(:id, :description, :step_number, :section_id, :recipe_id)
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
