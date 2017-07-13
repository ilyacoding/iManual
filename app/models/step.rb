class Step < ApplicationRecord
  has_many :blocks
  belongs_to :page
end
