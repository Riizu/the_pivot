$( document ).ready(function() {
  var checkInInput = $('#datepicker-checkin');
  var checkOutInput = $('#datepicker-checkout');
  setUpCheckInDatePicker();
  setUpCheckOutDatePicker();
  setUpCheckInListener();

  function setUpCheckInDatePicker() {
    var today = new Date();
    $(checkInInput).datepicker({
      minDate: today
    });
  }

  function setUpCheckOutDatePicker(today) {
    if (today === undefined)
      today = new Date();
    $(checkOutInput).datepicker({
      minDate: today
    });
  }

  function setUpCheckInListener() {
    $(checkInInput).on('change', function() {
      var date = $(checkInInput).val();
      $(checkOutInput).datepicker("destroy");
      if (date === '')
        date = new Date();
      setUpCheckOutDatePicker(date);
    });
  }
});
