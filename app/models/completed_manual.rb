class CompletedManual < ApplicationRecord
  belongs_to :manual
  belongs_to :user

  has_many :completed_steps, dependent: :destroy
end
