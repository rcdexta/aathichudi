jQuery(document).ready(function(){
  if (jQuery('#contact_us').length > 0){
    jQuery('#contact_us').click(function(e){
      jQuery.get(jQuery(this).attr('url'), function(data){
        jQuery('#comments_form').html(data);
        jQuery('#comments_form').dialog({
          minWidth: 650,
          height: 700,
          modal: true,
          resizable: false,
          show: 'fade'
        });
      });
      e.stopPropagation();
    });
  }

  jQuery('#comments_form form').live('ajax:success', function(){
    jQuery('#comments_form').dialog('close');
    alert('உங்கள் கருத்துக்களை பகிர்ந்து கொண்டதற்கு நன்றி.');
  });
});
