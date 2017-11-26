class CompletedStep < ApplicationRecord
  belongs_to :completed_manual
  belongs_to :step
  belongs_to :user
end
