var Signups = {
	initEdit: function(){
		$('#signup-dates').multiDatesPicker({
			dateFormat: "yy-mm-dd",
			minDate: '-0d',
			onSelect: function(date) {
	      $('#signup-dates').multiDatesPicker('addDates', date ); //prevent unselect
	      Signups.addDateSlot(date);
	  }
	});

		$('#slots tbody').on('click', '.removeSlot', function(event) {
			var slotRow = $(this).closest('tr');
			var familyId = slotRow.find('select').val();
			if (familyId === '' || confirm('There is a family signed up for this slot.\nAre you sure you want to remove it?')) {
				slotRow.find('.destroy').val('1');
				slotRow.removeClass('slot').hide();
				Signups.updateCalendar();
				Signups.setupSlots();
			}
		});

		App.setupCheckboxInputDependency($('#send_reminder_email'), $('#reminder_days_container'));
		App.setupCheckboxInputDependency($('#send_signup_email'), $('#signup_email_to_container'));

		Signups.updateCalendar();
		Signups.initSignup();
		Signups.setupSlots();
	},
	initSignup: function(){
		if ($('#reminder_note').length > 0) {
			$('#slots tbody').on('change', '.contact', function(){
				var needEmailAlertContainer = $(this).next();
				needEmailAlertContainer.empty();
				if ($('option:selected', this).attr('data-has-email') == 'false') {
					var needEmailAlert = $('<a href="#" class="email-needed-alert" data-toggle="tooltip" title="There is no email address on file for this contact.  Signup is still allowed but an email should be provided so that a reminder can be sent.  Click [Edit] next to contact on home page to provide an email address."><span class="label label-warning">Email Needed For Reminders</span></a>');
					needEmailAlert.appendTo(needEmailAlertContainer).tooltip();
				}
			});
		}
	},
	addDateSlot: function(date){
		var newSlot = $('.slotTemplate').last().clone();
		var index = new Date().getTime();
		var dateParsed = $.datepicker.parseDate('yy-mm-dd', date);
		newSlot.removeClass('slotTemplate').addClass('slot');
		newSlot.find('input.destroy').attr('value', '').val('');
		newSlot.find('.date').attr('value', date).attr('readonly', true).val(date);
		newSlot.find('.dateDisplay').text($.datepicker.formatDate('mm/dd/yy', dateParsed));
		newSlot.find('input,select').each(function () {
			var name = $(this).attr('name');
			var newName = name.replace(/\[\d\]/, "[" + index + "]");
			$(this).removeAttr('id').attr('name', newName);
		});
		newSlot.appendTo('#slots tbody');

		Signups.setupSlots();
	},
	updateCalendar: function() {
		$('#signup-dates').multiDatesPicker('resetDates', 'picked');
		var slotDates =  $('tr.slot').map(function() { return $(this).find('.date').val()}).get();
		var distinctSlotDates = slotDates.filter(function(value, index, self) { return value != "" && self.indexOf(value) === index; });
		if (distinctSlotDates.length > 0) {
			$('#signup-dates').multiDatesPicker('addDates', distinctSlotDates );
		}
	},
	setupSlots: function() {
		$('#no-slots-message').css('display', $('.slot').length > 0 ? 'none' : 'block');
		$('#slots').css('display', $('.slot').length > 0 ? 'block' : 'none');
		Signups.sortSlots();
	},
	sortSlots: function(){
		$('#slots tbody tr').sort(function(a,b) { 
			var a_val = $(a).find('.date').val();
			var b_val = $(b).find('.date').val();
			if (a_val>b_val){
				return 1;
			}
			if (a_val<b_val){
				return -1;
			}
			return 0;
		}).appendTo('#slots tbody');
	}
};