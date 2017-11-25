class SearchesController < ApplicationController
  before_action :set_manuals, only: [:index]

  def index
    respond_to do |format|
      format.html
      format.js
      format.json { render json: @manuals }
    end
  end

  private

  def set_manuals
    @manuals = Manual.search(query).page(params[:page])
  end

  def query
    @query = params[:query] || ""
  end
end
