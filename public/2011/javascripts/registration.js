$(document).ready(function() {
  toggle_individual_sponsor_as_anonymous($("#individual_sponsor_option_anonymous"));
  function toggle_individual_sponsor_as_anonymous(e) {
	  if ($(e).is(':checked')) {
		  $.each(
			  ['#individual_sponsor_option_link_url', '#individual_sponsor_option_link_label'],
			  function(_, elem) {
 				  $(elem).attr('disabled', true).
					  css('background-color','#efefef').
					  css('color', '#999');
			  });
	  }
	  else {
		  $(':disabled', 'form.edit_individual_sponsor_option').
			  removeAttr('disabled').
			  css('background-color', '#fff').
			  css('color', '#160F0D');
	  }

  };
  $("#individual_sponsor_option_anonymous").click(function() {
	  toggle_individual_sponsor_as_anonymous(this);
  });
});
