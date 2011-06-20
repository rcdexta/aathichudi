jQuery(document).ready(function(){
  // jQuery('.textile_preview').click(function(){
  //   textile_text = jQuery('#wiki_tamil_long_desc').val();
  //   jQuery.ajax({
  //     url: jQuery(this).attr('url'),
  //     type: 'POST',
  //     data: {text: textile_text},
  //     complete: function(response){
  //       jQuery('#preview_container').html(response.responseText);
  //       jQuery('#preview_container').dialog(
  //         {
  //           minWidth: 700,
  //           maxHeight: 700,
  //           modal: true,
  //           show: 'fade'
  //       });
  //     }
  //   });
  // });

  jQuery('#wiki_tamil_long_desc').observe_field(1, function(){
    var textile_text = jQuery('#wiki_tamil_long_desc').val();
    jQuery.ajax({
      url: jQuery('.textile_preview').attr('url'),
      type: 'POST',
      data: {text: textile_text},
      complete: function(response){
        jQuery('#preview_container').html(response.responseText);
      }
    });
  });
});
