$(document).ready(function(){
    $("*[data-toggle='collapse']").on('click',function(){
        $(this).parent().parent().find('.active_panel').removeClass('active_panel');
        $(this).parent().addClass('active_panel');
    });
});