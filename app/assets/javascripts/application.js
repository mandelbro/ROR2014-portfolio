// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require zepto
//= require foundation
//= require fastclick
//= require placeholder
//= require_tree .
// only use Zepto if it's supported
window.Zepto = '__proto__' in {} ? window.Zepto : undefined;
// Initialize Foundation
(function($){
  $(function(){ $(document).foundation(); });
})(jQuery);

$(document).ajaxError(function (e, xhr, settings, exception) {
  console.log(e);
  console.log(exception);
});
