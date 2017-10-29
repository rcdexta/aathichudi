var cache_selector = null;
var cache_data = null;

function showLoadIndicator(selector){
    cache_selector = selector;
    cache_data = jQuery(selector).html();
    jQuery(selector).html('<img src="/images/ajax-loader.gif" class="loading"/>');
}

function showLineLoadIndicator(selector){
    cache_selector = selector;
    cache_data = jQuery(selector).html();
    jQuery(selector).html('<img src="/images/line-ajax-loader.gif" class="line_loading"/>');
}


function hideLoadIndicator(){
    jQuery(cache_selector).html(cache_data);
}

function hideLineLoadIndicator(){
    hideLoadIndicator();
}

function control_by_cookie(cookie_name, call_back){
    if (!(jQuery.cookie(cookie_name))) {
        jQuery.cookie(cookie_name, 'dont-show-for-one-day', {expires: 1});
        call_back();
    }
}

console.log('loaded application.js')