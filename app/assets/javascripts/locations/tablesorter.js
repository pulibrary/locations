jQuery(function() {
    // tablesorter
    $("table").tablesorter({
        widthFixed: true,
        widgets: ['stickyHeaders', 'filter', 'zebra'],
        widgetOptions: {
          stickyHeaders_offset: 50,
        }
    });
});
