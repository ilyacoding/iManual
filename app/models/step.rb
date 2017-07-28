class Step < ApplicationRecord
  belongs_to :manual
  has_many :blocks, dependent: :destroy
end
