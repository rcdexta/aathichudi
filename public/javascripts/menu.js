$(document).ready(function(){
    $('#mugavurai').click(function(){
        $('#mugavurai_content').dialog({
            minWidth: 700,
            maxHeight: 700,
            modal: true,
            show: 'fade'
        });
    })
});