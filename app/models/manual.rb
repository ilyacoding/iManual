class Manual < ApplicationRecord
  resourcify
  has_many :pages
  has_many :comments, as: :commentable
end
