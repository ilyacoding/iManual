class Step < ApplicationRecord
  resourcify
  belongs_to :manual
  has_many :blocks, dependent: :destroy
  has_many :comments, as: :commentable

  def ordered_blocks
    blocks.order('priority ASC')
  end
end
