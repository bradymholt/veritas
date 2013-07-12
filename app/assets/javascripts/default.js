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
		
		$('#save-contact').click(function(){
			var form = $('form.edit_contact');
			$.ajax({
				type: form.attr('method'),
				url: form.attr('action'),
				data: form.serialize()
			}).done(function() {
				$('#edit-contact-modal').modal('hide');
				window.location.replace('/');
			}).fail(function(jqXHR, textStatus){
				$('#edit-contact-modal .modal-body').html(jqXHR.responseText).scrollTop(0,0);
			});
		});

		$('body').on('hidden', '.modal', function () {
  			$(this).removeData('modal');
  			$(this).find('.modal-body').text("Loading...");
		});
	}
};

