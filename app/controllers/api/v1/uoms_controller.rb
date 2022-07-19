class Api::V1::UomsController < ApplicationController # rubocop:todo Style/Documentation
  def index
    uoms = Uom.all.order(id: :asc)
    render json: uoms
  end

  def create
    uom = Uom.create!(uom_params)
    if uom
      render json: uom
    else
      render json: uom.errors
    end
  end

  def edit
    uom = Uom.find(params[:id])
    if uom
      render json: uom
    else
      render json: uom.errors
    end
  end

  def update
    uom = Uom.find(params[:id])
    if uom.update(uom_params)
      render json: uom
    else
      render json: uom.errors
    end
  end

  def destroy
    uom&.destroy
    render json: { message: 'Uom deleted!' }
  end

  private

  def uom_params
    params.permit(:name, :base_unit, :system, :conversion)
  end

  def uom
    @uom ||= Uom.find(params[:id])
  end
end
