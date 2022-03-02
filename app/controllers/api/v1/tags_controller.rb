class Api::V1::TagsController < ApplicationController
  def index
    tags = Tag.all.order(id: :asc)
    render json: tags
  end

  def create
    tag = Tag.create!(tag_params)
    if tag
      render json: tag
    else
      render json: tag.errors
    end
  end

  def edit
    tag = Tag.find(params[:id])
    if tag
      render json: tag
    else
      render json: tag.errors
    end
  end

  def update
    tag = Tag.find(params[:id])
    if tag.update(tag_params)
      render json: tag
    else
      render json: tag.errors
    end
  end

  def destroy
    tag&.destroy
    render json: { message: 'Tag deleted!' }
  end

  private

  def tag_params
    params.permit(:name, :color)
  end

  def tag
    @tag ||= Tag.find(params[:id])
  end
end
