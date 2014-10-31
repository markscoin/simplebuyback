$(document).ready(function() {
    $('.trigger').click(function () {
        var random = $(this).data('rel');
        $("#variant_id_" + random).prop("checked", true);
    }); 
});


$(document).ready(function(){
   $('ul.dropdown-menu').on("mouseenter",function(){
      $(this).find('.dropdown-menu').css({"display": "inline-flex" }); 
   }).on("mouseleave", function(){
      $(this).find('.dropdown-menu').css({"display": "none"}); 
   });
});
