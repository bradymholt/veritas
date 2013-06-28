var Default = {

	init: function(){
		$('.signup button').click(function(){
			var id = $(this).closest('.signup').attr('signup_id');
			var signup_title = $(this).next().text();
			$('#signups-dialog').dialog({
		      resizable: false,
		      height:750,
		      width: 800,
		      modal: true,
		      title: 'Signup: ' + signup_title,
		      open: function(event, ui) {
				$(this).load('/signups/' + id + '/signup');
			  },
		      buttons: {
		        'Save': function() {
		          $(this).find('form').submit();
		          $(this).dialog( "close" );
		        },
		        Cancel: function() {
		          $( this ).dialog( "close" );
		        }
		      }
		    });
		});

		$('.edit-member a').click(function(){
			var editUrl = $(this).attr('href');
			var names = $(this).closest('.member').find('.names').text();
			$('#edit-member-dialog').dialog({
			  resizable: false,
		      height:750,
		      width: 850,
		      modal: true,
		      title: names,
		      open: function(event, ui) {
				$(this).load(editUrl);
			  },
		      buttons: {
		        'Save': function() {
		          $(this).find('form').append('<input type="hidden" name="redirect_to" value="/" />').submit();
		          $(this).dialog( "close" );
		        },
		        Cancel: function() {
		          $( this ).dialog( "close" );
		        }
		      }
			});

			return false;
		});
	}
};

