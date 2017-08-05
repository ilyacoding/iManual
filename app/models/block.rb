class Block < ApplicationRecord
  resourcify
  belongs_to :step
  after_save ThinkingSphinx::RealTime.callback_for(:manual, [:step, :manual])

  def serializable_hash options = nil
    super.merge "type" => type
  end
end
