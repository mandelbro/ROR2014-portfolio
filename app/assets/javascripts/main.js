
(function($, window, document, undefined){

$(document).ready(function(){

    // Masthedad  full height
    $('.home .masthead').css({height: screen.availHeight});
    // To Top function
    $('.toTop').on('click',function(){
       $("html, body").animate({ scrollTop: 0 }, "slow");
        return false;
    });
    // Portfolio
      $('ul#filter a').click(function(){
        // Remove class
        $('ul#filter .current').removeClass('current');
        // Add parent class
        $(this).parent().addClass('current');
        // find same class of menu
        var filterVal = $(this).text().toLowerCase().replace(' ','-');
        if(filterVal == 'all') {
          // If click all execute this
          $('ul#portfolio li').animate({
            opacity: 1
          },1000);
        }else{
          // Each all and filter values
          $('ul#portfolio li').each(function() {
            // Hide
            if(!$(this).hasClass(filterVal)) {
              $(this).animate({
                opacity: 0.1
              },1000);
              // Show
            }else{
              $(this).animate({
                opacity: 1
              },1000);
            }
          });
        }
        return false;
      });
  });

})(jQuery, window, document);

