jQuery(document).ready(function(){
  jQuery('#wiki_tamil_long_desc, #wiki_version_tamil_long_desc').observe_field(1, function(){
    var textile_text = jQuery(this).val();
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
