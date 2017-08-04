class Manual < ApplicationRecord
  resourcify
  acts_as_taggable
  ratyrate_rateable "rating"
  belongs_to :user
  belongs_to :category, :counter_cache => true
  has_many :steps, dependent: :destroy
  has_many :comments, dependent: :destroy

  def ordered_steps
    steps.order('priority ASC')
  end
end
