class Block < ApplicationRecord
  resourcify
  belongs_to :step

  def serializable_hash options = nil
    super.merge "type" => type
  end
end
