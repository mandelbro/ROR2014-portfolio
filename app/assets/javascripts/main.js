
(function($, window ){

$(document).ready(function(){
    // To Top function
    $('.toTop').on('click',function(){
       $("html, body").animate({ scrollTop: 0 }, "slow");
        return false;
    });
  });

})( jQuery, this );

