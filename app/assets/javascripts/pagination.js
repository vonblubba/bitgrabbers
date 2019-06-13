(function() {
  jQuery(function() {
    if ($('#infinite-scrolling').size() > 0) {
      $(window).on('scroll', function() {
        var more_posts_url;
        more_posts_url = $('.pagination .next_page').attr('href');
        if (more_posts_url && $(window).scrollTop() > $(document).height() - $(window).height() - 60) {
          $('.pagination').html('<img src="images/loading.gif" alt="Loading..." title="Loading..." />');
          $.getScript(more_posts_url);
        }
      });
    }
  });

}).call(this);