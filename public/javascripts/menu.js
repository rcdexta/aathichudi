jQuery(document).ready(function(){
  jQuery('#mugavurai').click(function(e){
    jQuery('#mugavurai_content').dialog({
      minWidth: 700,
      maxHeight: 700,
      modal: true,
      show: 'fade'
    });
    e.stopPropagation();
  });

  jQuery('#about_site').click(function(e){
    jQuery('#about_site_content').dialog({
      minWidth: 850,
      maxHeight: 700,
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
