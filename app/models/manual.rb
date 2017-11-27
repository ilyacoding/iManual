class Manual < ApplicationRecord
  include SearchCop

  resourcify
  acts_as_taggable
  ratyrate_rateable 'rating'

  search_scope :search do
    attributes :name, :created_at
    attributes steps: ["steps.name"]
    attributes blocks: ["blocks.content"]
  end

  validates :name, presence: true

  belongs_to :user, counter_cache: true
  belongs_to :category, counter_cache: true

  has_many :completed_manuals, dependent: :destroy

  has_many :steps, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :blocks, through: :steps

  def ordered_steps
    steps.order('priority ASC')
  end

  def user_completed_manual(user)
    completed_manuals.where(user: user).first
  end
end
