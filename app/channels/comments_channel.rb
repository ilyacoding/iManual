class CommentsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "manuals_#{params['manual_id']}_channel"
  end
end
