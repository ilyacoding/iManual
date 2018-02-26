class CategoriesController < ApplicationController
  def index
    respond_to do |format|
      format.json
    end
  end

  def show
    @category = Category.find(params[:id])
    @manuals = @category.manuals.page(params[:page])
  end
end
