$(document).ready(function() {
  // 'history: true' is broken with jqeury 1.4.3, so dropped until fixed
  $("ul#featureTabs").tabs("div#featurePanes > div", { effect: 'fade', fadeOutSpeed: 'medium' });
});
