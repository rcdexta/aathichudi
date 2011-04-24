$(document).ready(function(){
    $('#history_button').click(function(e){
        showLoadIndicator(this);
        $.ajax({
            url: $(this).attr('href'),
            success: function(data){
                $('#history_container').html(data);
            },
            complete: function(){
                hideLoadIndicator();
            }
        });
        e.preventDefault();
    })
});