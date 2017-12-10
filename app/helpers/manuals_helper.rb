module ManualsHelper
  include ActsAsTaggableOn::TagsHelper

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def resource_class
    User
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def default_preview
    asset_path("no_image.jpg")
  end

  def completed_steps_amount(manual, user)
    manual.completed_steps.where(user: user).size
  end

  def manual_completed?(manual, user)
    manual.steps.count == manual.completed_steps.where(user: user).count
  end

  def ordered_steps(manual)
    manual.steps.order('priority ASC')
  end
end
