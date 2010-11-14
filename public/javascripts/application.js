$(function() {

    $('a.feat').click(function(event){
        var element = $(this);
        sendValue = element.data('completed') === true ? '0' : '1';
        $.ajax({
            url: element.data('id').toString(), 
            type: 'POST', 
            data: {_method: 'PUT', "feat[completed]": sendValue, "feat[xp]":200000 },
            success: function(data){
                element.toggleClass('completed');
                var gainer = $('<div class="xpGained">' + data.xpGained + '</div>'); 
                var elementPosition = element.position();
                gainer.css('top', elementPosition.top);
                gainer.css('left', elementPosition.left + element.width()/2);
                element.after(gainer);
                gainer.animate(
                    {
                        top: '-=50',
                        opacity: 0
                    }, 
                    1500, function(){});
            }})
                //.fadeOut(1500);
        return false;
    });
});// Ready when you are, Sir.
