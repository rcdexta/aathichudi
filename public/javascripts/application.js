var cache_selector = null;
var cache_data = null;
function showLoadIndicator(selector){
    cache_selector = selector;
    cache_data = $(selector).html();
    $(selector).html('<img src="/images/ajax-loader.gif?12" class="loading"/>');
}

function hideLoadIndicator(){
    $(cache_selector).html(cache_data);
}