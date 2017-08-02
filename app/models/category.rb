class Category < ApplicationRecord
  has_many :manuals, dependent: :destroy
end
