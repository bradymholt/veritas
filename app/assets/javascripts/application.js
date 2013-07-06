// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.datepicker
//= require jquery-ui.multidatespicker
//= require jquery.flot
//= require jquery.flot.resize
//= require jquery.flot.time
//= require bootstrap-tooltip
//= require bootstrap-modal
//= require bootstrap-alert
//= require bootstrap-tab
//= require ckeditor/init
//= require_tree .
//= requuire_self

var App = {
	setupCheckboxInputDependency: function(checkbox, container){
		
		var inputs = $('input,select', container);
		var defaultValue = inputs.val();
		
		App.checkboxInputDependencyRefresh(checkbox, container, inputs);

		checkbox.change(function(){
			if ($(this).prop('checked')){
				inputs.val(defaultValue);
				container.show();
			}
			else{
				inputs.val('');
				container.hide();
			}
		});
	},
	checkboxInputDependencyRefresh: function(checkbox, container, inputs){
		var hasValue = inputs.val() != '';	
		checkbox.prop('checked', hasValue); 
		container.css('display', hasValue ? 'block' : 'none' );
	}
};
