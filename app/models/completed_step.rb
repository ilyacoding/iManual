class CompletedStep < ApplicationRecord
  belongs_to :user
  belongs_to :step
  belongs_to :completed_manual
end
