$(document).ready(function() {
    $('.trigger').click(function () {
        var random = $(this).data('rel');
        $("#variant_id_" + random).prop("checked", true);

    });

});

