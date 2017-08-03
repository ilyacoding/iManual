jQuery(function() {});

$(window).scroll(function() {
    if ($(window).scrollTop() > $(document).height() - $(window).height() - 50) {
        var url = $('.pagination a').attr('href');
        if (url)
        {
            $('.pagination').text("Fetching more Manuals...");
            $.getScript(url);
        }
    }
});
