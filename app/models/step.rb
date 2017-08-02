class Step < ApplicationRecord
  belongs_to :manual
  has_many :blocks, dependent: :destroy

  def ordered_blocks
    blocks.order('priority ASC')
  end
end
