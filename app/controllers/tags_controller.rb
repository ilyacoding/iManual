class TagsController < ApplicationController
  def index
    if params[:query]
      @tags = ActsAsTaggableOn::Tag.all.where("name LIKE :q", q: "%#{params[:query]}%")
    else
      @tags = ActsAsTaggableOn::Tag.all
    end
    respond_to do |format|
      format.json { render json: @tags }
    end
  end
end