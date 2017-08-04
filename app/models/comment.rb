class Comment < ApplicationRecord
  validates :content, presence: true, length: {minimum: 3, maximum: 2000}
  belongs_to :user
  belongs_to :manual, counter_cache: true
  after_create_commit { CommentBroadcastJob.perform_later(self) }
end
