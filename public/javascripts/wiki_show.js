$(document).ready(function(){
    $('#history_button').click(function(e){
        e.preventDefault();
        showLoadIndicator(this);
        $.ajax({
            url: $(this).attr('url'),
            success: function(data){
                $('#history_container').html(data);
            },
            complete: function(){
                hideLoadIndicator();
            }
        });
    })

    $('#history_container').delegate('div.close_button', 'click', function(){
      $('#history_container').html('');
    });
});
