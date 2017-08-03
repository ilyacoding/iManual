class Manual < ApplicationRecord
  acts_as_taggable
  resourcify
  belongs_to :user
  belongs_to :category, :counter_cache => true
  has_many :steps, dependent: :destroy
  has_many :comments, as: :commentable

  def ordered_steps
    steps.order('priority ASC')
  end
end
