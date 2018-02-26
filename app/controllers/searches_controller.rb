class SearchesController < ApplicationController
  def index
    @manuals = Manual.search(query_params).page(params[:page])
    respond_to do |format|
      format.html
      format.js { render partial: "manuals/more_manuals" }
      format.json { render json: @manuals }
    end
  end

  private

  def query_params
    @query = params[:query] || ""
  end
end
