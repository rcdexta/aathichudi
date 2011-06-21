jQuery(document).ready(function(){
  jQuery('#mugavurai').click(function(e){
    jQuery('#mugavurai_content').dialog({
      minWidth: 750,
      height: 800,
      modal: true,
      resizable: false,
      show: 'fade'
    });
    e.stopPropagation();
  });

  jQuery('#about_site').click(function(e){
    jQuery('#about_site_content').dialog({
      minWidth: 850,
      height: 720,
      modal: true,
      show: 'fade'
    });
    e.stopPropagation();
  });

  jQuery('#user_login').click(function(e){
    e.stopPropagation();
  });

  jQuery('.logo').click(function(){
    window.location = "/";
  });
});
