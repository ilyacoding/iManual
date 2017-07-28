class Manual < ApplicationRecord
  resourcify
  belongs_to :user
  has_many :steps, dependent: :destroy
  has_many :comments, as: :commentable
end
