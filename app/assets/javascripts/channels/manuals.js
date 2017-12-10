//= require action_cable
//= require_self
//= require_tree .

$(function () {
    var current_user_id = $('body').data('user-id');
    var comments = $('#comments');
    var title = $('#js-comments-title');
    if (comments.data('id') != null) {
        var App = {};
        App.cable = ActionCable.createConsumer();
        App.global_manual = App.cable.subscriptions.create({
            channel: "CommentsChannel",
            manual_id: comments.data('id')
        },
        {
            received: function(data) {
                title.html(data['title']);
                if (data['user_id'] == current_user_id) {
                  comments.append(data['editable_comment']);
                } else {
                  comments.append(data['static_comment']);
                }
                comments.children("div").last().effect("highlight", {}, 2000);
            }
        });

        $("#new_comment").bind("ajax:complete", function(event,xhr,status) {
            $('#comment_content').val('');
        });
    }
});
