var Signups = {
	initEdit: function(){
	 $('#signup-dates').multiDatesPicker({
	    dateFormat: "yy-mm-dd",
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

	  $('#signup_send_reminder_email').change(function(){
	    Signups.setupReminderDays();
	  });

	  Signups.updateCalendar();
	  Signups.setupReminderDays();
	  Signups.setupSlots();
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
	setupReminderDays: function() {
	  $('#reminder_days_container').css('display', $('#signup_send_reminder_email').is(':checked') ? 'block' : 'none');
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