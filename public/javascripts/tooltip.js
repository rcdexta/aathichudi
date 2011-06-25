jQuery(document).ready(function(){
    for(var i=1;i<=109;i++) {
        var selector = "a[href='/wikis/" + i + "']";
        jQuery(selector).tipsy({gravity: 'w', html: true, opacity: 1.0, offset: 50 });
    }
});
