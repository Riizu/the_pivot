$( document ).ready(function() {
  var today = new Date();
  $( "#datepicker-checkin" ).datepicker({
    minDate: today
  });

  $('#datepicker-checkout').datepicker({
    minDate: today
  })
});
