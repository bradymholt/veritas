var Settings = {
	initEdit: function(){
		App.setupCheckboxInputDependency($('#contact-queue-visitors'), $('#contact-queue-visitor-weeks'));
		App.setupCheckboxInputDependency($('#contact-queue-members'), $('#contact-queue-members-weeks'));
		App.setupCheckboxInputDependency($('#roster-inactivate'), $('#roster-inactivate-weeks'));
		App.setupCheckboxInputDependency($('#use_google_calendar_check'), $('#google_calendar_fields'));
		App.setupCheckboxInputDependency($('#use_google_analytics'), $('#google_analytics_fields'));
	}
};