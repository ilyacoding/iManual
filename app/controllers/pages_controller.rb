class PagesController < ApplicationController

  # GET /pages/1
  # GET /pages/1.json
  def show
    respond_to do |format|
      format.html
      format.json {
        render json: @page
      }
    end
  end

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(manual_id: params[:manual_id], priority: 0)

    respond_to do |format|
      if @page.save
        format.html { render @page }
        format.json { render json: @page, status: :created }
      else
        format.json { render json: @manual.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def page_params
    params#.require(:manual_id).permit(:priority)
  end
end
