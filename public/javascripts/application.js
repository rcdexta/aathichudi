var cache_selector = null;
var cache_data = null;

function showLoadIndicator(selector){
    cache_selector = selector;
    cache_data = $(selector).html();
    $(selector).html('<img src="/images/ajax-loader.gif" class="loading"/>');
}

function showLineLoadIndicator(selector){
    cache_selector = selector;
    cache_data = $(selector).html();
    $(selector).html('<img src="/images/line-ajax-loader.gif" class="line_loading"/>');
}


function hideLoadIndicator(){
    $(cache_selector).html(cache_data);
}

function hideLineLoadIndicator(){
    hideLoadIndicator();
}

function control_by_cookie(cookie_name, call_back){
    if (!($.cookie(cookie_name))) {
        $.cookie(cookie_name, 'dont-show-for-one-day', {expires: 1});
        call_back();
    }
}