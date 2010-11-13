$(function() {
    $('a.feat').click(function(event){
        var element = $(this);
        sendValue = element.data('completed') === true ? '0' : '1';
        $.ajax({
            url: element.data('id').toString(), 
            type: 'POST', 
            data: {_method: 'PUT', "feat[completed]": sendValue },
            success: function(event){element.toggleClass('completed')}});
        return false;
    });// Ready when you are, Sir.
});
