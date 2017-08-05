class Comment < ApplicationRecord
  resourcify
  validates :content, presence: true, length: {minimum: 3, maximum: 2000}
  after_create_commit { CommentBroadcastJob.perform_later(self) }
  after_save ThinkingSphinx::RealTime.callback_for(:manual, [:manual])
  belongs_to :user
  belongs_to :manual, counter_cache: true
end
