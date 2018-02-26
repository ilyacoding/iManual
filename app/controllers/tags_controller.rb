class TagsController < ApplicationController
  def index
    @tags = if params[:query]
              ActsAsTaggableOn::Tag.where("name LIKE :q", q: "%#{params[:query].downcase}%")
            else
              ActsAsTaggableOn::Tag.all
            end

    respond_to do |format|
      format.json { render json: @tags }
    end
  end
end
