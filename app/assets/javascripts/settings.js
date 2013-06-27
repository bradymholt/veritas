var Settings = {
	defaultContactQueueVisitorWeeks: '1',
	defaultContactQueueMemberWeeks: '3',
	initEdit: function(){
		Settings.setupContactQueueVisitor();
		Settings.setupContactQueueMember();

		$('#contact-queue-visitors').change(function(){
			if ($(this).prop('checked')){
				$('#setting_contact_queue_visitors_present_weeks').val(Settings.defaultContactQueueVisitorWeeks);
			}
			else{
				$('#setting_contact_queue_visitors_present_weeks').val('');
			}

			Settings.setupContactQueueVisitor();
		});

		$('#contact-queue-members').change(function(){
			if ($(this).prop('checked')){
				$('#setting_contact_queue_members_absent_weeks').val(Settings.defaultContactQueueMemberWeeks);
			}
			else{
				$('#setting_contact_queue_members_absent_weeks').val('');
			}

			Settings.setupContactQueueMember();
		});
	},
	setupContactQueueVisitor: function(){
		var hasValue = $('#setting_contact_queue_visitors_present_weeks').val() != '';	
		$('#contact-queue-visitors').prop('checked', hasValue); 
		$('#contact-queue-visitor-weeks').css('display', hasValue ? 'block' : 'none' );
	},
	setupContactQueueMember: function(){
		var hasValue = $('#setting_contact_queue_members_absent_weeks').val() != '';	
		$('#contact-queue-members').prop('checked', hasValue); 
		$('#contact-queue-members-weeks').css('display', hasValue ? 'block' : 'none' );
	}
};