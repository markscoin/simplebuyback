/**
 * Created by Mark on 11/3/14.
 */
$(document).ready(function(){
    $("button").each(function(){
        $(this).click(function(e){
            if($(this).attr('class').indexOf("active_button") != -1) {
                e.stopPropagation();
            }
        });
    });
});

