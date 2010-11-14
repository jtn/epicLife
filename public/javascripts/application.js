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
                .data('next_level_ratio',data.next_level_ratio);
                $('#extra_life').data('extra_life', data.extra_life);
                update_xp_meter(1500,data.has_leveled);
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

    function update_xp_meter(duration, has_leveled){    
        var xpMeter = $('#xp_meter');
        
        if (has_leveled) {
            $('#xp_meter div').text('').animate({
            width: xpMeter.width()
                                        }, 
            duration,function(){update_extra_life()});
            duration = 0;
        }
        //$('#xp_meter div').text('').css('width', xpBar*xpMeter.width()); 
        $('#xp_meter div').text('').animate({
                    width: xpMeter.data('next_level_ratio')*xpMeter.width()
                                        }, 
                    duration,function(){update_extra_life()});  

    };
    function update_extra_life(){
        if($('#extra_life').data('extra_life'))
            $('#extra_life').text('Extraliv: ' + $('#extra_life').data('extra_life'));
    };
    update_xp_meter(1,false);
});// Ready when you are, Sir.
