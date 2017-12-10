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

  has_many :completed_steps, dependent: :destroy

  has_many :steps, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :blocks, through: :steps
end
