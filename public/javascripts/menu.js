$(document).ready(function(){
    $('#mugavurai').click(function(){
        $('#mugavurai_content').dialog({
            minWidth: 700,
            maxHeight: 700,
            modal: true,
            show: 'fade'
        });
    })

    $('#about_site').click(function(){
        $('#about_site_content').dialog({
            minWidth: 700,
            maxHeight: 700,
            modal: true,
            show: 'fade'
        });
    })
});