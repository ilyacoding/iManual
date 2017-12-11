module UsersHelper
  def completed_manuals(user)
    user.completed_steps.includes(:manual).map(&:manual).uniq || []
  end
end
