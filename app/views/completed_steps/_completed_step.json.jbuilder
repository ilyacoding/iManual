json.extract! completed_step, :id, :completed_manual_id, :step_id, :user_id, :created_at, :updated_at
json.url completed_step_url(completed_step, format: :json)
