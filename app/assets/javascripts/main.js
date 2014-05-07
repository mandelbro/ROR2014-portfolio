
(function($, window, undefined ){

  var ready = function (e) {
    // To Top function
    $('.toTop').on('click',function(){
       jQuery("html, body").animate({ scrollTop: 0 }, "slow");
        return false;
    });

    resizeMasthead();

    $(window).on('resize.masthead', resizeMasthead);
  }

  function resizeMasthead () {
    $('.masthead').height($(window).height());
  }

  $(document).ready(ready);
  $(document).on('page:load', ready);

})( window.Zepto || window.jQuery, this );

