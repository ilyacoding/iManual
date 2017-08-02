module StepsHelper
  def previous_step
    Step.where(manual_id: @step.manual.id).where(priority: @step.priority - 1).first
  end

  def next_step
    Step.where(manual_id: @step.manual.id).where(priority: @step.priority + 1).first
  end
end
