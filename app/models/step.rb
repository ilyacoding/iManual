class Step < ApplicationRecord
  resourcify

  belongs_to :manual
  has_many :completed_steps, dependent: :destroy
  has_many :blocks, dependent: :destroy

  validates :name, presence: true
end
