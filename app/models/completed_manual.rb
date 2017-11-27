class CompletedManual < ApplicationRecord
  belongs_to :user
  belongs_to :manual

  has_many :completed_steps, dependent: :destroy
end
