class CommentsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "manuals_#{params['manual_id']}_channel"
  end

  # def unsubscribed
  #   # Any cleanup needed when channel is unsubscribed
  # end
  #
  # def send_message(data)
  #   current_user.comments.create!(content: data['content'], manual_id: data['manual_id'])
  # end
end
