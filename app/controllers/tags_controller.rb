class TagsController < ApplicationController
  def index
    if params[:query]
      @tags = ActsAsTaggableOn::Tag.where("name LIKE :q", q: "%#{params[:query].downcase}%")
    else
      @tags = ActsAsTaggableOn::Tag.all
    end

    respond_to do |format|
      format.json { render json: @tags }
    end
  end
end
