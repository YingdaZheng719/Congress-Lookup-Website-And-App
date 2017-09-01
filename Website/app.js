$("#nav_primary_toggle").click(function(e) {
    e.preventDefault();
    $('#nav_primary').toggleClass("sidebar_toggle");
    $('#sec_content').toggleClass("content_toggle");
    $('#nav_primary_ul').toggleClass("sidebar_ul_toggle");
    $('#nav_primary_ul li').toggleClass("sidebar_li_toggle");
});


