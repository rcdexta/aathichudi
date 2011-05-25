$(document).ready(function(){
  $('#mugavurai').click(function(e){
    $('#mugavurai_content').dialog({
      minWidth: 700,
      maxHeight: 700,
      modal: true,
      show: 'fade'
    });
    e.stopPropagation();
  });

  $('#about_site').click(function(e){
    $('#about_site_content').dialog({
      minWidth: 850,
      maxHeight: 700,
      modal: true,
      show: 'fade'
    });
    e.stopPropagation();
  });

  $('#user_login').click(function(e){
    e.stopPropagation();
  });

  $('.logo').click(function(){
    window.location = "/";
  });

});

