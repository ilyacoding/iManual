class Step < ApplicationRecord
  resourcify
  belongs_to :manual

  has_many :completed_steps, dependent: :destroy

  has_many :blocks, dependent: :destroy
  validates :name, presence: true

  def ordered_blocks
    blocks.order('priority ASC')
  end
end
