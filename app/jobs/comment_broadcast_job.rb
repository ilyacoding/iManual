class CommentBroadcastJob < ApplicationJob
  queue_as :default

  def perform(comment)
    ActionCable.server.broadcast "manuals_#{comment.manual.id}_channel", title: render_title(comment.manual),
                                                                         static_comment: render_static_comment(comment),
                                                                         editable_comment: render_editable_comment(comment),
                                                                         user_id: comment.user.id
  end

  private

  def render_static_comment(comment)
    CommentsController.render partial: 'comments/comment_broadcast', locals: { comment: comment }
  end

  def render_editable_comment(comment)
    CommentsController.render partial: 'comments/comment_editable_broadcast', locals: { comment: comment }
  end

  def render_title(manual)
    I18n.t('activerecord.models.comment', count: manual.comments.count)
  end
end
