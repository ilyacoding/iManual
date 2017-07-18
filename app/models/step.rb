class Step < ApplicationRecord
  has_many :blocks
  has_many :comments, as: :commentable
  belongs_to :page
end
