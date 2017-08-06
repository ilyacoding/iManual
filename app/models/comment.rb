class Comment < ApplicationRecord
  resourcify
  validates :content, presence: true, length: {minimum: 3, maximum: 2000}
  after_create_commit { CommentBroadcastJob.perform_later(self) }

  belongs_to :user, :counter_cache => true
  belongs_to :manual, counter_cache: true
end
