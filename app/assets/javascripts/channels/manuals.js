//= require cable
//= require_self
//= require_tree .

$(function () {
    this.App = {};

    App.cable = ActionCable.createConsumer();

    var comments = $('#comments');

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
        },
        send_message: function(data, manual_id) {
            return this.perform('send_message', {
                content: data,
                manual_id: manual_id
            });
        }
    });

    $('#new_comment').submit(function(e) {
        e.preventDefault();
        var $this, textarea;
        $this = $(this);
        textarea = $this.find('#comment_content');
        if ($.trim(textarea.val()).length > 1) {
            App.global_manual.send_message(textarea.val(), comments.data('id'));
            textarea.val('');
        }
        return false;
    });
});
// App.messages = App.cable.subscriptions.create('CommentsChannel', {
//     received: function(data) {
//
//         alert(JSON.stringify(data));
//         // $("#messages").removeClass('hidden')
//         // return $('#messages').append(this.renderMessage(data));
//     },
//
//     renderMessage: function(data) {
//         return "<p> <b>" + data.user + ": </b>" + data.message + "</p>";
//     }
// });
