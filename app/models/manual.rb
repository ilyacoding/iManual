class Manual < ApplicationRecord
  resourcify
  belongs_to :user
  belongs_to :category
  has_many :steps, dependent: :destroy
  has_many :comments, as: :commentable

  def ordered_steps
    steps.order('priority ASC')
  end
end
