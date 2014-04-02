
(function($, window, undefined ){

  function resizeMasthead () {
    $('.masthead').height($(window).height());
  }

  $(document).ready(function(){
    // To Top function
    $('.toTop').on('click',function(){
       jQuery("html, body").animate({ scrollTop: 0 }, "slow");
        return false;
    });

    resizeMasthead();

    $(window).on('resize.masthead', resizeMasthead);
  });

})( window.Zepto || window.jQuery, this );

