class CommentBroadcastJob < ApplicationJob
  queue_as :default

  def perform(comment)
    ActionCable.server.broadcast "manuals_#{comment.manual.id}_channel", comment: render_comment(comment)
  end

  private

  def render_comment(comment)
    # rendered = CommentsController.render.new
    # renderer.instance_variable_set(:@env, {"warden" => env["warden"]})
    CommentsController.render partial: 'comments/comment_broadcast', locals: { comment: comment }
  end
end
