class Page < ApplicationRecord
  has_many :steps
  belongs_to :manual
end
