class CategoriesController < ApplicationController
  before_action :set_category, only: [:show]

  def index
    respond_to do |format|
      format.json { render json: Category.all }
    end
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    @manuals = @category.manuals.page params[:page]
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end
end
