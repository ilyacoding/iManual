class Manual < ApplicationRecord
  resourcify
  acts_as_taggable
  ratyrate_rateable 'rating'
  validates :name, presence: true
  belongs_to :user, counter_cache: true
  belongs_to :category, counter_cache: true
  has_many :steps, dependent: :destroy
  has_many :comments, dependent: :destroy

  def ordered_steps
    steps.order('priority ASC')
  end

  def nested_contents
    steps.map { |step| (step.blocks.collect(&:content) << step.name).join(' ') }.join(' ')
  end
end
