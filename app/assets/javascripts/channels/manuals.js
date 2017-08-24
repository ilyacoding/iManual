
//= require cable
//= require_self
//= require_tree .

$(function () {
    this.App = {};
    var comments = $('#comments');
    // if (comments.data('id') != null)
    // {
        App.cable = ActionCable.createConsumer();
        App.global_manual = App.cable.subscriptions.create({
            channel: "CommentsChannel",
            manual_id: comments.data('id')
        },
        {
            connected: function() {},
            disconnected: function() {},
            received: function(data) {
                comments.append(data['comment']);
                comments.children("div").last().effect("highlight", {}, 2000);
            }
        });

        $("#new_comment").bind("ajax:complete", function(event,xhr,status){
            $('#comment_content').val('');
        });
    // }
});
