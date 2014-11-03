$(document).ready(function(){
    $("*[data-toggle='collapse']").on('click',function(){
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
        var first_string = "#"+first;
        var second = $(this).data('secondpanel');
        var second_string = "#"+second;
        var finished = $('#' + first);
        $('.in').removeClass('in');
        $('.active_panel').removeClass('active_panel');
        $('*[data-target="'+first_string+'"]').trigger('click');
        $('*[data-target="'+second_string+'"]').trigger('click');
        $('*[data-target="'+first_string+'"]').parent().addClass('active_panel');
        $('*[data-target="'+second_string+'"]').parent().addClass('active_panel');
        if( finished.length ) {
            event.preventDefault();
            $('html, body').animate({
                scrollTop: finished.offset().top
            }, 1000);
        }
    });
});