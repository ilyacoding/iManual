class Category < ApplicationRecord
  has_many :manuals, dependent: :destroy

  alias_attribute :name, :slug
end
