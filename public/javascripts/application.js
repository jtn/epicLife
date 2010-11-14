$(function() {

    $('a.feat').click(function(event){
        var element = $(this);
        var user_id = $('#stats').data('person_id');
        sendValue = element.data('completed') === true ? '0' : '1';
        $.ajax({
            url: '/people/' + user_id + '/feats/' + element.data('id').toString(), 
            type: 'POST', 
            data: {_method: 'PUT', "feat[completed]": sendValue, "feat[xp]":200000 },
            success: function(data){
                element.data('completed', data.completed);
                element.toggleClass('completed');
                $('#xp_meter').data('current_xp',data.xpTotal)
                .data('level_at_xp',data.levelAtXp);

                update_xp_meter(1500);
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
                    1500, function(){gainer.remove()});
            }})
                //.fadeOut(1500);
        return false;
    });

    function update_xp_meter(duration){    
        var xpMeter = $('#xp_meter');
        var xpBar = xpMeter.data('current_xp')/xpMeter.data('level_at_xp')
            
        //$('#xp_meter div').text('').css('width', xpBar*xpMeter.width()); 
        $('#xp_meter div').text('').animate({
            width: xpBar*xpMeter.width()
                                        }, duration,function(){});  

    }
    update_xp_meter(1)
});// Ready when you are, Sir.
