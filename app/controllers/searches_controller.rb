class SearchesController < ApplicationController
  before_action :set_query, only: [:index]
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
    @manuals = Manual.search @query, :page => params[:page], :per_page => 5
  end

  def set_query
    @query = ThinkingSphinx::Query.escape(params[:query] || "")
  end
end
