class Manual < ApplicationRecord
  resourcify
  belongs_to :user
  has_many :steps
  has_many :comments, as: :commentable
end
