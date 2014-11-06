$(document).ready(function(){
    $('#accordion').find("*[data-toggle='collapse']").on('click',function(){
        var same_div = $(this).parent().hasClass('active_panel');
        $(this).parent().parent().find('.active_panel').removeClass('active_panel');
        if(same_div){
        }
        else {
          $(this).parent().addClass('active_panel');
        }
    });
});

/* Navigation buttons to open nested accordions */

$(document).ready(function(){
    $('ul.custommenu').on('click','li',function(event){
        var first = $(this).parent().data('firstpanel');
        var second = $(this).data('secondpanel');
        var firstcomplete = $('*[data-target="'+"#"+first+'"]'); 
        var secondcomplete = $('*[data-target="'+"#"+second+'"]');
        var finished = $('#' + first);
        $('.in').not($('#menu')).removeClass('in');
        $('.active_panel').removeClass('active_panel');
        firstcomplete.trigger('click');
        secondcomplete.trigger('click');
        firstcomplete.parent().addClass('active_panel');
        secondcomplete.parent().addClass('active_panel');
        if( finished.length ) {
            event.preventDefault();
            $('html, body').animate({
                scrollTop: finished.offset().top
            }, 1000);
        }
    });
});