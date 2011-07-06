$(document).ready(function(){
  $('#contact_us').click(function(e){
    $.get($(this).attr('url'), function(data){
      $('#comments_form').html(data);
      $('#comments_form').dialog({
        minWidth: 600,
        height: 600,
        modal: true,
        resizable: false,
        show: 'fade'
      });
    });
    e.stopPropagation();
  });

  $('#comments_form form').live('ajax:success', function(){
    $('#comments_form').dialog('close');
    alert('உங்கள் கருத்துக்களை பகிர்ந்து கொண்டதற்கு நன்றி.');
  });
});
