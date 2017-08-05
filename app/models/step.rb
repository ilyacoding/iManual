class Step < ApplicationRecord
  resourcify
  belongs_to :manual
  has_many :blocks, dependent: :destroy
  has_many :comments, as: :commentable
  after_save ThinkingSphinx::RealTime.callback_for(:manual)

  def ordered_blocks
    blocks.order('priority ASC')
  end

  def blocks_contents
    blocks.collect(&:content).join(' ')
  end
end
