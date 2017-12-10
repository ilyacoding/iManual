class Category < ApplicationRecord
  resourcify
  has_many :manuals, dependent: :destroy
end
