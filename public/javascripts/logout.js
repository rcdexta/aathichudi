$(document).ready(function(){
  $('#logout_link').click(function(){
    var provider_logout_url = $("input[name='provider_signout_url']").val();
    window.open(provider_logout_url, 'Logout', "status=1");
  });
});
