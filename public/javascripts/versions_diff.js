$(document).ready(function(){
    $('#main_container').delegate('#history_info .versions_diff', 'click', function(e){
        e.preventDefault();
        showLineLoadIndicator(this);
        $('#versions_diff_container').load($(this).attr('url'), function(){
            hideLineLoadIndicator();
            $('#versions_diff_container').dialog({
                position: 'top',
                minWidth: 700,
                maxHeight: 500,
                show: 'fade'
            });
        });

    });
});