class Manual < ApplicationRecord
  resourcify
  acts_as_taggable
  ratyrate_rateable "rating"
  belongs_to :user, :counter_cache => true
  belongs_to :category, :counter_cache => true
  has_many :steps, dependent: :destroy
  has_many :comments, dependent: :destroy
  after_save ThinkingSphinx::RealTime.callback_for(:manual)

  def ordered_steps
    steps.order('priority ASC')
  end

  def nested_contents
    steps.map { |step| (step.blocks.collect(&:content) << step.name).join(' ') }.join(' ')
  end
end
