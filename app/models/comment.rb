class Comment < ApplicationRecord
  resourcify

  belongs_to :user, counter_cache: true
  belongs_to :manual, counter_cache: true

  validates :content, presence: true, length: { maximum: 6000 }

  after_create_commit { CommentBroadcastJob.perform_later(self) }
end
