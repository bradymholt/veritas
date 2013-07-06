var Attendance = {
  init: function(){
     $('.date_link').click(function(){
        Attendance.selectDate($(this));
      });

      $('input.present').change(function(){
        var date = $('#attendance_date li.active a.date_link').attr('date');
        Attendance.save(date, $(this).attr('contact_id'), $(this).prop('checked'));
      });

      Attendance.selectDate($('#attendance_date .date_link').first());
  },
  initMobile: function(date){
      Attendance.load(date, function(checkbox){
          checkbox.checkboxradio().checkboxradio('refresh');
      });

    $('input.present').change(function(){
      Attendance.save(date, $(this).attr('contact_id'), $(this).prop('checked'));
    });
  },
  selectDate: function(dateLink){
     $('#attendance_date li').removeClass('active');
     dateLink.closest('li').addClass('active');
     Attendance.load(dateLink.attr('date'));
  },
  load: function(date, checkboxSetCallback) {
    $('input.present').prop('checked', false);
    $.getJSON('/attendances/' + date, function(data) {
      $.each(data, function(key, val) {
        var checkbox =  $('input.present[contact_id="' + val.contact_id + '"]');
        checkbox.prop('checked', val.present)
        if (checkboxSetCallback){
          checkboxSetCallback(checkbox);
        }
      });
    });
  },
  save: function(date, contact_id, present){
    var request = { 'present' : present }
    $.ajax({
      url: 'attendances/' + date + '/' + contact_id,
      type: 'PUT',
      data: JSON.stringify(request),
      contentType: 'application/json'
     }).done(function(data){
        console.log('done');
     }).fail(function(jqXHR, textStatus) {
        console.log('fail');
     });
  }
};