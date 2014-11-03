$(document).ready(function() {
    $('.trigger').click(function () {
        var random = $(this).data('rel');
        $("#variant_id_" + random).prop("checked", true);
    });

    $('#iphone6plusnav').hover(function(){
       $(this).find('li').css('background-color','red;'); 
    });
    /* Button for the products condition page */
    $('#conditionaccordion').on('click','button',function(){
        $('button').removeClass('active_button');
        $(this).toggleClass('active_button');
    });
});



