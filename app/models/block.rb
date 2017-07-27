class Block < ApplicationRecord
  belongs_to :step
  def serializable_hash options = nil
    super.merge "type" => type
  end
end
