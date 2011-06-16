jQuery(document).ready(function(){
  jQuery('.textile_preview').click(function(){
    textile_text = jQuery('#wiki_tamil_long_desc').val();
    jQuery.ajax({
      url: jQuery(this).attr('url'),
      dataType: 'json',
      type: 'POST',
      contentType: "application/json; charset=utf-8",
      data: JSON.stringify({text: textile_text}),
      complete: function(response){
        jQuery('#preview_container').html(response.responseText);
        jQuery('#preview_container').dialog(
          {
            minWidth: 700,
            maxHeight: 700,
            modal: true,
            show: 'fade'
        });
      }
    });
  });
});
