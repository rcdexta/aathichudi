$(document).ready(function() {
    var cookie_name = 'aathichudi_intro';
    if (!($.cookie(cookie_name))) {
        $.cookie(cookie_name, 'dont-show-for-one-day', {expires: 1});
        $('#about_site').click();
    }
});