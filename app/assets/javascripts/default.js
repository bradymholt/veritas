var Default = {

	init: function(){
		$('.signup a.btn').click(function(){
			var title = $(this).closest('.signup').find('.title').text();
			$('#signup-modal .modal-header h3').text('Signup for ' + title);
		});

		$('#save-signup').click(function(){
			$('form.edit_signup').append('<input type="hidden" name="redirect_to" value="/" />').submit();
			$('#signup-modal').modal('hide');
		});

		$('.member a.edit').click(function () {
		 	var title = $(this).closest('.member').find('h4').text();
			$('#edit-contact-modal .modal-header h3').text(title);
		});

		$('.member a.view-photo').click(function () {
			var title = $(this).closest('.member').find('h4').text();
			$('#contact-photo-modal .modal-header h3').text(title);
		});
		
		$('#save-contact').click(function(){
			$('form.edit_contact').submit();
			$('#edit-contact-modal').modal('hide');
		});

		$('body').on('hidden', '.modal', function () {
  			$(this).removeData('modal');
  			$(this).find('.modal-body').text("Loading...");
		});

		$("#password").focus();
	}
};

